class mem_agent extends uvm_agent;
	
	mem_sqr sqr;
	mem_driver drv;
	mem_mon mon;
	mem_cov cov;
	

	`uvm_component_utils(mem_agent)
	


	
	function new(string name=" ", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("mem_agent","Inside Build phase of mem_agent",UVM_MEDIUM)
		sqr   	 =  mem_sqr::type_id::create("sqr",this);
		drv	 =  mem_driver::type_id::create("drv",this);
		mon	 =  mem_mon::type_id::create("mon",this);
		cov	 =  mem_cov::type_id::create("cov",this);
	endfunction

	
	function void connect_phase(uvm_phase phase);
		`uvm_info("mem_agent","Inside connect phase of mem_agent",UVM_MEDIUM)
		drv.seq_item_port.connect(sqr.seq_item_export);
		mon.ap_port.connect(cov.analysis_export);
	endfunction

endclass
