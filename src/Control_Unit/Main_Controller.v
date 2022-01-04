module Main_Controller(
input [5:0] Opcode, funct,
input clk, rst_n,
output reg IorD, ALUSrcA, IRWrite, MemWrite, PCWrite, RegWrite, Ori, Branch,
output reg [1:0] ALUSrcB, PCSrc, MemtoReg, RegDst,
output reg [2:0] ALUOp
);

reg [4:0] state, next;

localparam [4:0] FETCH = 5'd0,
					 DECODE = 5'd1,
					 PEREX = 5'd2,//PER: peripheral
					 PERWB = 5'd3,
					 BRANCH = 5'd4,
					 JUMP = 5'd5,
					 JAL = 5'd8,
					 ADDIEX = 5'd9,
					 ADDIWB = 5'd10,
					 EXEC = 5'd6,
					 ALUWB = 5'd7,
					 SLTI = 5'd11,				
					 MEMADR = 5'd12,
					 MEMREAD = 5'd13,
					 MEMWB = 5'd14,
					 MEMWRITE = 5'd15,
					 MULT = 5'd16;
					 					 
always @(posedge clk or negedge rst_n)
	if (!rst_n) begin 
		state <= FETCH;
		 
		//PCSrc <= 1'bx;
		end
	else state <= next;
	always @(state or Opcode or Funct) begin
		next <= 4'bx;
		case(state)
			FETCH: begin
				PCWrite <= 1; 
				IorD <= 0; 
				MemWrite <= 0; 
				IRWrite <= 1; 
				RegDst <= 2'bx; 
				MemtoReg <= 2'bx; 
				RegWrite <= 0;
				ALUSrcA <= 0; 
				ALUSrcB <= 2'b01; 
				ALUOp <= 3'b000; 
				PCSrc <= 2'b0;
				Ori<=1'bx;
				Branch<=1'bx;
				next <= DECODE;
			end
			DECODE:begin
				PCWrite <= 0; 
				IorD <= 0; 
				MemWrite <= 0; 
				IRWrite <= 0; 
				RegDst <= 2'bx; 
				MemtoReg <= 2'bx; 
				RegWrite <= 0;
				ALUSrcA <= 0; 
				ALUSrcB <= 2'b11; 
				ALUOp <= 3'b000; 
				PCSrc <= 2'b0;
				Ori<=1'b0;
				Branch<=1'bx;
				
			
				if (Opcode == 6'b0 ) next <= EXEC;
				else if (Opcode == 6'h8 || Opcode == 6'h9) next <= ADDIEX;
				else if (Opcode == 6'hd) next <= PEREX;
				else if (Opcode == 6'h4) next <= BRANCH;
				else if (Opcode == 6'h2) next <= JUMP;
				else if (Opcode == 6'h3) next <= JAL;
				else if (Opcode == 6'ha) next <= SLTI;
				else if (Opcode == 6'h23 || Opcode == 6'h2b) next <= MEMADR;				
				else if (Opcode == 6'h1c) next <= MULT;
			end

			EXEC:begin
				MemtoReg <= 2'b00;
				RegDst <= 2'b00;
				IorD <= 0; 
				PCSrc <= 2'b0; 
				ALUSrcA <= 1; 
				IRWrite <= 0; 
				MemWrite <= 0; 
				PCWrite <= 0; 
				RegWrite <= 0;
				ALUSrcB <= 00;
				ALUOp <= 3'b010;
				Ori<=1'bx;
				Branch<=1'bx;
				if (funct == 6'h8) begin 
					PCSrc <= 2'b11; 
					PCWrite <= 1; 
					next <= FETCH;
				end				
				else next <= ALUWB;
			end
			
			ALUWB:begin
				MemtoReg <= 2'b00;
				RegDst <= 2'b01;
				IorD <= 0; 
				PCSrc <= 2'b0; 
				ALUSrcA <= 0; 
				IRWrite <= 0; 
				MemWrite <= 0; 
				PCWrite <= 0; 				
				RegWrite <= 1;
				ALUSrcB <= 01;
				ALUOp <= 3'b000;
				Ori<=1'bx;
				Branch<=1'bx;
				next <= FETCH;
			end
			ADDIEX: begin
				PCWrite <= 0; 
				IorD <= 1'bx; 
				MemWrite <= 0; 
				IRWrite <= 0; 
				RegDst <= 2'b01; 
				MemtoReg <= 2'bxx;  
				RegWrite <= 0;
				ALUSrcA <= 01; 
				ALUSrcB <= 2'b10; 
				ALUOp <= 3'b000; 
				PCSrc <= 2'bx;
				Ori<=1'b0;
				Branch<=1'bx;
				next <= ADDIWB;
			end
			ADDIWB: begin
				PCWrite <= 0; 
				IorD <= 1'bx; 
				MemWrite <= 0; 
				IRWrite <= 0; 
				RegDst <= 2'b00; 
				MemtoReg <= 2'b00; 
				RegWrite <= 1;
				ALUSrcA <= 1'bx; 
				ALUSrcB <= 2'bx; 
				ALUOp <= 3'bx; 
				PCSrc <= 2'bx;
				Ori<=1'bx;
				Branch<=1'bx;
				next <= FETCH;
			end

		// === ADD ===================
			ADDEX: begin 
				//$display("ADD EX");
				ALUSrcA 	<= 1'b1;  
				ALUSrcB 	<= 2'b00; 
				ALUControl 	<= 3'b010;
				MemtoReg 	<= 1'b0; 
				RegDst 	<= 1'b1;
				Ori		<= 1'b0;

				next <= ADDWB;
			end

			ADDWB: begin
				//$display("ADD WB");
				ALUSrcA 	<= 1'b1;  
				ALUSrcB 	<= 2'b00; 
				ALUControl 	<= 3'b010;
				RegWrite 	<= 1'b1;
				RegDst 	<= 1'b1;
				Ori		<= 1'b0;

				next <= FETCH;
			end

		// === ORI ==================
			PEREX: begin
				PCWrite <= 0; 
				IorD <= 1'bx; 
				MemWrite <= 0; 
				IRWrite <= 0; 
				RegDst <= 2'b00; 
				MemtoReg <= 2'b00; 
				RegWrite <= 1;
				ALUSrcA <= 1'bx; 
				ALUSrcB <= 2'b10; 
				ALUOp <= 3'b011; 
				PCSrc <= 2'bx;
				Ori<=1'b1;
				Branch<=1'bx;
        
				next <= PERWB;
			end

			PERWB: begin
				PCWrite <= 0; 
				IorD <= 1'bx; 
				MemWrite <= 0; 
				IRWrite <= 0; 
				RegDst <= 2'b00; 
				MemtoReg <= 2'b00; 
				RegWrite <= 1;
				ALUSrcA <= 1'bx; 
				ALUSrcB <= 2'bx; 
				ALUOp <= 3'bx; 
				PCSrc <= 2'bx;
				Ori<=1'bx;
				Branch<=1'bx;
				next <= FETCH;
				end
			BRANCH: begin
				PCWrite <= 0; 
				IorD <= 1'bx; 
				MemWrite <= 0; 
				IRWrite <= 0; 
				RegDst <= 2'bx; 
				MemtoReg <= 2'bx;  
				RegWrite <= 0;
				ALUSrcA <= 1; 
				ALUSrcB <= 2'b00; 
				ALUOp <= 3'b001; 
				PCSrc <=2'b01;
				Ori<=1'b0;
				Branch<=1'b1;

				next <= FETCH;
			end

		// === BEQ =================
			BRANCH: begin
				//$display("BEQ");
				PCWrite 	<= 1'b1;
				MemWrite 	<= 1'b0;  
				IorD		<= 1'b0;
				IRWrite 	<= 1'b0;
				PCSrc 		<= 1'b0;
				//Branch 	<= 1'b1;
				ALUSrcA 	<= 1'b1; 
				ALUSrcB 	<= 2'b00;
				ALUControl 	<= 3'b101; 
				RegWrite 	<= 1'b0;
				MemtoReg 	<= 1'b0; 
				RegDst 	<= 1'b0; 
				Jump		<= 1'b0;

				next 	 <= FETCH;
			end
		// === J ====================
			JUMP: begin
				//$display("JUMP");
				PCWrite 	<= 1'b1;
				MemWrite 	<= 1'b0;  
				IorD		<= 1'b0;
				IRWrite 	<= 1'b0;
				PCSrc 		<= 1'b1;
				//Branch 	<= 1'b1;
				ALUSrcA 	<= 1'b1; 
				ALUSrcB 	<= 2'b10;
				ALUControl 	<= 3'bx; 
				RegWrite 	<= 1'b0;
				MemtoReg 	<= 1'b0; 
				RegDst 	<= 1'b0; 
				Jump		<= 1'b1;

				next 	 <= FETCH;
				end
      
			JUMP: begin
				PCWrite <= 1; 
				IorD <= 1'bx; 
				MemWrite <= 0; 
				IRWrite <= 0; 
				RegDst <= 2'bx; 
				MemtoReg <= 2'bx; 
				RegWrite <= 0;
				ALUSrcA <= 1; 
				ALUSrcB <= 2'b00; 
				ALUOp <= 3'b001; 
				PCSrc <=2'b10;
				Ori<=1'b0;
				Branch<=1'b1;
				next <= FETCH;
				end
			JAL: begin
				PCWrite <= 1; 
				IorD <= 1'bx; 
				MemWrite <= 0; 
				IRWrite <= 0; 
				RegDst <= 2'b10; 
				MemtoReg <= 2'b10; 
				RegWrite <= 1;
				ALUSrcA <= 1; 
				ALUSrcB <= 2'b00; 
				ALUOp <= 3'b001; 
				PCSrc <=2'b10;
				Ori<=1'b0;
				Branch<=1'b1;
				next <= FETCH;
				end
			SLTI: begin
				PCWrite <= 0; 
				IorD <= 1'bx; 
				MemWrite <= 0; 
				IRWrite <= 0; 
				RegDst <= 2'b01; 
				MemtoReg <= 2'b00;  
				RegWrite <= 1;
				ALUSrcA <= 01; 
				ALUSrcB <= 2'b10; 
				ALUOp <= 3'b100; 
				PCSrc <= 2'bx;
				Ori<=1'b0;
				Branch<=1'bx;
				next <= ADDIWB;
			end
			// === MEMORY =================
			MEMADR: begin
				ALUSrcA <= 1'b1;
				ALUSrcB <= 2'b10;
				ALUOp <= 3'b000;
				
				if(Opcode == 6'h23) next <= MEMREAD;
				else if (Opcode == 6'h2b) next <= MEMWRITE;
				end
			
			MEMREAD: begin 
				IorD <= 1;
				next <= MEMWB;
				end
				
			MEMWB: begin
				RegDst <= 2'b0;
				MemtoReg <= 2'b01;
				RegWrite <= 2'b01;
				next <= FETCH;
				end
				
			MEMWRITE: begin
				IorD <= 1;
				MemWrite <= 1;
				next <= FETCH;
				end
				
			MULT: begin
				MemtoReg <= 2'b00;
				RegDst <= 2'b00;
				IorD <= 0; 
				PCSrc <= 2'b0; 
				ALUSrcA <= 1; 
				IRWrite <= 0; 
				MemWrite <= 0; 
				PCWrite <= 0; 
				RegWrite <= 0;
				ALUSrcB <= 00;
				ALUOp <= 3'b101;
				Ori<=1'bx;
				Branch<=1'bx;
							
				next <= ALUWB;
			end
						
			endcase
			
	end

endmodule 
