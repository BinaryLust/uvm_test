

interface dutInterface;
    logic       clk;
	logic       reset;
	logic [7:0] opA;
	logic [7:0] opB;
	//logic       result;
endinterface

`include "uvm_macros.svh"

// this is a dummy design just to print transactions out
module dut(dutInterface dif);
    import uvm_pkg::*;
	always @(posedge dif.clk) begin
	    if(!dif.reset) begin
		    `uvm_info("DUT", $sformatf("opA = %h, opB = %h", dif.opA, dif.opB), UVM_MEDIUM)
		end
	end
endmodule

