`timescale 1ns / 1ps

module ShiftLeft2 (
    input  [31:0] SignImm,
    output [31:0] SignImmShifted
);
    assign SignImmShifted = SignImm << 2;
endmodule
