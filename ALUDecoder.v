`timescale 1ns / 1ps

module ALUDecoder(ALUOp, Funct, ALUCtrl);

input [1:0] ALUOp;
input [5:0] Funct; //for R-type instruction
output reg [2:0] ALUCtrl;

always@(ALUOp or Funct) begin
	casez({ALUOp, Funct})
		8'b00_??????: ALUCtrl = 4'b010; // +
		8'b01_??????: ALUCtrl = 4'b110; // -
		8'b1?_??0000: ALUCtrl = 4'b010; // add
		8'b1?_??0010: ALUCtrl = 4'b110; // sub
		8'b1?_??0100: ALUCtrl = 4'b000; // and
		8'b1?_??0101: ALUCtrl = 4'b001; // or
		8'b1?_??1010: ALUCtrl = 4'b111; // slt
		default: ALUCtrl = 3'b000;
	endcase
end

endmodule
