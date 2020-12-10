`timescale 1ns/1ns
module MEM(
    input clk, rst, 
    input MEM_W_EN, MEM_R_EN, WB_EN,
    input [31:0] ALU_result_in,
    input [31:0] PC, val_Rm,
    input [3:0] Dest_in,
    
    output [3:0] Dest_out,
    output WB_EN_out, MEM_R_EN_out, 
    output [31:0] PC_out, data, ALU_result
);


  logic [31:0] address;
  
  assign PC_out = PC;
  assign ALU_result = ALU_result_in;
  assign Dest_out = Dest_in;
  assign address = ALU_result_in - 32'd1024;
  assign ALU_result = ALU_result_in;
  assign WB_EN_out = WB_EN;
  assign MEM_R_EN_out = MEM_R_EN;
  
  DataMemory DM(clk, rst, MEM_W_EN, MEM_R_EN, address, val_Rm, data);
  
endmodule

