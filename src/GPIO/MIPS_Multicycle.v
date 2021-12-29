module MIPS_Multicycle(
	input   MAX10_CLK1_50,
	input  [9:0] SW,
	output [8:0] LEDR
);
	wire clk_i, clk;
	wire rst = SW[9];
	wire [31:0] ALUOutput;
			
Clock_Gen	Clock_Gen_inst (
	.inclk0 ( MAX10_CLK1_50 ),
	.c0 ( clk_i )
	);
cont_1s_RCO
	cDiv(
		.mclk(clk_i), .reset(rst),
		.RCO(clk)  // Ripple Carry Output
  	);
	CoreMips core1(
		.clk(clk), 
		.rst(rst), 
		.GPIO_i(SW[7:0]), 
		.ALUOutput(ALUOutput));

	assign LEDR[8:0] = ALUOutput[8:0];

endmodule 

