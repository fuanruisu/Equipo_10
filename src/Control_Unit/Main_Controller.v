module Main_Controller(
input [5:0] Opcode,
input clk, rst_n,
output reg MemtoReg, RegDst, IorD, PCSrc, ALUSrcA, IRWrite, MemWrite, PCWrite, RegWrite, Ori,//Branch
output reg [1:0] ALUSrcB,
output reg [2:0] ALUOp //Added 1 bit including all calls below.
);

reg [3:0] state, next;

localparam [3:0] FETCH 	= 4'd0,
				 DECODE = 4'd1,
				 PEREX 	= 4'd2,
				 PERWB 	= 4'd3,
				 ADDIEX = 4'd9,
				 ADDIWB = 4'd10,
				 EXEC 	= 4'd6,
				 ALUWB 	= 4'd7,
				 BRANCH = 4'd8, //Added
				 JUMP 	= 4'd11; //Added
				
					 
always @(posedge clk or negedge rst_n)
	if (!rst_n) begin 
		state <= FETCH;
		 
		//PCSrc <= 1'bx;
		end
	else state <= next;
	always @(state) begin
		next <= 4'bx;
		case(state)
			FETCH: begin
				IorD <= 0;
				ALUSrcA <= 0; 
				ALUSrcB <= 2'b01;
				ALUOp <= 3'b000; 
				PCSrc <= 0;
				IRWrite <= 1;
				PCWrite <= 1;
				MemWrite <= 0;  
				RegDst <= 1'bx; 
				MemtoReg <= 1'bx; 
				RegWrite <= 0;
				Ori<=1'bx;
				next <= DECODE;
			end
			DECODE:begin
				ALUSrcA <= 1'bx; 
				ALUSrcB <= 2'bx; 
				PCWrite <= 0; 
				IorD <= 1'bx; 
				MemWrite <= 0; 
				IRWrite <= 0; 
				RegDst <= 1'bx; 
				MemtoReg <= 1'bx; 
				RegWrite <= 0;
				//ALUOp <= 3'b000;
				PCSrc <= 1'bx;
				Ori<=1'bx;
				if (Opcode == 6'b0) next <= EXEC;
				else if (Opcode == 6'h8) next <= ADDIEX;
				else if (Opcode == 6'hd) next <= PEREX;
				else if (Opcode == 6'h4) next <= BRANCH;
				else if (Opcode == 6'h2) next <= JUMP;
			end
			EXEC:begin
				MemtoReg <= 0;
				RegDst <= 0;
				IorD <= 0; 
				PCSrc <= 0; 
				ALUSrcA <= 1; 
				IRWrite <= 0; 
				MemWrite <= 0; 
				PCWrite <= 0; 
				RegWrite <= 0;
				ALUSrcB <= 00;
				ALUOp <= 3'b010;
				Ori<=1'b1;
				next <= ALUWB;
			end
			ALUWB:begin
				RegDst <= 1;
				MemtoReg <= 0;
				RegWrite <= 1;
				
				IorD <= 0; 
				PCSrc <= 0; 
				ALUSrcA <= 2'bx; 
				IRWrite <= 0; 
				MemWrite <= 0; 
				PCWrite <= 0; 	
				ALUSrcB <= 2'bx;
				ALUOp <= 3'bx;
				Ori<=1'bx;
				next <= FETCH;
			end
			ADDIEX: begin
				PCWrite <= 0; 
				IorD <= 1'bx; 
				MemWrite <= 0; 
				IRWrite <= 0; 
				RegDst <= 1'b1; 
				MemtoReg <= 1'b0; 
				RegWrite <= 1;
				ALUSrcA <= 01; 
				ALUSrcB <= 2'b10; 
				ALUOp <= 3'b000;
				PCSrc <= 1'bx;
				Ori<=1'b0;
				next <= ADDIWB;
			end
			ADDIWB: begin
				PCWrite <= 0; 
				IorD <= 1'bx; 
				MemWrite <= 0; 
				IRWrite <= 0; 
				RegDst <= 1'b0; 
				MemtoReg <= 1'b0; 
				RegWrite <= 1;
				ALUSrcA <= 1'bx; 
				ALUSrcB <= 2'bx; 
				ALUOp <= 3'bx; 
				PCSrc <= 1'bx;
				Ori<=1'bx;
				next <= FETCH;
				end
			PEREX: begin
				PCWrite <= 0; 
				IorD <= 1'bx; 
				MemWrite <= 0; 
				IRWrite <= 0; 
				RegDst <= 1'b1; 
				MemtoReg <= 1'b0; 
				RegWrite <= 1;
				ALUSrcA <= 01; 
				ALUSrcB <= 2'b10; 
				ALUOp <= 3'b000; 
				PCSrc <= 1'bx;
				Ori<=1'b1;
				next <= PERWB;
				end
			PERWB: begin
				PCWrite <= 0; 
				IorD <= 1'bx; 
				MemWrite <= 0; 
				IRWrite <= 0; 
				RegDst <= 1'b0; 
				MemtoReg <= 1'b0; 
				RegWrite <= 1;
				ALUSrcA <= 1'bx; 
				ALUSrcB <= 2'bx; 
				ALUOp <= 3'bx; 
				PCSrc <= 1'bx;
				Ori<=1'bx;
				next <= FETCH;
				end
			BRANCH: begin
				PCWrite  <= 0; 
				IorD 	 <= 1'bx; 
				MemWrite <= 0; 
				IRWrite  <= 0; 
				RegDst 	 <= 1'bx; 
				MemtoReg <= 1'bx; 
				RegWrite <= 0;
				ALUSrcA  <= 1; 
				ALUSrcB  <= 2'b00; 
				ALUOp 	 <= 3'b011; 
				PCSrc 	 <= 1;
				Ori	 <=1'b0;
				next 	 <= FETCH;
				end
			JUMP: begin
				PCWrite  <= 0; 
				IorD 	 <= 1'bx; 
				MemWrite <= 0; 
				IRWrite  <= 0; 
				RegDst 	 <= 1'bx; 
				MemtoReg <= 1'bx; 
				RegWrite <= 0;
				ALUSrcA  <= 1; 
				ALUSrcB  <= 2'b10; 
				ALUOp 	 <= 3'b100; 
				PCSrc 	 <= 1;
				Ori	 <=1'b0;
				next 	 <= FETCH;
				end
			endcase
			
	end

endmodule 
