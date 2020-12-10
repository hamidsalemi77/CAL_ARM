`timescale 1ns/1ns
module ID_EX(input clk, rst,
            input[31:0] pcin,
            output reg[31:0] PC);
    
    always@(posedge clk, posedge rst ) begin
      if(rst)
       PC = 32'b0;
      else 
       PC = pcin;
    end
            
endmodule
