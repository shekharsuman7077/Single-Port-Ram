class base_seq extends uvm_sequence#(mem_tx);
	`uvm_object_utils(base_seq)

	`NEW_OBJ

task pre_body();
endtask

task post_body();
endtask
endclass

class seq_1wr extends base_seq;
	`uvm_object_utils(seq_1wr);
	`NEW_OBJ

task body();
	//create the tx
	//we randomize the tx
	//we placed in the mailbox
	//`uvm_do(req)//without any constraint 
  `uvm_do_with(req,{req.wr_rd_i==1;})//with constraint 
endtask
endclass

class seq_1wr_1rd extends base_seq;
  `uvm_object_utils(seq_1wr_1rd)
  `NEW_OBJ
  mem_tx tx,Q[$];
  
  task body();
    repeat(1)begin
    `uvm_do_with(req,{req.wr_rd_i==1;})
    Q.push_back(req);
    end
    repeat(1)begin
    tx=Q.pop_front();
    `uvm_do_with(req,{req.wr_rd_i==0; req.addr_i==tx.addr_i;req.wdata_i==0;})
    end
  endtask
endclass

class seq_nwr_nrd extends base_seq;
  `uvm_object_utils(seq_nwr_nrd)
  `NEW_OBJ
  mem_tx tx,Q[$];
  
  task body();
    repeat(count)begin
    `uvm_do_with(req,{req.wr_rd_i==1;})
    Q.push_back(req);
    end
    repeat(count)begin
    tx=Q.pop_front();
    `uvm_do_with(req,{req.wr_rd_i==0; req.addr_i==tx.addr_i;req.wdata_i==0;})
    end
  endtask
endclass

class seq_conc_wr_rd extends base_seq;
  `uvm_object_utils(seq_conc_wr_rd)
  `NEW_OBJ
  seq_1wr_1rd s;
  
  task body();
    repeat(16)begin
    `uvm_do(s)
    end
  endtask
endclass

class check_cov extends base_seq;
  `uvm_object_utils(check_cov)
  `NEW_OBJ
  mem_tx tx,Q[$];
  bit [ADDR_WIDTH-1:0]temp[$];
  
  task body();
    bit [ADDR_WIDTH-1:0]temp_addr;
    int i=0;
    
    repeat(16)begin
      while(temp_addr inside {temp})begin
        temp_addr=$urandom_range(0,DEPTH-1);
      end
      
      temp.push_back(temp_addr);
      
      `uvm_do_with(req,{req.wr_rd_i==1;req.addr_i==temp_addr;})
      Q.push_back(req);
    end
    repeat(16)begin
      tx=Q.pop_front();
      `uvm_do_with(req,{req.wr_rd_i==0;req.addr_i==tx.addr_i;req.wdata_i==0;})
    end
  endtask
endclass



