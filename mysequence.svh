

// this class creates a series of transaction objects
class MySequence extends uvm_sequence #(MyTransaction);

    // register this class with uvm
    `uvm_object_utils(MySequence)

	// constructor
    function new (string name = "");
        super.new(name);
    endfunction

	// this is the main method that generates transactions
    task body;
	    //if(starting_phase != null) // might not need to do this in uvm 1.2???
		//    starting_phase.raise_objection(this);
		
        repeat(8) begin
            // create a new transaction object
			req = MyTransaction::type_id::create("req");
            
			start_item(req);

            //if (!req.randomize()) begin
            //    `uvm_error("MySequence", "Randomize failed.");
            //end

            // If using ModelSim, which does not support randomize(),
            // we must randomize item using traditional methods, like
            req.opA = $urandom_range(0, 255);
            req.opB = $urandom_range(0, 255);

            finish_item(req);
        end
		
	    //if(starting_phase != null) // might not need to do this in uvm 1.2???
		//    starting_phase.drop_objection(this);
    endtask

endclass

