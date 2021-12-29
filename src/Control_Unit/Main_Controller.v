module Main_Controller(
input [5:0] Opcode, Funct,
input clk, rst_n,
output reg MemtoReg, RegDst, IorD, PCSrc, ALUSrcA, IRWrite, MemWrite, PCWrite, RegWrite, Ori, Jump,
output reg [1:0] ALUSrcB,
output reg [2:0] ALUControl 
);

reg [3:0] state, next;

localparam [3:0] 		FETCH 	= 4'd0,
				 DECODE = 4'd1,
				 PEREX  = 4'd2,
				 PERWB  = 4'd3,
				 ADDEX  = 4'd4,
				 ADDWB	= 4'd5,
				 ADDIEX = 4'd9,
				 ADDIWB = 4'd10,
				 EXEC 	= 4'd6,
				 ALUWB  = 4'd7,
				 BRANCH = 4'd8, 
				 JUMP 	= 4'd11;
				
					 
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
				//$display("FETCH");
				PCWrite 	<= 1'b1;
				MemWrite 	<= 1'b0;  
				IorD		<= 1'b0;
				IRWrite 	<= 1'b1;
				PCSrc 		<= 1'b0;
				//Branch 	<= 1'b0;
				ALUSrcA 	<= 1'b0; 
				ALUSrcB 	<= 2'b01;
				ALUControl 	<= 3'b010; 
				RegWrite 	<= 1'b0;
				MemtoReg 	<= 1'b0; 
				RegDst 	<= 1'b0; 
				Jump		<= 1'b0;
				Ori		<= 1'b0;

				next <= DECODE;
			end

			DECODE: begin
				//$display("DECODE");
				PCWrite 	<= 1'b0;
				MemWrite 	<= 1'b0;  
				IorD		<= 1'b0;
				IRWrite 	<= 1'b0;
				PCSrc 		<= 1'b0;
				//Branch 		<= 1'b0;
				ALUSrcA 	<= 1'b0; 
				ALUSrcB 	<= 2'b11;
				ALUControl 	<= 3'b010; 
				RegWrite 	<= 1'b0;
				MemtoReg 	<= 1'b0; 
				RegDst 	<= 1'b0; 
				Jump		<= 1'b0;
				Ori		<= 1'b0;

				if 		(Opcode == 6'h4) next <= BRANCH; //BEQ
				else if (Opcode == 6'h2) next <= JUMP;   //J
				else 	 				 next <= EXEC;

			end

			EXEC:begin
				//$display("EXEC");
				PCWrite 	<= 1'b0;
				MemWrite 	<= 1'b0;  
				IorD		<= 1'b0;
				IRWrite 	<= 1'b0;
				PCSrc 		<= 1'b0;
				//Branch 		<= 1'b0;
				RegWrite 	<= 1'b0;
				Jump		<= 1'b0;

				next <= ALUWB;

				if 		(Opcode == 6'h8) next <= ADDIEX; //ADDI
				else if (Opcode == 6'hd) next <= PEREX; //ORI
				else if (Opcode == 6'h0 && Funct == 6'h20) next <= ADDEX; //ADD
			end
			
			ALUWB:begin
				//$display("WB");
				PCWrite 	<= 1'b0;
				MemWrite 	<= 1'b0;  
				IorD		<= 1'b0;
				IRWrite 	<= 1'b0;
				PCSrc 		<= 1'b0;
				//Branch 		<= 1'b0;
				RegWrite 	<= 1'b1;
				MemtoReg 	<= 1'b0; 
				Jump		<= 1'b0;

				next <= FETCH;
			end

		// === ADDI ==================
			ADDIEX: begin 
				$display("ADDI EX");
				ALUSrcA 	<= 1'b1;  
				ALUSrcB 	<= 2'b10; 
				ALUControl 	<= 3'b010;
				MemtoReg 	<= 1'b0; 
				RegDst 	<= 1'b0;
				Ori		<= 1'b0;

				next <= ADDIWB;
			end

			ADDIWB: begin 
				$display("ADDI WB");
				ALUSrcA 	<= 1'b1;  
				ALUSrcB 	<= 2'b10; 
				ALUControl 	<= 3'b010;
				RegWrite 	<= 1'b1;
				RegDst 	<= 1'b0;
				Ori		<= 1'b0;

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
				//$display("ORI EX");
				ALUSrcA 	<= 1'b1;  
				ALUSrcB 	<= 2'b10; 
				ALUControl 	<= 3'b001;
				MemtoReg 	<= 1'b0; 
				RegDst 	<= 1'b0;
				Ori		<= 1'b1;

				next <= PERWB;
			end

			PERWB: begin
				//$display("ORI WB");
				ALUSrcA 	<= 1'b1;  
				ALUSrcB 	<= 2'b10; 
				ALUControl 	<= 3'b001;
				RegWrite 	<= 1'b1;
				RegDst 	<= 1'b0;
				Ori		<= 1'b1;

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

		// === DEFAULT STATE ============
			default: begin
				//$display("DEFAULT");
				PCWrite 	<= 1'b0;
				MemWrite 	<= 1'b0;  
				IorD		<= 1'b0;
				IRWrite 	<= 1'b0;
				PCSrc 		<= 1'b0;
				//Branch 	<= 1'b0;
				ALUSrcA 	<= 1'b0; 
				ALUSrcB 	<= 2'b00;
				ALUControl 	<= 3'b000; 
				RegWrite 	<= 1'b0;
				MemtoReg 	<= 1'b0; 
				RegDst 	<= 1'b0; 
				Jump		<= 1'b0;
				Ori		<= 1'b0;
			end

		endcase
			
	end

endmodule 
