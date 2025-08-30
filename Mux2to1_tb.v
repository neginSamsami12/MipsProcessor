`timescale 1ns / 1ps

module Mux2to1_tb;

    parameter WIDTH = 32;

    reg [WIDTH-1:0] in0, in1;
    reg sel;
    wire [WIDTH-1:0] out;

    Mux2to1 #(WIDTH) uut (.in0(in0),.in1(in1),.sel(sel),.out(out));
                        
    initial begin
        in0 = 32'hAAAAAAAA;
        in1 = 32'h55555555;

        //  sel = 0
        sel = 0;
        #10;

        //  sel = 1
        sel = 1;
        #10;

        in0 = 32'h12345678;
        in1 = 32'h87654321;

        sel = 0;
        #10;

        sel = 1;
        #10;$stop;
       
    end
endmodule
