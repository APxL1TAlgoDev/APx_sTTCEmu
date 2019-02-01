set_property SRC_FILE_INFO {cfile:/home/rrivera/CorrelatorTrigger/TimingDistribution/TimingDistributionClient/ctp7-v7-base-fw/build/ctp7_top/ctp7_top_project.srcs/sources_1/ip/ttc_mmcm/ttc_mmcm.xdc rfile:../../../ctp7_top_project.srcs/sources_1/ip/ttc_mmcm/ttc_mmcm.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1_p]] 0.25
