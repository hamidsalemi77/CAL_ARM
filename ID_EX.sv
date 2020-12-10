`timescale 1ns/1ns
module ID_EX(
    input clk, rst, flush,
    input WB_EN_in, MEM_W_EN_in, MEM_R_EN_in, imm_in,
     B_in, S_in,
    input [3:0] EXE_CMD_in,
    input [31:0] PC_in, Val_Rn_in, Val_Rm_in,
    input [11:0] shift_op_in,
    input [23:0] signed_imm_24_in,
    input [3:0] Dest_in,
    input  C_in,
    
    output reg [31:0] PC,
    output reg WB_EN, MEM_W_EN, MEM_R_EN, B, S, imm,
    output reg [3:0] EXE_CMD,
    output reg [31:0] val_Rn, val_Rm,
    output reg [11:0] shift_oprand,
    output reg [23:0] signed_imm_24,
    output reg [3:0] Dest,
    output reg  C);

    
always@(posedge rst, posedge clk)begin
  if (rst) begin
    {PC, WB_EN, MEM_W_EN, MEM_R_EN, B, S, imm, EXE_CMD, val_Rn, val_Rm, shift_oprand, signed_imm_24, Dest, C} <= 0;
  end
  else
    if(flush)begin
      {PC, WB_EN, MEM_W_EN, MEM_R_EN, B, S, imm, EXE_CMD, val_Rn, val_Rm, shift_oprand, signed_imm_24, Dest, C} <= 0; 
    end
    else begin
    PC <= PC_in;
    WB_EN <= WB_EN_in;
    MEM_W_EN <= MEM_W_EN_in;
    MEM_R_EN <= MEM_R_EN_in;
    B <= B_in;
    S <= S_in;
    imm <= imm_in;
    EXE_CMD <= EXE_CMD_in;
    val_Rn <= Val_Rn_in;
    val_Rm <= Val_Rm_in;
    shift_oprand <= shift_op_in;
    signed_imm_24 <= signed_imm_24_in;
    Dest <= Dest_in;
    C <= C_in;
  end
end
   
endmodule
