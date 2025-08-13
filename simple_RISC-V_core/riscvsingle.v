module riscvsingle(input wire clk, reset,
 output reg [31:0] PC,
input wire [31:0] Instr,
output reg MemWrite,
output reg [31:0] ALUResult, WriteData,
input wire [31:0] ReadData);
reg ALUSrc, RegWrite, Jump, Zero;
reg [1:0] ResultSrc, ImmSrc;
reg [2:0] ALUControl;
controller c(Instr[6:0], Instr[14:12], Instr[30], Zero,
ResultSrc, MemWrite, PCSrc,
ALUSrc, RegWrite, Jump,
ImmSrc, ALUControl);
datapath dp(clk, reset, ResultSrc, PCSrc,
ALUSrc, RegWrite,
ImmSrc, ALUControl,
Zero, PC, Instr,
ALUResult, WriteData, ReadData);
endmodule