`timescale 1ns / 1ps

module Memory_tb;
    reg clk, MemWrite;
    reg [31:0] addr, write_data;
    wire [31:0] read_data;

    Memory dut (
        .clk(clk),
        .MemWrite(MemWrite),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        MemWrite = 0;
        addr = 32'h00000000;
        write_data = 32'h00000000;

        //  0x08
        #10 MemWrite = 1;
            addr = 32'h00000008;
            write_data = 32'hDEADBEEF;

        //  0x08
        #10 MemWrite = 0; addr = 32'h00000008;

        #10 addr = 32'h0000000C;

        #10 $stop;
    end
endmodule

