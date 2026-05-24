# Single-Port-Ram
Designed and verified a configurable Single Port RAM using Verilog/SystemVerilog RTL and UVM-based verification methodology. The project focused on validating memory read/write functionality, address decoding, data integrity, and protocol correctness under different operating scenarios.

Developed synthesizable RTL for Single Port RAM supporting synchronous read/write operations with configurable data width and memory depth. Implemented comprehensive UVM Testbench architecture including Driver, Monitor, Sequencer, Agent, Scoreboard, Environment, and Functional Coverage components for reusable and scalable verification.

Created constrained-random and directed test cases to verify:

Write and Read operations
Random address/data transactions
Back-to-back memory accesses
Boundary and corner case scenarios
Reset behavior and memory initialization
Data consistency and overwrite conditions

Implemented assertions (SVA) to validate protocol behavior and timing checks. Functional and code coverage metrics were used to ensure complete verification closure.

Used industry-standard simulation and debugging tools such as:

Synopsys VCS
QuestaSim
Verdi

Technologies Used:
SystemVerilog, UVM, Verilog RTL, SVA, Functional Coverage, Constrained Random Verification
