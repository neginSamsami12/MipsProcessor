`timescale 1ns / 1ps

module ShiftLeft2_tb;

    reg [31:0] SignImm;
    wire [31:0] SignImmShifted;

    // Instantiate the Unit Under Test (UUT)
    ShiftLeft2 uut ( .SignImm(SignImm),.SignImmShifted(SignImmShifted));
       
    initial begin
        SignImm = 32'h00000000;
        #200;

        SignImm = 32'd4;
        #200;

        SignImm = 32'h0000000F;
        #200;

        SignImm = 32'hFFFFFFF0;
        #200;

        SignImm = 32'h12345678;
        #200;$stop;
		  
    end
endmodule
