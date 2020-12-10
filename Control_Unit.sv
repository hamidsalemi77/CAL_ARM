`timescale 1ns/1ns
module ControlUnit(
	input[1:0] mode,
	input[3:0] op_code,
	input S_in,
	 
	output reg [3:0] execute_command,
	output reg mem_write, mem_read, WB_Enable, B, S
);

always@(*)begin
	if(mode == 2'b00)begin
		case(op_code)
		4'b1101: begin//MOVE
			execute_command = 4'b0001;
			S = S_in;
			mem_read = 0; mem_write = 0; B = 0; WB_Enable = 1;
		end
		4'b1111: begin//MVN
			execute_command = 4'b1001;
			S = S_in;
			mem_read = 0; mem_write = 0; B = 0; WB_Enable = 1;
		end
		4'b0100: begin//ADD
			execute_command = 4'b0010;
			S = S_in;
			mem_read = 0; mem_write = 0; B = 0; WB_Enable = 1;
		end
		4'b0101: begin//ADDC
			execute_command = 4'b0011;
			S = S_in;
			mem_read = 0; mem_write = 0; B = 0; WB_Enable = 1;
		end
		4'b0010: begin//SUB
			execute_command = 4'b0100;
			S = S_in;
			mem_read = 0; mem_write = 0; B = 0; WB_Enable = 1;
		end
		4'b0110: begin//SBC
			execute_command = 4'b0101;
			S = S_in;
			mem_read = 0; mem_write = 0; B = 0; WB_Enable = 1;
		end
		4'b0000: begin//AND
			execute_command = 4'b0110;
			S = S_in;
			mem_read = 0; mem_write = 0; B = 0; WB_Enable = 1;
		end
		4'b1100: begin//OR
			execute_command = 4'b0111;
			S = S_in;
			mem_read = 0; mem_write = 0; B = 0; WB_Enable = 1;
		end
		4'b0001: begin //XOR
			execute_command = 4'b1000;
			S = S_in;
			mem_read = 0; mem_write = 0; B = 0; WB_Enable = 1;
		end
		4'b1010: begin //CMP
			execute_command = 4'b0100;
			S = 1;
			mem_read = 0; mem_write = 0; B = 0; WB_Enable = 0;
		end
		4'b1000: begin//TEST
			execute_command = 4'b0110;
			S = 1;
			mem_read = 0; mem_write = 0; B = 0; WB_Enable = 0;
		end
		default:begin
			execute_command = 4'b0000;
			mem_read = 1'b0;S = 0; mem_write = 0; B = 0; WB_Enable = 0;
			end
		endcase
	end
	else
		if(mode == 2'b01)begin
		//LOAD
			if(S_in == 1'b1)
				if(op_code == 4'b0100)begin
					execute_command = 4'b0010;
					S = 0;
					mem_read = 1'b1; mem_write = 1'b0; B = 1'b0; WB_Enable = 1'b1;
				end
				else begin
					execute_command = 4'b0000;
					mem_read = 0; S = 0; mem_write = 0; B = 0; WB_Enable = 0;
				end

		//STORE
			else
				if(op_code == 4'b0100)begin
					execute_command = 4'b0010;
					S = 0;
					mem_read = 1'b0; mem_write = 1'b1; B = 1'b0; WB_Enable = 1'b0;
				end
				else begin
					execute_command = 4'b0000;
					mem_read = 0; S = 0; mem_write = 0; B = 0; WB_Enable = 0;
				end
		end
	else
	if(mode == 2'b10)begin
	//B	
		execute_command = 4'b0000;//just for fun :) ?
		//is zero?
		S = 0;
		mem_read = 0; mem_write = 0; B = 1'b1; WB_Enable = 1'b0;
	end
	else begin
		execute_command = 4'b0000;
		S = 0;
		mem_read = 0; mem_write = 0; B = 1'b1; WB_Enable = 1'b0;
	end

end

endmodule