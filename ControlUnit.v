`timescale 1ns / 1ps

module ControlUnit(clk, reset, Op, IorD, RegDst, PCSource, MemtoReg, ALUSrcA, ALUSrcB,
	IRWrite, MEMWRITE, RegWrite,
	Funct, ALUCtrl,
	Zero, PCEn);

   input clk;
	input reset;
	input [5:0] Op;

	output IorD;
	output RegDst;
	output [1:0] PCSource;
	output MemtoReg;
	output ALUSrcA;
	output [1:0] ALUSrcB;
	
	output IRWrite;
	output MEMWRITE;
	output RegWrite;

    input [5:0] Funct;
    output [2:0] ALUCtrl;

    input Zero;
    output PCEn;

    wire Branch, PCWrite;
    wire [1:0]ALUOp;

	MainDecoder mainDecoder(clk, reset, Op, IorD, RegDst, PCSource, MemtoReg, ALUSrcA, ALUSrcB,
        IRWrite, MEMWRITE, RegWrite, PCWrite, Branch, ALUOp);
	ALUDecoder aluDecoder(ALUOp, Funct, ALUCtrl);
	PCEnable pcEnable(PCWrite, Branch, Zero, PCEn);

endmodule
