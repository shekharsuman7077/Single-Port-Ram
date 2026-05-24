class base_test extends uvm_test;
	
	mem_env env;	
  `uvm_component_utils(base_test)
	
	function new(string name=" ", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env=mem_env::type_id::create("env",this);
		`uvm_info("base_test","Inside base_test build_phase",UVM_MEDIUM)
    endfunction

	
	function void end_of_elaboration_phase(uvm_phase phase);
		`uvm_info("base_test","Inside base_test end_of_elaboration_phase",UVM_MEDIUM)
		uvm_top.print_topology();
	endfunction
  
  function void report_phase(uvm_phase phase);
    $display("*********COVERAGE*******=%0f",env.agent.cov.cg.get_coverage());
  endfunction

endclass


class test_1wr extends base_test;
	
  `uvm_component_utils(test_1wr)
	`NEW_COMP

task run_phase(uvm_phase phase);
	seq_1wr seq;
	seq = seq_1wr::type_id::create("seq");
	phase.raise_objection(this);
	seq.start(env.agent.sqr);
	phase.drop_objection(this);
	phase.phase_done.set_drain_time(this,100);
endtask
  
  class test_1wr_1rd extends base_test;
    `uvm_component_utils(test_1wr_1rd)
    `NEW_COMP
    
    task run_phase(uvm_phase phase);
    	seq_1wr_1rd seq;
      	seq = seq_1wr_1rd::type_id::create("seq");
        phase.raise_objection(this);
        seq.start(env.agent.sqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this,100);
    endtask
  endclass
  
  class test_conc_wr_rd extends base_test;
    `uvm_component_utils(test_conc_wr_rd)
    `NEW_COMP
    
    task run_phase(uvm_phase phase);
    	seq_conc_wr_rd seq;
      	seq = seq_conc_wr_rd::type_id::create("seq");
        phase.raise_objection(this);
        seq.start(env.agent.sqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this,100);
    endtask
  endclass
  
   class test_nwr_nrd extends base_test;
     `uvm_component_utils(test_nwr_nrd)
    `NEW_COMP
    
    task run_phase(uvm_phase phase);
    	seq_nwr_nrd seq;
      	seq = seq_nwr_nrd::type_id::create("seq");
        phase.raise_objection(this);
        seq.start(env.agent.sqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this,100);
    endtask
  endclass
  
  class test_check_cov extends base_test;
    `uvm_component_utils(test_check_cov)
    `NEW_COMP
    
    task run_phase(uvm_phase phase);
    	check_cov seq;
      	seq = check_cov::type_id::create("seq");
        phase.raise_objection(this);
        seq.start(env.agent.sqr);
        phase.drop_objection(this);
        phase.phase_done.set_drain_time(this,100);
    endtask
  endclass
  
  
endclass
