`timescale 1ns/1ns

module Val2_Generate(
  input [31:0] val_Rm_in,
  input imm, mem_en,
  input [11:0] shift_oprand,

  output [31:0] out
  );

reg [31:0] val2;
assign out = val2;

  
integer counter;



always@(*) begin
  if(mem_en)
    
    val2 = {{20{shift_oprand[11]}}, shift_oprand};
     
  else begin
    if(imm == 0)begin
        case(shift_oprand[6:5])
        2'b00:begin//logical left
             val2 = val_Rm_in;
              for(counter = 0; counter < shift_oprand[11:7]; counter = counter + 1)begin
                 val2 = {val2[30:0] , 1'b0};// val2[31:1] << shift_oprand;
              end
        end
    
      2'b01:begin//logical right
            val2 = val_Rm_in;
              for(counter = 0; counter < shift_oprand[11:7]; counter = counter + 1)begin
                 val2 = {1'b0, val2[31:1]};// val2[31:1] >> shift_oprand;
              end
        end
      
        2'b10:begin//arithmatic right
            val2 = val_Rm_in;
              for(counter = 0; counter < shift_oprand[11:7]; counter = counter + 1)begin
                 val2 = {val2[31], val2[31:1]}; // val2[31:1] >>> shift_oprand;
              end
        end
        2'b11:begin //rotate right
            val2 = val_Rm_in;
              for(counter = 0; counter < shift_oprand[11:7]; counter = counter + 1)begin
                 val2 = {val2[0], val2[31:1]}; 
                 //// reg[63:0] temp;
                 // temp = {val2,val2} >> shift_oprand;
                 // val2 = temp[31:0]
             end
        end
        endcase
    end
        
    else begin
      val2 = shift_oprand[7:0];
      for(counter = 0; counter < shift_oprand[11:8]; counter = counter + 1)begin
        val2 = {val2[1:0], val2[31:2]};
      end
    end
     
  end
end
endmodule
