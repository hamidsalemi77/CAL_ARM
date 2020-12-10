`timescale 1ns/1ns
module TopModule(input clk, rst);
  
  logic flush, freeze, BranchTaken;
  
  logic[31:0] BranchAddr, 
              IF_PC_out, IF_instruction_out,
              ID_PC_in, ID_instruction_in, 
              ID_PC_out, ID_instruction_out,
              EX_PC_in, EX_instruction_in, 
              EX_PC_out, EX_instruction_out,
              MEM_PC_in, MEM_instruction_in, 
              MEM_PC_out, MEM_instruction_out,
              WB_PC_in, WB_instruction_in,
              WB_PC_out;
  assign flush = 1'b0;
  assign freeze = 1'b0;
  assign BranchTaken = 1'b0;
  assign BranchAddr = 32'b0;
              
  IF If(clk, rst, freeze, BranchTaken, BranchAddr, IF_PC_out, IF_instruction_out);
  IF_ID if_id(clk, rst, flush, freeze, IF_instruction_out, IF_PC_out, ID_instruction_in, ID_PC_in);
  ID id(clk, rst, ID_PC_in, ID_PC_out);
  ID_EX id_ex(clk, rst, ID_PC_out, EX_PC_in);
  EX ex(clk, rst, EX_PC_in, EX_PC_out);
  EX_MEM ex_mem(clk, rst, EX_PC_out, MEM_PC_in);
  MEM mem(clk, rst, MEM_PC_in, MEM_PC_out);
  MEM_WB mem_wb(clk, rst, MEM_PC_out, WB_PC_in);
  WB wb(clk, rst, WB_PC_in, WB_PC_out);
endmodule

