`timescale 1ns / 1ps

module PCEnable_tb;
    reg PCWrite, Branch, Zero;
    wire PCEn;

    PCEnable dut (
        .PCWrite(PCWrite),
        .Branch(Branch),
        .Zero(Zero),
        .PCEn(PCEn)
    );

    initial begin

        #10;PCWrite = 0; Branch = 0; Zero = 0; 
        #10;PCWrite = 1; Branch = 0; Zero = 0; 
        #10;PCWrite = 0; Branch = 1; Zero = 0; 
        #10;PCWrite = 0; Branch = 1; Zero = 1; 
        #10;PCWrite = 1; Branch = 1; Zero = 1; 
        #10;$stop;
    end
endmodule


