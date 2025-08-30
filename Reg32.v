`timescale 1ns / 1ps

module Reg32 #(parameter WIDTH = 32)(
    input clk,
    input en,
    input [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);
	 initial begin
		q = 0;
	 end
	 
    always @(posedge clk) begin
        if (en)
            q <= d;
    end
endmodule
