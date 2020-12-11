module Hazard_Unit(
    input rst,
    input [3:0] src1, src2, EXE_Dest,
    input EXE_WB_EN,
    input [3:0] Mem_Dest,
    input MEM_WB_EN,
    input two_src,
    output hazard_detection
);

  reg out;
  
  assign hazard_detection = out;
  
  always@(*)begin
    if(rst)
      out = 0;
    else begin
      
			if(two_src) begin
				if(((EXE_WB_EN & (src2 == EXE_Dest)) | (MEM_WB_EN & (src2 == Mem_Dest)) | (MEM_WB_EN & (src1 == Mem_Dest)) | (EXE_WB_EN & (src1 == EXE_Dest))))begin
					out = 1'b1;
				end
				else  	
					out = 0;
			end
			else begin
				if(((MEM_WB_EN & (src1 == Mem_Dest)) | (EXE_WB_EN & (src1 == EXE_Dest))))begin
					out = 1'b1;
				end
				else  	
					out = 0;
					end
      end
	  end
    


  
endmodule





