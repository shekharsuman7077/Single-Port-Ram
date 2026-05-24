parameter  WIDTH = 16;
parameter  DEPTH = 16;
parameter  ADDR_WIDTH=$clog2(DEPTH);
int count=5;



`define NEW_COMP \
function new(string name=" ", uvm_component parent=null);\
  super.new(name,parent);\
endfunction

`define NEW_OBJ \
function new(string name=" ");\
	super.new(name);\
endfunction

class mem_common;
	static int match,mismatch;
endclass