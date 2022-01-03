module ALU #(parameter WIDTH = 32)(		 // ARITHMETIC UNIT
output reg [WIDTH-1: 0] 	y,
output reg zero,
input		[WIDTH-1:0]	a, b,
input		[2: 0]	select

);

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
