`timescale 1ns / 1ps

module ALU_tb;

    reg [31:0] SrcA;
    reg [31:0] SrcB;
    reg [2:0]  ALUControl;
    wire [31:0] ALUResult;
    wire Zero;

    ALU uut (.SrcA(SrcA),.SrcB(SrcB),.ALUControl(ALUControl),.ALUResult(ALUResult),.Zero(Zero));
        
        initial begin
        SrcA = 32'd15;
        SrcB = 32'd10;

        //  AND
        ALUControl = 3'b000; #10;
        //  OR
        ALUControl = 3'b001; #10;
        //  ADD
        ALUControl = 3'b010; #10;
        //  SUB 
        ALUControl = 3'b110; #10;
        //  SLT
        ALUControl = 3'b111; #10;

        //  Zero flag
        SrcA = 32'd42;
        SrcB = 32'd42;
        ALUControl = 3'b110; // SUB ? Zero = 1
        #10;

        // (default)
        ALUControl = 3'b011; #10;
        $stop;
    end
endmodule
