if [file exists "work"] {vdel -all}
vlib work
vlog -f compile_sv.f 
vsim -L altera_mf_ver -L lpm_ver top -novopt -assertdebug
onbreak {resume}
log -r /*
run -all

