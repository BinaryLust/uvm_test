

class MyDriver extends uvm_driver #(MyTransaction);
    
	// register this class with uvm
	`uvm_component_utils(MyDriver)

	// this is a virtual interface so is actually just a pointer to an actual interface
    virtual dutInterface dutVirtualInterface;

	
	// constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

	
	// this is a function because we want this to run without consuming any simulation time
    function void build_phase(uvm_phase phase);
        // Get interface reference from config database
        if(!uvm_config_db#(virtual dutInterface)::get(this, "", "dutVirtualInterface", dutVirtualInterface)) begin
            `uvm_error("", "uvm_config_db::get failed")
        end
    endfunction 

	
	// this is a task because this needs to consume simulation time
    task run_phase(uvm_phase phase);
        // First toggle reset
        dutVirtualInterface.reset = 1'b1;
		dutVirtualInterface.opA   = 8'b0;
        dutVirtualInterface.opB   = 8'b0;
        @(posedge dutVirtualInterface.clk);
        #1;
        dutVirtualInterface.reset = 1'b0;
    
	    // seq_item_port and req are inherited from the uvm_driver super class???
        
		// Now drive normal traffic
        forever begin
            seq_item_port.get_next_item(req); // this gets a transaction from the sequencer

            // Wiggle pins of DUT
            dutVirtualInterface.opA = req.opA;
            dutVirtualInterface.opB = req.opB;
            @(posedge dutVirtualInterface.clk);

            seq_item_port.item_done();
        end
    endtask

endclass

