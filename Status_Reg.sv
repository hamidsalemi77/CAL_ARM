`timescale 1ns/1ns

module Status_Reg(
  input clk, rst,
  input Load,
  input [3:0] status_in,
  output reg [3:0] status
  );
  
  
  always @ (negedge clk)begin
    if(rst)
      status <= 4'b0;
    else
      if(Load)begin
        status <= status_in;
		  end
  end
endmodule
