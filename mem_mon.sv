class mem_mon extends uvm_monitor;
  virtual mem_intf vif;
	mem_tx tx;
	`uvm_component_utils(mem_mon)
	uvm_analysis_port #(mem_tx) ap_port;
	
	function new(string name=" ", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
      ap_port=new("ap_port",this);
      if(!uvm_config_db#(virtual mem_intf)::get(this,"","vif",vif))begin //vif=pif
          `uvm_error("mem_driver","Interface Retrival Failed");
		end
      `uvm_info("mem_mon","Inside mem_mon build_phase",UVM_MEDIUM);
	endfunction


	task run_phase(uvm_phase phase);
      `uvm_info("mem_mon","Inside mem_mon run_phase",UVM_MEDIUM);
      forever begin
        tx = mem_tx::type_id::create("tx");
          @(vif.mon_cb);
			
          if (vif.mon_cb.valid_i) begin
				tx.addr_i = vif.mon_cb.addr_i;
				tx.wr_rd_i = vif.mon_cb.wr_rd_i;

            if (vif.mon_cb.wr_rd_i) 
					tx.wdata_i = vif.mon_cb.wdata_i;

            wait(vif.mon_cb.ready_o == 1);
               @(vif.mon_cb);

            if (!vif.mon_cb.wr_rd_i) 
					tx.rdata_o = vif.mon_cb.rdata_o;
              tx.print();
              
            ap_port.write(tx);

				
			end
		end
	endtask

	
endclass
