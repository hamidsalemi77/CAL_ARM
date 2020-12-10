`timescale 1ns/1ns
module WB(
    input clk, rst, 
    input [3:0] WB_Dest,
    input WB_EN, MEM_R_EN,
    input [31:0] ALU_result, data, PC,
    
    output [3:0] WB_Dest_out,
    output WB_EN_out,
    output [31:0] WB_Value
);


assign WB_Dest_out = WB_Dest;
assign WB_EN_out = WB_EN;
assign WB_Value = MEM_R_EN ? data : ALU_result;

endmodule