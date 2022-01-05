module DEMUX #(parameter WIDTH = 32)(
input [WIDTH-1:0] REGA,
input sel,
output reg [WIDTH-1:0] GPIO_o, datapath
);

always @(*) begin
	case (sel)
	0: begin 
		datapath <= REGA;
		GPIO_o <= 32'b0;
		end
	1: begin
		datapath <= 32'b0;
		GPIO_o <= REGA;
		end
	endcase
end

endmodule 