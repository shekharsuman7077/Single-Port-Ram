interface mem_intf(input clk_i,rst_i);
	bit valid_i;
	bit wr_rd_i;
	bit [ADDR_WIDTH-1:0] addr_i;
	bit [WIDTH-1:0] wdata_i;
	bit ready_o;
	bit [WIDTH-1:0] rdata_o;

  clocking bfm_cb@(posedge clk_i);
    default input #0 output #1; //#0- inputs skews, #1- output skew
    input rdata_o;
    input ready_o;
    output wr_rd_i;
    output addr_i;
    output wdata_i;
    output valid_i;
  endclocking
  
  clocking mon_cb@(posedge clk_i);
    default input #0;
    input rdata_o,ready_o,wr_rd_i,addr_i,wdata_i,valid_i;
  endclocking
  
  int fail;
  
    property p_rst_i;
    @(posedge clk_i) rst_i |-> ##0 (valid_i==0&&ready_o==0&&rdata_o==0&&wdata_i==0&&wr_rd_i==0);
    endproperty
    assert property(p_rst_i)
    else begin 
      $display("Assertion for p_rst_i FAILED");
      fail++;
    end
      
  property p_valid_i_ready_o;
    @(posedge clk_i) valid_i==1|=>##0 ready_o==1;
  endproperty
  assert property(p_valid_i_ready_o)
    else begin 
      $display("Assertion for p_valid_i_ready_o FAILED");
      fail++;
    end
 
    property p_addr;
      @(posedge clk_i) wr_rd_i==1|-> ##0 !($isunknown(addr_i));
    endproperty
    assert property(p_addr)
    else begin 
      $display("Assertion for p_addr FAILED");
      fail++;
    end
    
      
    property p_wdata_i;
      @(posedge clk_i) (wr_rd_i==1&&valid_i==1)|-> ##0 !($isunknown(wdata_i));
    endproperty
    assert property(p_wdata_i)
    else begin 
      $display("Assertion for p_wdata_i FAILED");
      fail++;
    end
      
    property p_rdata_o;
      @(posedge clk_i) (wr_rd_i==0&&valid_i==1&&ready_o==1)|-> ##0 !($isunknown(rdata_o));
    endproperty
      assert property(p_rdata_o)
    else begin 
      $display("Assertion for p_rdata_o FAILED");
      fail++;
    end

endinterface