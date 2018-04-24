

class MyEnv extends uvm_env;
    `uvm_component_utils(MyEnv)
    
    MyAgent agent;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        agent = MyAgent::type_id::create("agent", this);
    endfunction

endclass

