

`include "uvm_macros.svh"
`include "testbench_pkg.svh"


module top;
    import uvm_pkg::*;
	import testbench_pkg::*;
	
	
	// Instantiate the interface
	dutInterface dutInterface1();

	// Instantiate the DUT and connect it to the interface
	dut dut1(.dif(dutInterface1));
	
	// Clock generator
	initial begin
	    dutInterface1.clk = 1'b0;
		forever #5 dutInterface1.clk = ~dutInterface1.clk;
	end
	
	// Configure uvm database and run tests
	initial begin
	    // Map the Instantiated DUT interface in this module to the uvm object database
		// we use null and "*" here because this is the top level and not a sub component
		uvm_config_db #(virtual dutInterface)::set(null, "*", "dutVirtualInterface", dutInterface1);
		// set $finish when when we are done testing
		//uvm_top.finish_on_completion = 1; // might not have to do this in uvm 1.2???
		
		// Start the test
        run_test("MyTest");
	end
	
	// Dump waves
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, top);
    end
endmodule

