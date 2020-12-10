`timescale 1ns/1ns
module instmem(input[31:0] address, input clk,rst, output[31:0] inst);
  
  reg[31:0] memoryData[0:16383];
 
  
  initial begin
  memoryData[0] = 32'b000000_00001_00010_00000_00000000000;
  memoryData[1] = 32'b000000_00011_00100_00000_00000000000;
  memoryData[2] = 32'b000000_00101_00110_00000_00000000000;
  memoryData[3] = 32'b000000_00111_01000_00010_00000000000;
  memoryData[4] = 32'b000000_01001_01010_00011_00000000000;
  memoryData[5] = 32'b000000_01011_01100_00000_00000000000;
  memoryData[6] = 32'b000000_01101_01110_00000_00000000000;
  end
  assign inst = memoryData[address >> 2];
endmodule