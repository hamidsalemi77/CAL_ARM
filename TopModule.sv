`timescale 1ns/1ns
module TopModule(input clk, rst);
  
  logic       writeBackEn, hazard,
              imm, two_src, C_in,
              EX_WB_EN, EX_MEM_W_EN, EX_MEM_R_EN,
              B, S, EX_imm,
              EX_C,
              EX_WB_EN_out, EX_MEM_W_EN_out, EX_MEM_R_EN_out,
              MEM_WB_EN, MEM_MEM_R_EN, MEM_MEM_W_EN,
              MEM_WB_EN_out, MEM_MEM_R_EN_out,
              WB_WB_EN_out, WB_MEM_R_EN_out;
              
              
  logic[3:0]  Status, Dest_wb,
              Dest,src1, src2,
              EXE_CMD,EX_Dest,
              Mem_Dest,
              status_in,EX_Dest_out,
              MEM_Dest_out,
              WB_Dest;
  logic [8:0] control_out;
  logic[11:0] shift_op,
              EX_shift_oprand;
  logic[23:0] signed_imm_24,
              EX_signed_imm_24;  
  logic[31:0] BranchAddr, 
              IF_PC_out,IF_instruction_out,
              ID_PC_in, ID_PC_out, ID_instruction_in, 
              EX_PC_in, EX_PC_out, 
              MEM_PC_in,  MEM_PC_out,
              WB_PC_in, 
              WB_PC_out,
           
              Result_WB,
              Val_Rn ,Val_Rm,
              EX_val_Rn, EX_val_Rm,
              Val_Rm_out,
              ALU_result, ALU_res_out,
              Br_addr,
              MEM_data, MEM_ALU_result,
              WB_data,WB_ALU_result;
  assign freeze = 1'b0;
  assign BranchTaken = 1'b0;
  assign BranchAddr = 32'b0;
              
  IF If(clk, rst, hazard, B, BranchAddr, IF_PC_out, IF_instruction_out);
  IF_ID if_id(clk, rst, B, hazard, IF_instruction_out, IF_PC_out, ID_instruction_in, ID_PC_in);
 
 ID id(clk, rst, ID_PC_in, ID_instruction_in,Result_WB,writeBackEn,
    Dest_wb, hazard, Status,
    control_out,ID_PC_out, Val_Rn ,Val_Rm,
    imm,shift_op,signed_imm_24, Dest,src1, src2,two_src);
 
 ID_EX id_ex(clk, rst, B,
     control_out[0], control_out[2], control_out[1], imm,
     control_out[7], control_out[8],control_out[6:3],
    ID_PC_out, Val_Rn, Val_Rm, shift_op, signed_imm_24, Dest, C_in,
    EX_PC_in,EX_WB_EN, EX_MEM_W_EN, EX_MEM_R_EN, B, S, EX_imm,
    EXE_CMD,EX_val_Rn, EX_val_Rm, EX_shift_oprand, EX_signed_imm_24,
    EX_Dest, EX_C);

 Hazard_Unit HU(rst, src1, src2, EX_Dest, EX_WB_EN,
    Mem_Dest, MEM_WB_EN,two_src,hazard);
 
 
 EX ex(clk, rst, EXE_CMD, EX_MEM_R_EN, EX_MEM_W_EN, EX_WB_EN, 
        EX_PC_in, EX_val_Rn, EX_val_Rm, EX_imm, EX_shift_oprand, EX_signed_imm_24,
        EX_C,EX_Dest,
        EX_PC_out, ALU_result, BranchAddr, val_Rm_out,
        status_in, EX_Dest_out,EX_WB_EN_out, EX_MEM_W_EN_out, EX_MEM_R_EN_out);

 EXE_MEM ex_mem(clk, rst, EX_PC_out,
     ALU_result, Val_Rm_out,EX_WB_EN_out, EX_MEM_R_EN_out, EX_MEM_W_EN_out,
     EX_Dest_out,MEM_PC_in,  ALU_res_out, Val_Rm_out,
     MEM_WB_EN, MEM_MEM_R_EN, MEM_MEM_W_EN, MEM_Dest);
 
 Status_Reg SR(clk, rst, S, status_in, status);
 
 MEM mem(clk, rst, 
     MEM_MEM_W_EN, MEM_MEM_R_EN, MEM_WB_EN,
    ALU_res_out,MEM_PC_in, Val_Rm_out,
     MEM_Dest, MEM_Dest_out,
    MEM_WB_EN_out, MEM_MEM_R_EN_out, 
    MEM_PC_out, MEM_data, MEM_ALU_result); 
MEM_WB mem_wb(clk, rst, MEM_PC_out,
     MEM_WB_EN_out, MEM_MEM_R_EN_out,
    MEM_ALU_result, MEM_data,
    MEM_Dest_out, WB_WB_EN_out, WB_MEM_R_EN_out, 
     WB_Dest,WB_ALU_result, WB_data, WB_PC_in);
     
WB wb(clk, rst, WB_Dest,
    WB_WB_EN_out, WB_MEM_R_EN_out,
    WB_ALU_result, WB_data, WB_PC_ins,
    Dest_wb, writeBackEn, Result_WB);


endmodule

