`timescale 1ns/1ns
module ID(input clk, rst,
            input[31:0] pcin,
            output[31:0] PC);
    
     assign PC = pcin; 
            
endmodule
