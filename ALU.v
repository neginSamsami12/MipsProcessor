`timescale 1ns / 1ps

module ALU (
    input  [31:0] SrcA,
    input  [31:0] SrcB,
    input  [2:0]  ALUControl,
    output reg [31:0] ALUResult,
    output Zero
);
    always @(*) begin
        case (ALUControl)
            3'b000: ALUResult = SrcA & SrcB;              // AND
            3'b001: ALUResult = SrcA | SrcB;              // OR
            3'b010: ALUResult = SrcA + SrcB;              // ADD
            3'b110: ALUResult = SrcA - SrcB;              // SUB
            3'b111: ALUResult = (SrcA < SrcB) ? 1 : 0;    // SLT
            default: ALUResult = 32'hXXXXXXXX;            // Undefined
        endcase
    end

    assign Zero = (ALUResult == 32'b0);

endmodule
