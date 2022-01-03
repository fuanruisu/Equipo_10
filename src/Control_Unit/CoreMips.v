module CoreMips (
input clk, rst,
input [7:0] GPIO_i,
output [31:0] ALUOutput

);
localparam WIDTH = 32, MEMORY_DEPTH = 64;
wire [5:0] Opcode, funct;
wire IorD, ALUSrcA, IRWrite, MemWrite, PCWrite, RegWrite, Ori, zero, Branch;
wire [1:0] ALUSrcB, PCSrc, MemtoReg, RegDst;
wire [2:0] ALUControl;
wire [15:0] Per_port;
wire FlagBranch, PCEn;
Control_Unit CU1(
.Opcode(Opcode), .Funct(funct),
.clk(clk), .rst(rst),
.MemtoReg(MemtoReg), .RegDst(RegDst), .IorD(IorD), .PCSrc(PCSrc), .ALUSrcA(ALUSrcA), 
.IRWrite(IRWrite), .MemWrite(MemWrite), .PCWrite(PCWrite), .RegWrite(RegWrite), .Ori(Ori), .Branch(Branch),
.ALUControl(ALUControl),
.ALUSrcB(ALUSrcB)

);

SignExtend8to16 #(.WIDTH(16))
SignExt8b
(
.Imm(GPIO_i), //array Imm de longitud de 16 bits
.SignExtImm(Per_port) // array SignExtImm de 32 bits
);

//'Til here PCWrite is directly connected to PCEn but later it has to be connected as the diagram shows
Data_Path #(.WIDTH(WIDTH), .MEMORY_DEPTH(MEMORY_DEPTH)) D1(
.PCen(PCEn), .IorD(IorD), .MemWrite(MemWrite), .IRWrite(IRWrite), .RegDst(RegDst), .MemtoReg(MemtoReg), 
.RegWrite(RegWrite), .ALUSrcA(ALUSrcA), .PCSrc(PCSrc), .clk(clk), .reset(rst),
.ALUSrcB(ALUSrcB),
.GPIO_i(Per_port),
.ALUControl(ALUControl),
.Ori(Ori),
.ALU_o(ALUOutput), //Se dejará de esta forma, ya que es mejor práctica crear un wrapper para configurar los perifericos
.op(Opcode), .funct(funct), .zero(zero)
);
assign FlagBranch = zero & Branch; 
assign PCEn = FlagBranch | PCWrite;
endmodule 