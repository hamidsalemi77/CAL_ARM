`timescale 1ns/1ns

module IF_ID(input clk, rst, flush, freeze,
            input [31:0] instruction_in, pcin,
             output reg [31:0] Instruction, PC);
  always@(posedge clk, posedge rst ) begin
    if(rst)
      {Instruction, PC} = 64'b0;
    else begin
       if(flush)
        {Instruction, PC} = 64'b0;
       else begin
         if (~freeze) begin
            Instruction <= instruction_in;
            PC <= pcin;  
         end
          
         
     end
   end
  end
endmodule


