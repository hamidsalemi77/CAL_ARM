`timescale 1ns/1ns
module TopModule(input clk, rst);
  
  logic       hazard, imm, two_src, B, S, 
              EX_WB_EN, EX_MEM_W_EN, EX_MEM_R_EN, EX_imm, EX_C,
              EX_WB_EN_out, EX_MEM_W_EN_out, EX_MEM_R_EN_out,
              MEM_WB_EN, MEM_MEM_R_EN, MEM_MEM_W_EN,
              MEM_WB_EN_out, MEM_MEM_R_EN_out,
              WB_WB_EN, WB_MEM_R_EN, WB_EN;
              
  logic[3:0]  status, Dest_wb,
              Dest, src1, src2,
              EXE_CMD, EX_Dest,
              status_in, EX_Dest_out,
              MEM_Dest, MEM_Dest_out,
              WB_Dest;

  logic [8:0] control_out;

  logic[11:0] shift_op,
              EX_shift_oprand;

  logic[23:0] signed_imm_24,
              EX_signed_imm_24;
 
  logic[31:0] BranchAddr, Val_Rn ,Val_Rm, ALU_result, ALU_result_out, Br_addr,
              IF_PC_out,IF_instruction_out,
              ID_PC_in, ID_PC_out, ID_instruction_in, 
              EX_PC_in, EX_PC_out, EX_val_Rn, EX_val_Rm, EX_Val_Rm_out,
              MEM_PC_in, MEM_PC_out, MEM_data, MEM_ALU_result, MEM_Val_Rm,
              WB_PC_in, WB_PC_out, Result_WB, WB_data, WB_ALU_result;

              
  IF If(clk, rst, hazard, B, BranchAddr, IF_PC_out, IF_instruction_out);
  IF_ID if_id(clk, rst, B, hazard, IF_instruction_out, IF_PC_out, ID_instruction_in, ID_PC_in);
 
 ID id(clk, rst, ID_PC_in, ID_instruction_in, Result_WB , WB_EN,
    Dest_wb, hazard, status, control_out, ID_PC_out, Val_Rn , Val_Rm,
    imm, shift_op, signed_imm_24, Dest, src1 , src2, two_src); 

 ID_EX id_ex(clk, rst, B, control_out[0], control_out[2], control_out[1], imm,
     	     control_out[7], control_out[8], control_out[6:3],
    	     ID_PC_out, Val_Rn, Val_Rm, shift_op, signed_imm_24, Dest, status[1], EX_PC_in, 
	     EX_WB_EN, EX_MEM_W_EN, EX_MEM_R_EN, B, S, EX_imm, EXE_CMD, EX_val_Rn, 
	     EX_val_Rm, EX_shift_oprand, EX_signed_imm_24, EX_Dest, EX_C);

 Hazard_Unit HU(rst, src1, src2, EX_Dest, EX_WB_EN, MEM_Dest, MEM_WB_EN, two_src, hazard);
 
 
 EXE exe(clk, rst, EXE_CMD, EX_MEM_R_EN, EX_MEM_W_EN, EX_WB_EN, EX_PC_in, EX_val_Rn, 
	 EX_val_Rm, EX_imm, EX_shift_oprand, EX_signed_imm_24, EX_C, EX_Dest,
         EX_PC_out, ALU_result, BranchAddr, EX_Val_Rm_out,
         status_in, EX_Dest_out, EX_WB_EN_out, EX_MEM_W_EN_out, EX_MEM_R_EN_out);

 EXE_MEM exe_mem(clk, rst, EX_PC_out, ALU_result, EX_Val_Rm_out, EX_WB_EN_out, 
		 EX_MEM_R_EN_out, EX_MEM_W_EN_out, EX_Dest_out,
		 MEM_PC_in,  ALU_result_out, MEM_Val_Rm, MEM_WB_EN, 
		 MEM_MEM_R_EN, MEM_MEM_W_EN, MEM_Dest);
 
 Status_Reg SR(clk, rst, S, status_in, status);
 
 MEM mem(clk, rst, MEM_MEM_W_EN, MEM_MEM_R_EN, MEM_WB_EN,
    	 ALU_result_out, MEM_PC_in, MEM_Val_Rm, MEM_Dest,
 	 MEM_Dest_out, MEM_WB_EN_out, MEM_MEM_R_EN_out, 
    	 MEM_PC_out, MEM_data, MEM_ALU_result); 

MEM_WB mem_wb(clk, rst, MEM_PC_out, MEM_WB_EN_out, MEM_MEM_R_EN_out,
    	      MEM_ALU_result, MEM_data, MEM_Dest_out, 
	      WB_WB_EN, WB_MEM_R_EN, WB_Dest, 
	      WB_ALU_result, WB_data, WB_PC_in);
     
WB wb(clk, rst, WB_Dest, WB_WB_EN, WB_MEM_R_EN,
      WB_ALU_result, WB_data, WB_PC_in,
      Dest_wb, WB_EN, Result_WB);


endmodule

