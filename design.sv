module memory(clk_i,rst_i,valid_i,ready_o,wr_rd_i,addr_i,wdata_i,rdata_o);

	parameter WIDTH=16;
	parameter DEPTH=16;
	parameter ADDR_WIDTH=$clog2(DEPTH);

	input wire clk_i, rst_i, valid_i, wr_rd_i;
	input wire [ADDR_WIDTH-1:0]addr_i;
	input wire [WIDTH-1:0]wdata_i;

	output reg ready_o;
	output reg [WIDTH-1:0]rdata_o;

	reg [WIDTH-1:0]mem[DEPTH-1:0];
	
	integer i;
	
always@(posedge clk_i or posedge rst_i)begin
	if(rst_i)begin
		ready_o<=0;
		rdata_o<=0;
		for(i=0;i<DEPTH;i=i+1)mem[i]<=0;
    end
	
	else begin
      if(valid_i)begin
			ready_o<=1;
			if(wr_rd_i)mem[addr_i]<=wdata_i;
			else rdata_o<=mem[addr_i];
		end
		else begin
			ready_o<=0;
			rdata_o<=0;
		end
	end
end


endmodule