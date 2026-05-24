module top;
reg clk_i,rst_i;

mem_intf pif(clk_i,rst_i);

memory #(.WIDTH(WIDTH),.DEPTH(DEPTH),.ADDR_WIDTH(ADDR_WIDTH)) dut(
		.clk_i(pif.clk_i),
		.rst_i(pif.rst_i),
		.valid_i(pif.valid_i),
		.ready_o(pif.ready_o),
		.wr_rd_i(pif.wr_rd_i),
		.wdata_i(pif.wdata_i),
  		.rdata_o(pif.rdata_o),
  		.addr_i(pif.addr_i)
);

always #5 clk_i=~clk_i;

initial begin
	clk_i=0;
	rst_i=1;
	reset();
  repeat(2)@(posedge clk_i);
	rst_i=0;
end

initial begin
	uvm_config_db#(virtual mem_intf)::set(uvm_root::get(),"*","vif",pif);
end
initial begin
  run_test(" ");
end
  
initial begin
  $dumpfile("dump.vcd");
  $dumpvars;
end

task reset();
	pif.valid_i=0;
	pif.wr_rd_i=0;
	pif.addr_i=0;
	pif.wdata_i=0;
endtask
endmodule
