create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 6 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list U_ttc_core/i_ctp7_ttc_clocks/inst/clk_ttc120_out]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 7 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {gbt_tx_data_source[0]} {gbt_tx_data_source[1]} {gbt_tx_data_source[2]} {gbt_tx_data_source[3]} {gbt_tx_data_source[4]} {gbt_tx_data_source[5]} {gbt_tx_data_source[6]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 3 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {reset_state[0]} {reset_state[1]} {reset_state[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 40 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {s_gth_gbt_rx_data_arr[0][0]} {s_gth_gbt_rx_data_arr[0][1]} {s_gth_gbt_rx_data_arr[0][2]} {s_gth_gbt_rx_data_arr[0][3]} {s_gth_gbt_rx_data_arr[0][4]} {s_gth_gbt_rx_data_arr[0][5]} {s_gth_gbt_rx_data_arr[0][6]} {s_gth_gbt_rx_data_arr[0][7]} {s_gth_gbt_rx_data_arr[0][8]} {s_gth_gbt_rx_data_arr[0][9]} {s_gth_gbt_rx_data_arr[0][10]} {s_gth_gbt_rx_data_arr[0][11]} {s_gth_gbt_rx_data_arr[0][12]} {s_gth_gbt_rx_data_arr[0][13]} {s_gth_gbt_rx_data_arr[0][14]} {s_gth_gbt_rx_data_arr[0][15]} {s_gth_gbt_rx_data_arr[0][16]} {s_gth_gbt_rx_data_arr[0][17]} {s_gth_gbt_rx_data_arr[0][18]} {s_gth_gbt_rx_data_arr[0][19]} {s_gth_gbt_rx_data_arr[0][20]} {s_gth_gbt_rx_data_arr[0][21]} {s_gth_gbt_rx_data_arr[0][22]} {s_gth_gbt_rx_data_arr[0][23]} {s_gth_gbt_rx_data_arr[0][24]} {s_gth_gbt_rx_data_arr[0][25]} {s_gth_gbt_rx_data_arr[0][26]} {s_gth_gbt_rx_data_arr[0][27]} {s_gth_gbt_rx_data_arr[0][28]} {s_gth_gbt_rx_data_arr[0][29]} {s_gth_gbt_rx_data_arr[0][30]} {s_gth_gbt_rx_data_arr[0][31]} {s_gth_gbt_rx_data_arr[0][32]} {s_gth_gbt_rx_data_arr[0][33]} {s_gth_gbt_rx_data_arr[0][34]} {s_gth_gbt_rx_data_arr[0][35]} {s_gth_gbt_rx_data_arr[0][36]} {s_gth_gbt_rx_data_arr[0][37]} {s_gth_gbt_rx_data_arr[0][38]} {s_gth_gbt_rx_data_arr[0][39]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 4 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {s_gth_gbt_rx_data_arr[1][36]} {s_gth_gbt_rx_data_arr[1][37]} {s_gth_gbt_rx_data_arr[1][38]} {s_gth_gbt_rx_data_arr[1][39]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 4 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {s_gth_gbt_rx_data_arr[2][0]} {s_gth_gbt_rx_data_arr[2][1]} {s_gth_gbt_rx_data_arr[2][2]} {s_gth_gbt_rx_data_arr[2][3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 4 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {s_gth_gbt_rx_data_arr[3][0]} {s_gth_gbt_rx_data_arr[3][1]} {s_gth_gbt_rx_data_arr[3][2]} {s_gth_gbt_rx_data_arr[3][3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 32 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {scratch_pad_input[0]} {scratch_pad_input[1]} {scratch_pad_input[2]} {scratch_pad_input[3]} {scratch_pad_input[4]} {scratch_pad_input[5]} {scratch_pad_input[6]} {scratch_pad_input[7]} {scratch_pad_input[8]} {scratch_pad_input[9]} {scratch_pad_input[10]} {scratch_pad_input[11]} {scratch_pad_input[12]} {scratch_pad_input[13]} {scratch_pad_input[14]} {scratch_pad_input[15]} {scratch_pad_input[16]} {scratch_pad_input[17]} {scratch_pad_input[18]} {scratch_pad_input[19]} {scratch_pad_input[20]} {scratch_pad_input[21]} {scratch_pad_input[22]} {scratch_pad_input[23]} {scratch_pad_input[24]} {scratch_pad_input[25]} {scratch_pad_input[26]} {scratch_pad_input[27]} {scratch_pad_input[28]} {scratch_pad_input[29]} {scratch_pad_input[30]} {scratch_pad_input[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 32 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {user_values_output[0][0]} {user_values_output[0][1]} {user_values_output[0][2]} {user_values_output[0][3]} {user_values_output[0][4]} {user_values_output[0][5]} {user_values_output[0][6]} {user_values_output[0][7]} {user_values_output[0][8]} {user_values_output[0][9]} {user_values_output[0][10]} {user_values_output[0][11]} {user_values_output[0][12]} {user_values_output[0][13]} {user_values_output[0][14]} {user_values_output[0][15]} {user_values_output[0][16]} {user_values_output[0][17]} {user_values_output[0][18]} {user_values_output[0][19]} {user_values_output[0][20]} {user_values_output[0][21]} {user_values_output[0][22]} {user_values_output[0][23]} {user_values_output[0][24]} {user_values_output[0][25]} {user_values_output[0][26]} {user_values_output[0][27]} {user_values_output[0][28]} {user_values_output[0][29]} {user_values_output[0][30]} {user_values_output[0][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 32 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {user_values_output[1][0]} {user_values_output[1][1]} {user_values_output[1][2]} {user_values_output[1][3]} {user_values_output[1][4]} {user_values_output[1][5]} {user_values_output[1][6]} {user_values_output[1][7]} {user_values_output[1][8]} {user_values_output[1][9]} {user_values_output[1][10]} {user_values_output[1][11]} {user_values_output[1][12]} {user_values_output[1][13]} {user_values_output[1][14]} {user_values_output[1][15]} {user_values_output[1][16]} {user_values_output[1][17]} {user_values_output[1][18]} {user_values_output[1][19]} {user_values_output[1][20]} {user_values_output[1][21]} {user_values_output[1][22]} {user_values_output[1][23]} {user_values_output[1][24]} {user_values_output[1][25]} {user_values_output[1][26]} {user_values_output[1][27]} {user_values_output[1][28]} {user_values_output[1][29]} {user_values_output[1][30]} {user_values_output[1][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list link_reset]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list reset]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {s_ttc_cmds_latch[bc0]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {s_ttc_cmds_latch[ec0]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {s_ttc_cmds_latch[l1a]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {s_ttc_cmds_latch[resync]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {s_ttc_cmds_latch[start]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list {s_ttc_cmds_latch[stop]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list {s_ttc_cmds_latch[test_sync]}]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets s_ttc_clk_120]
