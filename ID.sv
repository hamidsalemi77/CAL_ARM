`timescale 1ns/1ns
module ID(
    input clk, rst,
    input [31:0] PC_in, Instruction,
    //from WB Stage
    input [31:0] Result_WB,
    input writeBackEn,
    input [3:0] Dest_wb,
    //from hazard detection
    input hazard,
    //from status reg
    input [3:0] Status,
    //output
    output [8:0] control_out,
    output [31:0] PC, Val_Rn ,Val_Rm,
    output imm,
    output [11:0] shift_op,
    output [23:0] signed_imm_24,
    output [3:0] Dest,
    //to hazard detect module 
    output [3:0] src1, src2,
    output two_src
);

    logic[3:0] reg2;
    logic CC_Out,
          C_mem_write, C_mem_read, C_WB_Enable, C_B, C_S,
          CUO_Selector;
    logic[3:0] C_execute_command;
	
	  assign PC = PC_in; 
    assign reg2 = C_mem_write ? Instruction[15:12] : Instruction[3:0];
    assign src2 = reg2;
    assign src1 = Instruction[19:16];
    assign CUO_Selector = ~CC_Out | hazard;
    assign control_out = CUO_Selector ? 9'b0 : {C_S, C_B, C_execute_command, C_mem_write, C_mem_read, C_WB_Enable}; 
    assign imm = Instruction[25];
    assign shift_op = Instruction[11:0];
    assign signed_imm_24 = Instruction[23:0];
    assign Dest = Instruction[15:12];
    assign two_src = C_mem_write | Instruction[25]; 

    ControlUnit CU(Instruction[27:26], Instruction[24:21], Instruction[20],
	               C_execute_command, C_mem_write, C_mem_read, C_WB_Enable, C_B, C_S);
   
    ConditionCheck CC(Instruction[31:28], Status, CC_Out);
	

    RegisterFile RF(clk, rst, Instruction[19:16], reg2 , Dest_wb,Result_WB,
                writeBackEn, Val_Rm, Val_Rn);
 
    
	  
endmodule
