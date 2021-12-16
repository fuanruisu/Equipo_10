module ALU #(parameter WIDTH = 32)(		 // ARITHMETIC UNIT
output reg [WIDTH-1: 0] 	y,
input		[WIDTH-1:0]	a, b,
input		[2: 0]	select
input [WIDTH-1:0]   PC, //Added
input [WIDTH-1:0]   Imm //Added
);

always @(*)
begin
    y= 3'b0;
    case (select)
        3'b000:	y = a&b;
        3'b001:	y = a|b;
        3'b010:	y = a + b;
        3'b011:	y = a + (~b) + 1'b1;
        3'b110:	y = |a^b;
        3'b101: y = (a == b) ? PC + 4 + {Imm[15], Imm[15:0], 2'b00} : PC + 4; //Added
        3'b110: y = {PC[31:28], Imm[25:0], 2'b00} ; //Added
        default: y = 32'b0;
    endcase
end

endmodule
