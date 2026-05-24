class mem_sbd extends uvm_scoreboard;
  
  mem_tx tx, txQ[$];
  
  bit [WIDTH-1:0] mem[int];
  bit [WIDTH-1:0] actual_data;
  bit [WIDTH-1:0] expected_data;
	
  uvm_analysis_imp #(mem_tx, mem_sbd) sbd_imp;
	`uvm_component_utils(mem_sbd)
	
	function new(string name=" ", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
      `uvm_info("mem_sbd","Inside mem_sbd build_phase",UVM_MEDIUM);
		sbd_imp = new("sbd_imp", this);
	endfunction

	
	task run_phase(uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("mem_sbd","Inside mem_sbd run_phase",UVM_MEDIUM);
      forever begin
        tx=new();
      wait(txQ.size()>0);
      tx=txQ.pop_front();
      if(tx.wr_rd_i)begin
        mem[tx.addr_i]=tx.wdata_i;
      end
      else begin
        actual_data=tx.rdata_o;
        expected_data=mem[tx.addr_i];
        if(actual_data==expected_data)begin
          $display("************************TESTCASE PASSED*********************");
          mem_common::match++;
        end
        else begin
          $display("***********************TESTCASE FAILED**********************");
        	mem_common::mismatch++;
        end
      end
      end
	endtask

	
  	
  	virtual function void write(mem_tx t);
    	txQ.push_back(t);
	endfunction
endclass
