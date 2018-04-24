#-suppress 2167

# Compile UVM
+incdir+../../../Libraries/uvm-1.2/src
../../../Libraries/uvm-1.2/src/uvm.sv
#../../../Libraries/uvm-1.2/src/dpi/uvm_dpi.cc


# turn off dpi so we don't have to compile the uvm dpi c files
+define+UVM_CMDLINE_NO_DPI
+define+UVM_REGEX_NO_DPI
+define+UVM_NO_DPI


#-sv 

# Compile the testbench

dut.sv
top.sv

