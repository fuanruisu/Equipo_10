module ALU #(parameter WIDTH = 32)(		 // ARITHMETIC UNIT
output reg [WIDTH-1: 0] 	y,
output reg zero,
input		[WIDTH-1:0]	a, b,
input		[2: 0]	select,
input [WIDTH-1:0]   PC, //Added
input [WIDTH-1:0]   Imm //Added
);

wire [WIDTH-1:0] PC4 = PC + 32'd4;
wire [WIDTH-1:0] branchAddress = {Imm[15], Imm[15:0], {2{1'b0}}};

always @(*)
begin
y= 32'b0;
zero = 1'b0;
case (select)
3'b000:	y = b;
3'b001:	y = (a < b) ? 1'b1 : 1'b0;
3'b010:	y = a + b;
3'b100: 	y = a;
3'b011:	y = a + (~b) + 1'b1;
3'b101: 	y = a*b;
3'b110:	zero = (a==b)  ? 1'b1  : 1'b0;
3'b111: 	y = a&b;



default:		begin 
				y = 32'b0;
				zero = 1'b0;
				end
endcase

end

endmodule
