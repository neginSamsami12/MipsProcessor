`timescale 1ns / 1ps

module RegisterFile (
    input clk,
    input RegWrite,
    input [4:0] ReadReg1, ReadReg2, WriteReg,
    input [31:0] WriteData,
    output [31:0] ReadData1, ReadData2
);

    reg [31:0] registers [31:0];

	 integer i;
    initial begin
		for (i = 0; i < 32; i = i + 1)
			registers[i] = 32'b0;
	 end
		
    // Read operations (asynchronous)
    assign ReadData1 = registers[ReadReg1];
    assign ReadData2 = registers[ReadReg2];

    // Write operation (synchronous)
    always @(posedge clk) begin
        if (RegWrite && WriteReg != 5'd0)  
            registers[WriteReg] <= WriteData;
    end
endmodule
