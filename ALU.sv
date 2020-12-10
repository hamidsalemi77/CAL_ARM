`timescale 1ns/1ns

module ALU (
  input [31:0] A, B,
  input [3:0] EXE_CMD,
  input cin,
  //NZCV
  output reg [3:0] status,
  output reg [31:0] out
);

  reg [32:0] temp;
  assign out = temp[31:0];

  always @ (*) begin	 
	 case(EXE_CMD)
		4'b0001: //MOV
			temp = B;
			status = {temp[31], (temp == 32'b0), 1'b0, 1'b0};
		4'b1001: //MVN
			temp = ~B;
			status = {temp[31], (temp == 32'b0), 1'b0, 1'b0};
		4'b0010: //ADD LDR STR
			temp = {A[31],A} + {B[31],B};
			status = {temp[31], (temp == 32'b0), temp[32], temp[31]^temp[32]};
		4'b0011: //ADDC
			temp = {A[31],A} + {B[31],B} + cin;
			status = {temp[31], (temp == 32'b0), temp[32], temp[31]^temp[32]};
		4'b0100: //SUB CMP
			temp = {A[31],A} - {B[31],B};
			status = {temp[31], (temp == 32'b0), temp[32], temp[31]^temp[32]};
		4'b0101: //SUBC
			temp = {A[31],A} - {B[31],B} - cin;
			status = {temp[31], (temp == 32'b0), temp[32], temp[31]^temp[32]};
		4'b0110: //AND and TSTSTR
			temp = A & B;
			status = {temp[31], (temp == 32'b0), 1'b0, 1'b0};
		4'b0111: //OR
			temp = A | B;
			status = {temp[31], (temp == 32'b0), 1'b0, 1'b0};
		4'b1000: //EOR
			temp = A ^ B;
			status = {temp[31], (temp == 32'b0), 1'b0, 1'b0};
		default:
			temp = 0;
			status = {temp[31], (temp == 32'b0), 1'b0, 1'b0};
	endcase


  end

endmodule

