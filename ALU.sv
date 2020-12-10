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
		4'b0001: begin//MOVbegin
			temp = B;
			status = {temp[31], (temp == 32'b0), 1'b0, 1'b0};
		end
		4'b1001: begin//MVN
			temp = ~B;
			status = {temp[31], (temp == 32'b0), 1'b0, 1'b0};
		end
		4'b0010: begin//ADD LDR STR
			temp = {A[31],A} + {B[31],B};
			status = {temp[31], (temp == 32'b0), temp[32], temp[31]^temp[32]};
		end
		4'b0011: begin//ADDC
			temp = {A[31],A} + {B[31],B} + cin;
			status = {temp[31], (temp == 32'b0), temp[32], temp[31]^temp[32]};
		end
		4'b0100: begin//SUB CMP
			temp = {A[31],A} - {B[31],B};
			status = {temp[31], (temp == 32'b0), temp[32], temp[31]^temp[32]};
		end
		4'b0101: begin//SUBC
			temp = {A[31],A} - {B[31],B} - cin;
			status = {temp[31], (temp == 32'b0), temp[32], temp[31]^temp[32]};
		end
		4'b0110: begin//AND and TSTSTR
			temp = A & B;
			status = {temp[31], (temp == 32'b0), 1'b0, 1'b0};
		end
		4'b0111: begin//OR
			temp = A | B;
			status = {temp[31], (temp == 32'b0), 1'b0, 1'b0};
		end
		4'b1000: begin//EOR
			temp = A ^ B;
			status = {temp[31], (temp == 32'b0), 1'b0, 1'b0};
		end
		default: begin
			temp = 0;
			status = {temp[31], (temp == 32'b0), 1'b0, 1'b0};
	 end
	endcase


  end

endmodule

