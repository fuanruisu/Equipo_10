module Control_Unit_TB();
/*logic [1:0] ALUOp_tb, ALUSrcB_tb;*/
//logic [5:0] Funct_tb, Opcode_tb;
logic clk_tb = 0, rst_tb, clk_o;// MemtoReg, RegDst, IorD, PCSrc, ALUSrcA, IRWrite, MemWrite, PCWrite, Branch, RegWrite;
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
    forever #100 clk_tb = !clk_tb;
  end

initial begin
	#0 GPIO_i_tb = 8'd0;
	#0 rst_tb = 0;
	#15 rst_tb  = 1;
	
end

always @(ALUOutput_tb) begin
	$display("ALUOutput = %h",ALUOutput_tb);
end

endmodule
