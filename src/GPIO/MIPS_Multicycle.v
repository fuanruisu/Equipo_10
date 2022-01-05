module MIPS_Multicycle(
	input   MAX10_CLK1_50,
	input  [9:0] SW,
	output [8:0] LEDR
);
	wire clk_i, clk;
	wire rst = SW[9];
	wire [31:0] ALUOutput, GPIO_o;
		
	/*Clock_Generator	Clock_Generator_inst (
		.inclk0 (MAX10_CLK1_50),
		.c0 (c0_sig)
	);*/
	
	/*Frequency_Divisor FD(
		.clk_i(c0_sig),
		.reset(rst), 
		.clk_o(clk)
	);*/
	
Clock_Gen	Clock_Gen_inst (
	.inclk0 ( MAX10_CLK1_50 ),
	.c0 ( clk_i )
	);
//cont_1s_RCO
//	cDiv(
//		.mclk(clk_i), .reset(rst),
//		.RCO(clk)  // Ripple Carry Output
//  	);
	CoreMips core1(
		.clk(clk_i), 
		.rst(rst), 
		.GPIO_i(SW[7:0]), 
		.ALUOutput(ALUOutput),
		.GPIO_o(GPIO_o)
		);

	//assign LEDR[8:0] = ALUOutput[8:0];

	assign LEDR[8:0] = GPIO_o[8:0];

// Only for TB
/*module MIPS_Multicycle(
	input   MAX10_CLK1_50,
	input   SW,
	output [8:0] LEDR
);
	wire rst = SW;
	wire [31:0] ALUOutput;

	CoreMips core1(
		.clk(MAX10_CLK1_50), 
		.rst(rst), 
		.GPIO_i(SW), 
		.ALUOutput(ALUOutput));

	assign LEDR = ALUOutput[8:0];*/

endmodule 

