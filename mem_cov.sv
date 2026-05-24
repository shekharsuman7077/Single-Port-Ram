class mem_cov extends uvm_subscriber#(mem_tx);
	
  	mem_tx tx;
	`uvm_component_utils(mem_cov)
  
   covergroup cg;
    WR_RD_CP: coverpoint tx.wr_rd_i
    {
      bins WRITE = {1'b1};
      bins READ  = {1'b0};
    }
    
    ADDR_CP: coverpoint tx.addr_i
    {
      bins addr0= {4'b0000};
      bins addr1= {4'b0001};
      bins addr2= {4'b0010};
      bins addr3= {4'b0011};
      bins addr4= {4'b0100};
      bins addr5= {4'b0101};
      bins addr6= {4'b0110};
      bins addr7= {4'b0111};
      bins addr8= {4'b1000};
      bins addr9= {4'b1001};
      bins addr10={4'b1010};
      bins addr11={4'b1011};
      bins addr12={4'b1100};
      bins addr13={4'b1101};
      bins addr14={4'b1110};
      bins addr15={4'b1111};
    }
    
//     WR_RD_CP_X_ADDR_CP: cross WR_RD_CP, ADDR_CP;
  endgroup
	
  
  	function new(string name=" ", uvm_component parent=null);
		super.new(name,parent);
      	cg=new();
	endfunction

	
  
  
  	virtual function void write(mem_tx t);
      $cast(tx,t);
      cg.sample();
	endfunction
endclass
