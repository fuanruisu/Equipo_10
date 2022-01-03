module ALU_Decoder(
input [2:0] ALUOp,
input [5:0] func,
output reg [2:0] ALUControl);

always @ (*) begin
	case(ALUOp)
	3'b000: ALUControl = 3'b010;
	3'b001: ALUControl = 3'b110;
	3'b011: ALUControl = 3'b000;
	3'b100: ALUControl = 3'b001;
	3'b101: ALUControl = 3'b101;
	3'b010:  
		begin	
		case(func)
		6'b100000: ALUControl = 3'b010;
		6'b001000: ALUControl = 3'b100;
		6'b100010: ALUControl = 3'b110;
		6'b100100: ALUControl = 3'b0;
		6'b100101: ALUControl = 3'b001;
		6'b101010: ALUControl = 3'b111;
		default: ALUControl = 3'bx;
		endcase
		end
	default: ALUControl = 3'bx;
	endcase

end


endmodule 