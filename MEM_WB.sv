`timescale 1ns/1ns
module MEM_WB(
    input clk, rst,
    input [31:0] PC,
    input WB_EN, MEM_R_EN,
    input [31:0] ALU_result, data,
    input [3:0] Dest,
    
    output reg WB_EN_out, MEM_R_EN_out, 
    output reg [3:0] Dest_out,
    output reg [31:0] ALU_result_out, data_out, PC_out
);

always@(posedge clk, posedge rst)
  if (rst) begin
    {WB_EN_out, MEM_R_EN_out, Dest_out, ALU_result_out, data_out, PC_out} <= 0;
  end
  else begin
    WB_EN_out <= WB_EN;
    MEM_R_EN_out <= MEM_R_EN;
    Dest_out <= Dest;
    ALU_result_out <= ALU_result;
    data_out <= data;
    PC_out <= PC;
  end

endmodule


