`timescale 1ns/1ns
module EXE_MEM(
    input clk, 
    input rst,
    input [31:0] PC, ALU_Result, Val_Rm ,
    input WB_EN, MEM_R_EN, MEM_W_EN,
    input [3:0] Dest,
    
    output reg [31:0] PC_out, ALU_res_out, Val_Rm_out,
    output reg WB_EN_out, MEM_R_EN_out, MEM_W_EN_out, 
    output reg [3:0]Dest_out
);

always@(posedge clk, posedge rst)
  if (rst) begin
    {PC_out, ALU_res_out, Val_Rm_out, WB_EN_out, MEM_R_EN_out, MEM_W_EN_out, Dest_out} <= 0;
  end
  else begin
    PC_out <= PC;
    ALU_res_out <= ALU_Result;
    Val_Rm_out <= Val_Rm;
    WB_EN_out <= WB_EN;
    MEM_R_EN_out <= MEM_R_EN;
    MEM_W_EN_out <= MEM_W_EN;
    Dest_out <= Dest;
  end

endmodule




