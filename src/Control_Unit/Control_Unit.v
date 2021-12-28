module Control_Unit(
input [5:0] Opcode, Funct,
input clk, rst,
output MemtoReg, RegDst, IorD, PCSrc, ALUSrcA, IRWrite, MemWrite, PCWrite, RegWrite, Ori, //Branch, PCJump
output [2:0] ALUControl,
output [1:0] ALUSrcB 

);
wire [2:0] ALUOp;

// ALU_Decoder ALUDec1(
// .ALUOp(ALUOp),
// .func(Funct),
// .ALUControl(ALUControl));


Main_Controller MainControl1(
.Opcode(Opcode),
.Funct(Funct),
.clk(clk),
.rst_n(rst),
.MemtoReg(MemtoReg), 
.RegDst(RegDst),
.IorD(IorD), 
.PCSrc(PCSrc), 
.ALUSrcA(ALUSrcA), 
.IRWrite(IRWrite), 
.MemWrite(MemWrite), 
.PCWrite(PCWrite),
.Ori(Ori),
//.Branch(Branch),
//.PCJump(PCJump), 
.RegWrite(RegWrite),
.ALUSrcB(ALUSrcB), .ALUControl(ALUControl) 
);


endmodule 