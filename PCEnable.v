`timescale 1ns / 1ps

module PCEnable (
    input PCWrite,
    input Branch,
    input Zero,
    output PCEn
);
    assign PCEn = PCWrite | (Branch & Zero);
endmodule
