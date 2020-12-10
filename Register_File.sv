`timescale 1ns/1ns
module RFF(
	input clk, rst,
	input[3:0] src1, src2, Dest_wb,
	input[31:0] Result_WB,
	input writeBackEn,
	output[31:0] reg1, reg2 
);

  reg [31:0] Registers[0:15];
  integer i;
  assign Reg1 = Registers[src1];
  assign Reg2 = Registers[src2];
  
  always @(negedge clk, posedge rst)begin
    if(rst) begin
      for (i = 0; i < 32; i = i + 1) begin
         Registers[i] = i;
      end
    end
    else
	  if (writeBackEn)
	    Registers[Dest_wb] <= Result_WB;
  end

endmodule


