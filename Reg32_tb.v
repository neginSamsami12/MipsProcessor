`timescale 1ns / 1ps

module Reg32_tb;

    reg clk;
    reg en;
    reg [31:0] d;
    wire [31:0] q;

    // Instantiate the register
    Reg32 uut (.clk(clk),.en(en),.d(d),.q(q));
            
    // Generate clock (period = 10 ns)
    always #5 clk = ~clk;

    initial begin

        clk = 0;en = 0;d = 32'h00000000;       
        #10;

        d = 32'hDEADBEEF;
        #10;

        en = 1;
        d = 32'hAABBCCDD;
        #10;

        d = 32'h12345678;
        #10;

        en = 0;
        d = 32'h87654321;
        #10;$stop;
    end
endmodule
