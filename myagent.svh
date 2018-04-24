

  // The agent contains sequencer, driver, and monitor (not included)
class MyAgent extends uvm_agent;
    `uvm_component_utils(MyAgent)
    
    MyDriver                       driver;
    uvm_sequencer #(MyTransaction) sequencer;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        // create a driver from MyDriver class
		driver    = MyDriver::type_id::create("driver", this);
        // we are using the base uvm sequencer here
		sequencer = uvm_sequencer#(MyTransaction)::type_id::create("sequencer", this);
    endfunction    
    
    // In UVM connect phase, we connect the sequencer to the driver.
    function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
    
    task run_phase(uvm_phase phase);
        // We raise objection to keep the test from completing
        phase.raise_objection(this);
        
		begin
            MySequence seq;
            seq = MySequence::type_id::create("seq"); // this creates a MySequence object named "seq"
            seq.start(sequencer);                     // this runs MySequence on the sequencer
			// we could run the sequence higher up in the classes in MyTest instead maybe.
        end
		
        // We drop objection to allow the test to complete
        phase.drop_objection(this);
    endtask

endclass

