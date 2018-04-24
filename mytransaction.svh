

// this class houses a transaction
class MyTransaction extends uvm_sequence_item;

    // register this class with uvm
    `uvm_object_utils(MyTransaction)

	// enable for ModelSim
	logic [7:0] opA;
	logic [7:0] opB;
	
	// enable for others
    //rand logic [7:0] opA;
    //rand logic [7:0] opB;

	// enable for others
	// this is the base randomization function
	// which can be modified in MySequence class
    //constraint opA_Constraint { opA >= 0; opA < 256; }
    //constraint opB_Constraint { opB >= 0; opB < 256; }

	// constructor
    function new (string name = "");
        super.new(name);
    endfunction

	function string convert2string;
	    return $sformatf("opA=%d, opB=%d", opA, opB);
	endfunction
	
	// overridden from uvm_sequence_item class
	function void do_copy(uvm_object rhs);
	    MyTransaction tx;
		$cast(tx, rhs);
		opA = tx.opA;
		opB = tx.opB;
	endfunction
	
	// overridden from uvm_sequence_item class
	function bit do_compare(uvm_object rhs, uvm_comparer comparer);
	    MyTransaction tx;
		bit status = 1;
		$cast(tx, rhs);
		status &= (opA == tx.opA);
		status &= (opB == tx.opB);
		return status;
	endfunction
	
endclass

