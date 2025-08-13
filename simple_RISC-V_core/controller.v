module controller(input wire [6:0] op,
 input wire [2:0] funct3,
 input wire funct7b5,
 input wire Zero,
 output reg [1:0] ResultSrc,
 output reg MemWrite,
 output reg PCSrc, ALUSrc,
 output reg RegWrite, Jump,
 output reg [1:0] ImmSrc,
 output reg [2:0] ALUControl);
reg [1:0] ALUOp;
reg Branch;
maindec md(op, ResultSrc, MemWrite, Branch,ALUSrc, RegWrite, Jump, ImmSrc, ALUOp);
aludec ad(op[5], funct3, funct7b5, ALUOp, ALUControl);
assign PCSrc = Branch & Zero | Jump;
endmodule
