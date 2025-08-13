module alu (
  input logic [31:0] SrcA,
  input logic [31:0] SrcB,
  input logic [2:0] ALUControl,
  output logic [31:0] ALUResult,
  output logic Zero
);
  logic [31:0] temp_result;

  always_comb begin
    case (ALUControl)
      3'b000: temp_result = SrcA + SrcB; // Addition
      3'b001: temp_result = SrcA - SrcB; // Subtraction
      3'b010: temp_result = SrcA & SrcB; // Bitwise AND
      3'b011: temp_result = SrcA | SrcB; // Bitwise OR
      3'b100: temp_result = SrcA << SrcB[4:0]; // Shift left
      3'b101: temp_result = SrcA >> SrcB[4:0]; // Logical shift right
      3'b110: temp_result = SrcA >>> SrcB[4:0]; // Arithmetic shift right
      3'b111: temp_result = SrcA ^ SrcB; // Bitwise XOR
      default: temp_result = 32'h0;
    endcase

    ALUResult = temp_result;   // was temp_result
    Zero = (ALUResult == 32'h0); // Set Zero flag
  end
endmodule
