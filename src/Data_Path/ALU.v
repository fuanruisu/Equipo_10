module ALU #(parameter WIDTH = 32)(		 // ARITHMETIC UNIT
output reg [WIDTH-1: 0] 	y,
input		[WIDTH-1:0]	a, b,
input		[2: 0]	select,
input [WIDTH-1:0]   PC, //Added
input [WIDTH-1:0]   Imm //Added
);

wire [WIDTH-1:0] PC4 = PC + 32'd4;
wire [WIDTH-1:0] branchAddress = {Imm[15], Imm[15:0], 2'b00};

always @(*)
begin
    y= 3'b0;
    case (select)
        3'b000:	y = a & b;
        3'b001:	y = a | b;
        3'b010:	y = a + b;
        3'b011:	y = a + (~b) + 1'b1;
        3'b100:	y = a ^ b;
        3'b101:begin
        	 y = (a == b) ? PC4 + branchAddress : PC + 4; 
        	 $display("PC: %h, PC4: %h, BAdr: %b, BEQ(y): %h", PC, PC4, branchAddress,  y); 
         	end //Added
        3'b110: begin 
        	y = {PC4[31:28], Imm[25:0], 2'b00} ;
         	$display("PC: %h, J: %h", PC, y); 
         	end //Added
        default: y = 32'b0;
    endcase
end

endmodule
