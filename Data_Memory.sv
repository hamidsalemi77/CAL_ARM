`timescale 1ns/1ns

module DataMemory(
  input clk, rst, MEM_W_EN, MEM_R_EN,
  input [31:0] Address, 
  input [31:0] val_Rm,
  
  output [31:0] out
);
  reg[31:0] addr;
  assign addr =  Address >> 2;
  reg [31:0] Data [31:0];
  integer counter;
  
  always @(posedge clk, posedge rst)
    if (rst) begin
     for (counter=0; counter<32; counter=counter+1)
      Data[counter] <= 32'b0;
    end
    
    else begin
      if (MEM_W_EN)
        Data[addr] <= val_Rm;
      end
  
  assign out = MEM_R_EN ? Data[addr] : 32'b0;

endmodule

