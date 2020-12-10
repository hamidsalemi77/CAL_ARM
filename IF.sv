`timescale 1ns/1ns
module IF( input clk, rst, freeze, BranchTaken,
              input [31:0]  BranchAddr,               
              output [31:0] PC, Instruction);
  
  logic [31:0] n4 = 32'd4;

  
  logic [31:0] pcin ,pcout,
              addout,instmem_out;
      
  assign pcin = (BranchTaken == 1'b1) ? BranchAddr : addout;
  
  

     
  b32regen PCReg(pcin, clk, rst, ~freeze, pcout);
  instmem IM(pcout, clk, rst, instmem_out);
  b32adder A1(n4, pcout, addout);

  assign PC = addout;
  assign Instruction = instmem_out;
endmodule
