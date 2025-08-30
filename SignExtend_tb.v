`timescale 1ns / 1ps

module SignExtend_tb;
    reg [15:0] in;
    wire [31:0] out;

    SignExtend uut (
        .in(in),
        .out(out)
    );

    initial begin
        in = 16'b0000_0000_0000_1010; // 0x000A
        #10;

        in = 16'b1111_1111_1111_1111; // 0xFFFF
        #10;

        in = 16'b1111_1111_1000_0000;
        #10;

        in = 16'b0111_1111_1111_1111;
        #10;$stop;
        
    end
endmodule


