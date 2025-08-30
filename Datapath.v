`timescale 1ns / 1ps

module Datapath(input clk, reset, output Zero);
	
	wire [31:0] Instr;
	wire [5:0] Op = Instr [31:26];
	wire [5:0] Funct = Instr [5:0];
	wire [2:0] ALUCtrl;
	wire [1:0] ALUSrcB;
	wire [1:0] PCSource;
	wire IorD, RegDst, MemtoReg, ALUSrcA, IRWrite, MemWrite, RegWrite, PCEn;
	ControlUnit CU (clk, reset, Op, IorD, RegDst, PCSource, MemtoReg, ALUSrcA, ALUSrcB,
		IRWrite, MemWrite, RegWrite,
		Funct, ALUCtrl,
		Zero, PCEn
	);
	
	wire [31:0] PCIn;
	wire [31:0] PCOut;
	Reg32 PC (clk, PCEn, PCIn, PCOut);
	
	wire [31:0] ALUOut;
	wire [31:0] Adr;
	Mux2to1 MUXMem (PCOut, ALUOut, IorD, Adr);
	
	wire [31:0] RegB;
	wire [31:0] RD;
	Memory mem (clk, MemWrite, Adr, RegB, RD);
	
	Reg32 IRReg (clk, IRWrite, RD, Instr);
	
	wire [31:0] Data;
	Reg32 MDR (clk, 1'b1, RD, Data);
	
	wire [4:0] A1 = Instr[25:21];
	wire [4:0] A2 = Instr[20:16];
	wire [4:0] A3;
	Mux2to1 #(5) MuxRegDst (Instr[20:16], Instr[15:11], RegDst, A3);
	
	wire [31:0] WD3;
	Mux2to1 MuxMemtoReg (ALUOut, Data, MemtoReg, WD3);
	
	wire [31:0] RD1;
	wire [31:0] RD2;
	RegisterFile RegFile (clk, RegWrite, A1, A2, A3, WD3, RD1, RD2);
		
	wire [31:0] RegA;
	Reg32 RegisterA (clk, 1'b1, RD1, RegA);
	
	Reg32 RegisterB (clk, 1'b1, RD2, RegB);
	
	wire [31:0] SignImm;
	SignExtend SE (Instr[15:0], SignImm);
	
	wire [31:0] SrcA;
	Mux2to1 MuxALUSrcA (PCOut, RegA, ALUSrcA, SrcA);
	
	wire [31:0] ShiftSignImm;
	ShiftLeft2 SHL (SignImm, ShiftSignImm);
	
	wire [31:0] SrcB;
	Mux4to1 MuxALUSrcB (RegB, 32'd4, SignImm, ShiftSignImm, ALUSrcB, SrcB);
	
	wire [31:0] ALUResult;
	ALU ALU (SrcA, SrcB, ALUCtrl, ALUResult, Zero);

	Reg32 RegALUOut (clk, 1'b1, ALUResult, ALUOut);
	
	wire [31:0] ShiftJump;
	ShiftLeft2 SHL2 (Instr, ShiftJump);
		
	Mux3to1 MuxPCSrc (ALUResult, ALUOut, {{PCOut[31:28]}, {ShiftJump[27:0]}}, PCSource, PCIn);

endmodule
