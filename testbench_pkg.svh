

package testbench_pkg;
    import uvm_pkg::*;
  
    `include "mytransaction.svh"
    `include "mysequence.svh"
    `include "mydriver.svh"
    `include "myagent.svh"
    `include "myenv.svh"
  
  
    class MyTest extends uvm_test;
        `uvm_component_utils(MyTest)
    
        MyEnv env;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction
    
        function void build_phase(uvm_phase phase);
            env = MyEnv::type_id::create("env", this);
        endfunction
    
        task run_phase(uvm_phase phase);
            // We raise objection to keep the test from completing
            phase.raise_objection(this);
      
	        #10;
            `uvm_warning("", "Hello World!")
	  
            // We drop objection to allow the test to complete
            phase.drop_objection(this);
        endtask

    endclass

endpackage

