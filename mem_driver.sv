class mem_driver extends uvm_driver#(mem_tx);
	
	virtual mem_intf vif;
	`uvm_component_utils(mem_driver)
	
	function new(string name=" ", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
      		`uvm_info("mem_driver","Inside mem_driver build_phase",UVM_MEDIUM);
		if(!uvm_config_db#(virtual mem_intf)::get(this,"","vif",vif))begin //vif=pif
          `uvm_error("mem_driver","Interface Retrival Failed");
		end
	endfunction

	
	

	task run_phase(uvm_phase phase);
      wait(vif.rst_i==0);
	forever begin
  		seq_item_port.get_next_item(req);//driver is asking and sequencer is giving item in req variable
		drive_tx(req);
		req.print();
		seq_item_port.item_done();//this tells to the sequencer that the item was driven to  dut
	end
	endtask

	
  task drive_tx(mem_tx tx);
	@(vif.bfm_cb);
	vif.bfm_cb.valid_i<=1;
	vif.bfm_cb.wr_rd_i<=tx.wr_rd_i;
	vif.bfm_cb.addr_i<=tx.addr_i;
    if(tx.wr_rd_i)
		vif.bfm_cb.wdata_i<=tx.wdata_i;
    	wait(vif.bfm_cb.ready_o==1);
      @(vif.bfm_cb);

    if(!tx.wr_rd_i)
		tx.rdata_o=vif.bfm_cb.rdata_o;
		vif.bfm_cb.valid_i<=0;
		vif.bfm_cb.wr_rd_i<=0;
		vif.bfm_cb.addr_i<=0;
		vif.bfm_cb.wdata_i<=0;	
	endtask
endclass
