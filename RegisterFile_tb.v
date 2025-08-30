`timescale 1ns / 1ps

module RegisterFile_tb;
    reg clk, RegWrite;
    reg [4:0] ReadReg1, ReadReg2, WriteReg;
    reg [31:0] WriteData;
    wire [31:0] ReadData1, ReadData2;

    RegisterFile uut (.clk(clk),.RegWrite(RegWrite),.ReadReg1(ReadReg1),.ReadReg2(ReadReg2),.WriteReg(WriteReg),
        .WriteData(WriteData),.ReadData1(ReadData1),.ReadData2(ReadData2));
                                                            
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        RegWrite = 0;
        WriteReg = 5'd0;
        WriteData = 32'h00000000;
        ReadReg1 = 5'd0;
        ReadReg2 = 5'd0;
        #10;

        RegWrite = 1;
        WriteReg = 5'd5;
        WriteData = 32'hCAFEBABE;
        #10;

        RegWrite = 0;
        ReadReg1 = 5'd5;
        ReadReg2 = 5'd0;
        #10;

        RegWrite = 1;
        WriteReg = 5'd0;
        WriteData = 32'hFFFFFFFF;
        #10;

        RegWrite = 0;
        ReadReg1 = 5'd0;
        #10;$stop;
       
    end
endmodule
