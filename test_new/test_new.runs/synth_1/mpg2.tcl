# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/Paula Hreniuc/test_new/test_new.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Paula Hreniuc/test_new/test_new.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo {c:/Users/Paula Hreniuc/test_new/test_new.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {{C:/Users/Paula Hreniuc/test_new/test_new.srcs/sources_1/new/mpg2.vhd}}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Paula Hreniuc/test_new/test_new.srcs/constrs_1/new/constraints.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Paula Hreniuc/test_new/test_new.srcs/constrs_1/new/constraints.xdc}}]


synth_design -top mpg2 -part xc7a35tcpg236-1


write_checkpoint -force -noxdef mpg2.dcp

catch { report_utilization -file mpg2_utilization_synth.rpt -pb mpg2_utilization_synth.pb }