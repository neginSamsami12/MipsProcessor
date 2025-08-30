`timescale 1ns / 1ps

module MainDecoder (clk, reset, Op, IorD, RegDst, PCSource, MemtoReg, ALUSrcA, ALUSrcB,
	IRWrite, MEMWRITE, RegWrite, PCWrite, Branch, ALUOp);

	input clk;
	input reset;
	input [5:0] Op;

	// Multiplexer Selects
	output reg IorD;
	output reg RegDst;
	output reg [1:0] PCSource;
	output reg MemtoReg;
	output reg ALUSrcA;
	output reg [1:0] ALUSrcB;
	
	// Register Enables
	output reg IRWrite;
	output reg MEMWRITE;
	output reg RegWrite;
	output reg PCWrite;
	output reg Branch;
	output reg [1:0] ALUOp;


	//states
	parameter FETCH = 4'b0000;
	parameter DECODE = 4'b0001;
	parameter MEMADR = 4'b0010;
	parameter MEMREAD = 4'b0011;
	parameter MEMWRITEBACK = 4'b0100;
	parameter MEMACCESS = 4'b0101; // sw
	parameter EXECUTE = 4'b0110;
	parameter ALUWRITEBACK = 4'b0111; // RTYPE END
	parameter BRANCH = 4'b1000;
   parameter JUMPEND = 4'b1001;
	parameter ADDIEXECUTE = 4'b1010;
	parameter ADDIEND = 4'b1011;
	
	// OP Code
	parameter RTYPE = 6'b000000;
	parameter LW = 6'b100011;
	parameter SW = 6'b101011;
	parameter BEQ = 6'b000100;
   parameter JUMP = 6'b000010;
	parameter ADDI = 6'b001000;

	reg [3:0] state;
	reg [3:0] nextstate;

   always@(posedge clk)
    if (reset)
		state <= FETCH;
    else
		state <= nextstate;


	always@(state or Op) begin
		  case (state)
        FETCH:  nextstate = DECODE;
        DECODE:  case(Op)
					//OpCode
                   LW:	nextstate = MEMADR;
                   SW:	nextstate = MEMADR;
                   RTYPE:	nextstate = EXECUTE;
                   BEQ:	nextstate = BRANCH;
                   JUMP: nextstate = JUMPEND;
						 ADDI: nextstate = ADDIEXECUTE;
                   default: nextstate = FETCH;
                 endcase
        MEMADR:  case(Op)
                   LW:      nextstate = MEMREAD;
                   SW:      nextstate = MEMACCESS;
                   default: nextstate = FETCH;
                 endcase
        MEMREAD:    nextstate = MEMWRITEBACK;
        MEMWRITEBACK:    nextstate = FETCH;
        MEMACCESS:    nextstate = FETCH;
        EXECUTE: nextstate = ALUWRITEBACK;
        ALUWRITEBACK: nextstate = FETCH;
        BRANCH:   nextstate = FETCH;
		  JUMPEND:	nextstate = FETCH;
        ADDIEXECUTE: nextstate = ADDIEND;
        default: nextstate = FETCH;
      endcase
    end


	always@(state) begin

	IorD=1'b0; MEMWRITE=1'b0; MemtoReg=1'b0; IRWrite=1'b0; PCSource=2'b00;
	ALUSrcB=2'b00; ALUSrcA=1'b0; RegWrite=1'b0; RegDst=1'b0;
	PCWrite=1'b0; Branch=1'b0; ALUOp=2'b00;

    	case (state)
        FETCH:
          begin
            IRWrite = 1'b1;
            ALUSrcB = 2'b01;
            PCWrite = 1'b1;
          end
        
        DECODE:
	        ALUSrcB = 2'b11;

        MEMADR:
          begin
            ALUSrcA = 1'b1;
            ALUSrcB = 2'b10;
          end

        MEMREAD:
          begin
            IorD = 1'b1;
          end

        MEMWRITEBACK:
          begin
            RegWrite = 1'b1;
	         MemtoReg = 1'b1;
          end
        
        MEMACCESS:
          begin
            MEMWRITE = 1'b1;
            IorD = 1'b1;
          end
        
        EXECUTE:
          begin
            ALUSrcA = 1'b1;
            ALUOp   = 2'b10;
          end
        
        ALUWRITEBACK:
          begin
            RegDst   = 1'b1;
            RegWrite = 1'b1;
          end
        
        BRANCH:
          begin
            ALUSrcA = 1'b1;
            ALUOp   = 2'b01;
            Branch = 1'b1;
	         PCSource = 2'b01;
          end

        JUMPEND:
          begin
            PCWrite = 1'b1;
            PCSource = 2'b10;
          end

        ADDIEXECUTE:
          begin
            ALUSrcA = 1'b1;
            ALUSrcB = 2'b10;
          end

        ADDIEND:
          begin
            RegWrite = 1'b1;
          end
          
      endcase
    end
endmodule