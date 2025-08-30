`timescale 1ns / 1ps

module Datapath_tb;

    // Inputs
    reg clk;
    reg reset;

    // Outputs
    wire Zero;

    Datapath dut (.clk(clk),.reset(reset),.Zero(Zero));
                
    // Clock gen
    initial begin
        clk = 0;
        reset = 0;
        #940;
        $stop;
    end
    always #5 clk = ~clk;

    // ---- ALU Logging ----
    always @(posedge clk) begin
        if (dut.ALUCtrl !== 3'bxxx) begin
            $display("[%0t] ALU: SrcA=%08h SrcB=%08h ALU_Control=%0b -> Result=%08h",
                     $time,
                     dut.SrcA,
                     dut.SrcB,
							dut.ALUCtrl,
                     dut.ALUResult);
        end
    end

		// ---- PC Logging ----
		always @(posedge dut.IRWrite) begin
			 $display("[%0t] PC=%08h",
						 $time,
						 dut.PC.q);
		end

		// ---- Instruction Logging ----
		reg [31:0] prev_inst;
		always @(posedge clk) begin
			 if (dut.IRReg.q !== prev_inst) begin
				  prev_inst <= dut.IRReg.q;
				  $display("[%0t] Instruction=%08h",
							  $time,
							  dut.IRReg.q);
			 end
		end

    // ---- Register File Write Logging ----
    always @(posedge clk) begin
        if (dut.RegWrite && dut.RegFile.WriteReg != 5'd0)
            $display("[%0t]   >> $%0d <= %08h",
                     $time,
                     dut.RegFile.WriteReg,
                     dut.RegFile.WriteData);
    end

    // ---- Memory Access Logging ----
    always @(posedge dut.MemWrite) begin
        $display("[%0t]   >> MEM[%02h] <= %08h",
                 $time,
                 dut.mem.addr[9:2],
                 dut.mem.write_data);
    end
endmodule
