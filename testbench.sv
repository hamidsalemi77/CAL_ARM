`timescale 1ns/1ns
module tb();
  
  logic rst,clk;  
  
  TopModule uut(clk, rst);
  
  initial begin
    clk = 1;
  end
  
  always
    #10 clk = !clk;
  

  initial begin
   rst =  1;
   #50
   rst = 0;

   
  end
endmodule

