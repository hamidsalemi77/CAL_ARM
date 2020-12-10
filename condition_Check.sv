`timescale 1ns/1ns

module ConditionCheck(
	input[3:0] cond,
	input [3:0] status,
	output reg out);
	
logic z,n,c,v;
assign n = status[3];
assign z = status[2];
assign c = status[1];
assign v = status[0];
always @(*) begin
 
  if(cond == 4'b0000)//EQ
    if(z == 1'b1)
      out = 1'b1;
	  else
		  out = 1'b0;
  else
  if(cond == 4'b0001)//NE
    if(z == 1'b0)
      out = 1'b1;
    else
		out = 0;
  else
  if(cond == 4'b0010)//CS/HS
    if(c)
      out = 1'b1;
	 else
		out = 0;
  else
  if(cond == 4'b0011)//CC/LO
    if(~c)
      out = 1'b1;
    else
		out = 0;
  else
  if(cond == 4'b0100)//MI
    if(n)
      out = 1'b1;
	 else
		out = 0;
  else
  if(cond == 4'b0101)//PL
    if(~n)
      out = 1'b1;
	 else
		out = 0;
  else   
  if(cond == 4'b0110)//VS
    if(v)
      out = 1'b1;
	 else
		out = 0;
  else
  if(cond == 4'b0111)//VC
    if(~v)
      out = 1'b1;
	 else
		out = 0;
  else
  if(cond == 4'b1000)//HI
    if(c & ~z)
      out = 1'b1;
	 else
		out = 0;
  else
  if(cond == 4'b1001)//LS
    if(~c | z)
      out = 1'b1;
    else
		out = 0;
  else
  if(cond == 4'b1010)//GE
    if(n == v)
      out = 1'b1;
	 else
		out = 0;
  else
  if(cond == 4'b1011)//LT
    if(n != v)
      out = 1'b1;
	 else
		out = 0;
  else
  if(cond == 4'b1100)//GT
    if((n == v) & (z == 0))
      out = 1'b1;
	 else
		out = 0;
  else
  if(cond == 4'b1101)//LE
    if((n != v) & (z == 1))
      out = 1'b1;
	 else
		out = 0;
	else
	if(cond == 4'b1110)//AL
    out = 1'b1;
  else
		out = 0;
	 
end

endmodule