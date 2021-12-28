module Control_Unit_TB();
/*logic [1:0] ALUOp_tb, ALUSrcB_tb;*/
//logic [5:0] Funct_tb, Opcode_tb;
logic clk_tb = 0, rst_tb, clk_o, en_tb;// MemtoReg, RegDst, IorD, PCSrc, ALUSrcA, IRWrite, MemWrite, PCWrite, Branch, RegWrite;
//wire [2:0] ALUControl_tb;
wire [31:0] ALUOutput_tb;
logic [7:0] GPIO_i_tb;


CoreMips Core1(
.clk(clk_tb), .rst(rst_tb),
.GPIO_i(GPIO_i_tb),
.ALUOutput(ALUOutput_tb)
);



initial // Clock generator
  begin
    forever #1 clk_tb = !clk_tb;
  end

initial begin
	#0 GPIO_i_tb = 8'd0;
	#0 rst_tb = 0;
	#0.5 rst_tb  = 1;
	#5 en_tb = 1;
end



endmodule