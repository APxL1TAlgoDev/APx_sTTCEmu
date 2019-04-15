#---------------
set_property PACKAGE_PIN H29 [get_ports clk_200_diff_in_clk_n]

set_property IOSTANDARD LVDS [get_ports clk_200_diff_in_clk_p]
set_property IOSTANDARD LVDS [get_ports clk_200_diff_in_clk_n]

create_clock -period 5.000 -name clk_200_diff_in_clk_p [get_ports clk_200_diff_in_clk_p]

#---------------
#green LED (PCB)
set_property PACKAGE_PIN A20 [get_ports {LEDs[0]}]
#orange
set_property PACKAGE_PIN B20 [get_ports {LEDs[1]}]

set_property IOSTANDARD LVCMOS18 [get_ports {LEDs[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {LEDs[1]}]


set_property PACKAGE_PIN H19 [get_ports LED_GREEN_o]
set_property IOSTANDARD LVCMOS18 [get_ports LED_GREEN_o]

set_property PACKAGE_PIN D20 [get_ports LED_RED_o]
set_property IOSTANDARD LVCMOS18 [get_ports LED_RED_o]

set_property PACKAGE_PIN C20 [get_ports LED_BLUE_o]
set_property IOSTANDARD LVCMOS18 [get_ports LED_BLUE_o]

# ==========================================================================
# TTC data stream
set_property PACKAGE_PIN AV30 [get_ports clk_40_ttc_n_i]
set_property IOSTANDARD LVDS [get_ports clk_40_ttc_p_i]
set_property IOSTANDARD LVDS [get_ports clk_40_ttc_n_i]

set_property PACKAGE_PIN J26 [get_ports ttc_data_n_i]
set_property IOSTANDARD LVDS [get_ports ttc_data_p_i]
set_property IOSTANDARD LVDS [get_ports ttc_data_n_i]

## ~40.5 MHz (over-constrained)
create_clock -period 24.691 -name clk_40_ttc_p_i [get_ports clk_40_ttc_p_i]

# ==========================================================================

# ==========================================================================
# AXI Chip2Chip

set_property INTERNAL_VREF 0.9 [get_iobanks 16]

# AXI Chip2Chip - RX section
set_property PACKAGE_PIN BD31 [get_ports axi_c2c_v7_to_zynq_clk]
set_property PACKAGE_PIN AY32 [get_ports {axi_c2c_v7_to_zynq_data[0]}]
set_property PACKAGE_PIN BA33 [get_ports {axi_c2c_v7_to_zynq_data[1]}]
set_property PACKAGE_PIN AR31 [get_ports {axi_c2c_v7_to_zynq_data[2]}]
set_property PACKAGE_PIN AR32 [get_ports {axi_c2c_v7_to_zynq_data[3]}]
set_property PACKAGE_PIN AV32 [get_ports {axi_c2c_v7_to_zynq_data[4]}]
set_property PACKAGE_PIN AW32 [get_ports {axi_c2c_v7_to_zynq_data[5]}]
set_property PACKAGE_PIN AJ30 [get_ports {axi_c2c_v7_to_zynq_data[6]}]
set_property PACKAGE_PIN AJ31 [get_ports {axi_c2c_v7_to_zynq_data[7]}]
set_property PACKAGE_PIN AM32 [get_ports {axi_c2c_v7_to_zynq_data[8]}]
set_property PACKAGE_PIN AM33 [get_ports {axi_c2c_v7_to_zynq_data[9]}]
set_property PACKAGE_PIN BB33 [get_ports {axi_c2c_v7_to_zynq_data[10]}]
set_property PACKAGE_PIN AV33 [get_ports {axi_c2c_v7_to_zynq_data[11]}]
set_property PACKAGE_PIN AP32 [get_ports {axi_c2c_v7_to_zynq_data[12]}]
set_property PACKAGE_PIN AN32 [get_ports {axi_c2c_v7_to_zynq_data[13]}]
set_property PACKAGE_PIN BC34 [get_ports {axi_c2c_v7_to_zynq_data[14]}]
set_property PACKAGE_PIN AR33 [get_ports {axi_c2c_v7_to_zynq_data[15]}]
set_property PACKAGE_PIN AT33 [get_ports {axi_c2c_v7_to_zynq_data[16]}]

set_property IOSTANDARD HSTL_I_DCI_18 [get_ports axi_c2c_v7_to_zynq_clk]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[0]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[1]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[2]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[3]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[4]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[5]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[6]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[7]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[8]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[9]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[10]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[11]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[12]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[13]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[14]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[15]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_v7_to_zynq_data[16]}]

# AXI Chip2Chip - TX section
set_property PACKAGE_PIN AU33 [get_ports axi_c2c_zynq_to_v7_clk]
set_property PACKAGE_PIN AV34 [get_ports {axi_c2c_zynq_to_v7_data[0]}]
set_property PACKAGE_PIN AV35 [get_ports {axi_c2c_zynq_to_v7_data[1]}]
set_property PACKAGE_PIN AW34 [get_ports {axi_c2c_zynq_to_v7_data[2]}]
set_property PACKAGE_PIN AW35 [get_ports {axi_c2c_zynq_to_v7_data[3]}]
set_property PACKAGE_PIN AY33 [get_ports {axi_c2c_zynq_to_v7_data[4]}]
set_property PACKAGE_PIN AY34 [get_ports {axi_c2c_zynq_to_v7_data[5]}]
set_property PACKAGE_PIN BA34 [get_ports {axi_c2c_zynq_to_v7_data[6]}]
set_property PACKAGE_PIN BA35 [get_ports {axi_c2c_zynq_to_v7_data[7]}]
set_property PACKAGE_PIN BD34 [get_ports {axi_c2c_zynq_to_v7_data[8]}]
set_property PACKAGE_PIN BD35 [get_ports {axi_c2c_zynq_to_v7_data[9]}]
set_property PACKAGE_PIN BB35 [get_ports {axi_c2c_zynq_to_v7_data[10]}]
set_property PACKAGE_PIN BC35 [get_ports {axi_c2c_zynq_to_v7_data[11]}]
set_property PACKAGE_PIN BC32 [get_ports {axi_c2c_zynq_to_v7_data[12]}]
set_property PACKAGE_PIN BC33 [get_ports {axi_c2c_zynq_to_v7_data[13]}]
set_property PACKAGE_PIN BD32 [get_ports {axi_c2c_zynq_to_v7_data[14]}]
set_property PACKAGE_PIN AJ32 [get_ports {axi_c2c_zynq_to_v7_data[15]}]
set_property PACKAGE_PIN AK32 [get_ports {axi_c2c_zynq_to_v7_data[16]}]

set_property IOSTANDARD HSTL_I_DCI_18 [get_ports axi_c2c_zynq_to_v7_clk]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[0]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[1]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[2]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[3]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[4]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[5]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[6]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[7]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[8]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[9]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[10]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[11]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[12]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[13]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[14]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[15]}]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports {axi_c2c_zynq_to_v7_data[16]}]

# AXI Chip2Chip - Status/Control section
set_property PACKAGE_PIN BB31 [get_ports axi_c2c_zynq_to_v7_reset]
set_property PACKAGE_PIN BB32 [get_ports axi_c2c_v7_to_zynq_link_status]

set_property IOSTANDARD HSTL_I_DCI_18 [get_ports axi_c2c_zynq_to_v7_reset]
set_property IOSTANDARD HSTL_I_DCI_18 [get_ports axi_c2c_v7_to_zynq_link_status]
# ==========================================================================

set_property LOC XADC_X0Y0 [get_cells i_v7_bd/xadc_wiz_0/U0/AXI_XADC_CORE_I/XADC_INST]

set_false_path -from [get_clocks -of_objects [get_pins U_ttc_core/i_ctp7_ttc_clocks/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins i_v7_bd/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT2]]
set_false_path -from [get_clocks -of_objects [get_pins U_ttc_core/i_ctp7_ttc_clocks/inst/mmcm_adv_inst/CLKOUT2]] -to [get_clocks -of_objects [get_pins i_v7_bd/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT2]]
set_false_path -from [get_clocks -of_objects [get_pins i_v7_bd/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT2]] -to [get_clocks -of_objects [get_pins U_ttc_core/i_ctp7_ttc_clocks/inst/mmcm_adv_inst/CLKOUT0]]
set_false_path -from [get_clocks -of_objects [get_pins i_v7_bd/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT2]] -to [get_clocks -of_objects [get_pins U_ttc_core/i_ctp7_ttc_clocks/inst/mmcm_adv_inst/CLKOUT2]]


# ==========================================================================
# ==========================================================================
# from GEM project:

####################### GT reference clock constraints #########################

create_clock -period 6.250 [get_ports {refclk_F_0_p_i[0]}]
create_clock -period 6.250 [get_ports {refclk_F_0_p_i[1]}]
create_clock -period 6.250 [get_ports {refclk_F_0_p_i[2]}]
create_clock -period 6.250 [get_ports {refclk_F_0_p_i[3]}]

create_clock -period 6.250 [get_ports {refclk_F_1_p_i[0]}]
create_clock -period 6.250 [get_ports {refclk_F_1_p_i[1]}]
create_clock -period 6.250 [get_ports {refclk_F_1_p_i[2]}]
create_clock -period 6.250 [get_ports {refclk_F_1_p_i[3]}]

#create_clock -period 6.250 [get_ports {refclk_B_0_p_i[0]}]
create_clock -period 6.250 [get_ports {refclk_B_0_p_i[1]}]
create_clock -period 6.250 [get_ports {refclk_B_0_p_i[2]}]
create_clock -period 6.250 [get_ports {refclk_B_0_p_i[3]}]

#create_clock -period 6.250 [get_ports {refclk_B_1_p_i[0]}]
create_clock -period 6.250 [get_ports {refclk_B_1_p_i[1]}]
create_clock -period 6.250 [get_ports {refclk_B_1_p_i[2]}]
create_clock -period 6.250 [get_ports {refclk_B_1_p_i[3]}]

################################ RefClk Location constraints #####################

set_property PACKAGE_PIN E10 [get_ports {refclk_F_0_p_i[0]}]
set_property PACKAGE_PIN N10 [get_ports {refclk_F_0_p_i[1]}]
set_property PACKAGE_PIN AF8 [get_ports {refclk_F_0_p_i[2]}]
set_property PACKAGE_PIN AR10 [get_ports {refclk_F_0_p_i[3]}]

set_property PACKAGE_PIN G10 [get_ports {refclk_F_1_p_i[0]}]
set_property PACKAGE_PIN R10 [get_ports {refclk_F_1_p_i[1]}]
set_property PACKAGE_PIN AH8 [get_ports {refclk_F_1_p_i[2]}]
set_property PACKAGE_PIN AT8 [get_ports {refclk_F_1_p_i[3]}]

#set_property PACKAGE_PIN AR35 [get_ports  {refclk_B_0_p_i[0]}]
set_property PACKAGE_PIN AF37 [get_ports {refclk_B_0_p_i[1]}]
set_property PACKAGE_PIN N35 [get_ports {refclk_B_0_p_i[2]}]
set_property PACKAGE_PIN E35 [get_ports {refclk_B_0_p_i[3]}]

#set_property PACKAGE_PIN AT37 [get_ports  {refclk_B_1_p_i[0]}]
set_property PACKAGE_PIN AH37 [get_ports {refclk_B_1_p_i[1]}]
set_property PACKAGE_PIN R35 [get_ports {refclk_B_1_p_i[2]}]
set_property PACKAGE_PIN G35 [get_ports {refclk_B_1_p_i[3]}]

################################ GTH2_CHANNEL Location constraints  #####################

set_property LOC GTHE2_CHANNEL_X1Y0 [get_cells {*/gen_gth_single[0].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y1 [get_cells {*/gen_gth_single[1].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y2 [get_cells {*/gen_gth_single[2].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y3 [get_cells {*/gen_gth_single[3].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y4 [get_cells {*/gen_gth_single[4].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y5 [get_cells {*/gen_gth_single[5].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y6 [get_cells {*/gen_gth_single[6].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y7 [get_cells {*/gen_gth_single[7].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y8 [get_cells {*/gen_gth_single[8].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y9 [get_cells {*/gen_gth_single[9].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y10 [get_cells {*/gen_gth_single[10].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y11 [get_cells {*/gen_gth_single[11].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y12 [get_cells {*/gen_gth_single[12].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y13 [get_cells {*/gen_gth_single[13].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y14 [get_cells {*/gen_gth_single[14].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y15 [get_cells {*/gen_gth_single[15].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y16 [get_cells {*/gen_gth_single[16].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y17 [get_cells {*/gen_gth_single[17].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y18 [get_cells {*/gen_gth_single[18].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y19 [get_cells {*/gen_gth_single[19].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y20 [get_cells {*/gen_gth_single[20].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y21 [get_cells {*/gen_gth_single[21].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y22 [get_cells {*/gen_gth_single[22].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y23 [get_cells {*/gen_gth_single[23].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y24 [get_cells {*/gen_gth_single[24].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y25 [get_cells {*/gen_gth_single[25].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y26 [get_cells {*/gen_gth_single[26].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y27 [get_cells {*/gen_gth_single[27].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y28 [get_cells {*/gen_gth_single[28].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y29 [get_cells {*/gen_gth_single[29].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y30 [get_cells {*/gen_gth_single[30].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y31 [get_cells {*/gen_gth_single[31].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y32 [get_cells {*/gen_gth_single[32].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y33 [get_cells {*/gen_gth_single[33].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y34 [get_cells {*/gen_gth_single[34].gen_gth_*/i_gthe2}]
set_property LOC GTHE2_CHANNEL_X1Y35 [get_cells {*/gen_gth_single[35].gen_gth_*/i_gthe2}]



set_false_path -to [get_cells -hierarchical -filter {NAME =~ *sync*/data_sync_reg1}]
set_false_path -to [get_cells -hierarchical -filter {NAME =~ *sync*/data_sync_reg1}]
set_false_path -to [get_cells -hierarchical -filter {NAME =~ *sync*/data_sync_reg1}]
set_false_path -to [get_cells -hierarchical -filter {NAME =~ *sync*/data_sync_reg1}]


#mainly for GBT
set_clock_groups -asynchronous -group [get_clocks {*/gen_gth_single[*].gen_gth_3p2g*/i_gthe2*TXOUTCLK}] -group [get_clocks {*/gen_gth_single[*].gen_gth_4p8g*/i_gthe2*TXOUTCLK}]
set_clock_groups -asynchronous -group [get_clocks {*/gen_gth_single[*].gen_gth_3p2g*/i_gthe2*RXOUTCLK}] -group [get_clocks {*/gen_gth_single[*].gen_gth_4p8g*/i_gthe2*RXOUTCLK}]
set_clock_groups -asynchronous -group [get_clocks {*/gen_gth_single[*].*/i_gthe2*RXOUTCLK}] -group [get_clocks {*/gen_gth_single[*].*/i_gthe2*TXOUTCLK}]

set_max_delay 16 -from [get_pins -hier -filter {NAME =~ */*/*/scrambler/*/C}] -to [get_pins -hier -filter {NAME =~ */*/*/txGearbox/*/D}] -datapath_only
set_max_delay 16 -from [get_pins -hier -filter {NAME =~ */*/*gbtTx_gen[*].gbtTx/txPhaseMon/DONE*/C}] -to [get_pins -hier -filter {NAME =~ */*/*gbtTx_gen[*].i_sync_gearbox_align*FDE_INST/D}] -datapath_only
set_max_delay 16 -from [get_pins -hier -filter {NAME =~ */*/*gbtTx_gen[*].gbtTx/txPhaseMon/GOOD*/C}] -to [get_pins -hier -filter {NAME =~ */*/*gbtTx_gen[*].i_sync_gearbox_align*FDE_INST/D}] -datapath_only


############# Channel [0] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[0].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[0].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [1] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[1].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[1].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [2] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[2].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[2].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [3] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[3].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[3].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [4] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[4].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[4].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [5] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[5].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[5].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [6] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[6].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[6].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [7] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[7].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[7].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [8] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[8].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[8].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [9] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[9].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[9].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [10] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[10].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[10].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [11] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[11].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[11].gen_gth_*/i_gthe2*RXOUTCLK}]



############# Channel [12] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[12].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[12].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [13] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[13].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[13].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [14] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[14].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[14].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [15] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[15].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[15].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [16] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[16].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[16].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [17] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[17].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[17].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [18] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[18].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[18].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [19] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[19].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[19].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [20] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[20].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[20].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [21] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[21].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[21].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [22] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[22].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[22].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [23] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[23].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[23].gen_gth_*/i_gthe2*RXOUTCLK}]



# for GBT links on CXP2:
############# Channel [24] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[24].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[24].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [25] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[25].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[25].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [26] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[26].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[26].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [27] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[27].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[27].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [28] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[28].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[28].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [29] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[29].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[29].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [30] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[30].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[30].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [31] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[31].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[31].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [32] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[32].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[32].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [33] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[33].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[33].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [34] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[34].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[34].gen_gth_*/i_gthe2*RXOUTCLK}]

############# Channel [35] - 4.8 Gbps TX, 4.8 Gbps RX #############
create_clock -period 6.250 [get_pins -hier -filter {name=~*/gen_gth_single[35].gen_gth_*/i_gthe2*TXOUTCLK}]
create_clock -period 8.333 [get_pins -hier -filter {name=~*/gen_gth_single[35].gen_gth_*/i_gthe2*RXOUTCLK}]







connect_debug_port dbg_hub/clk [get_nets u_ila_0_clk_ttc120_out]



connect_debug_port u_ila_0/probe15 [get_nets [list {user_values_output[0]} {user_values_output[1]} {user_values_output[2]} {user_values_output[3]} {user_values_output[4]} {user_values_output[5]} {user_values_output[6]} {user_values_output[7]} {user_values_output[8]} {user_values_output[9]} {user_values_output[10]} {user_values_output[11]} {user_values_output[12]} {user_values_output[13]} {user_values_output[14]} {user_values_output[15]} {user_values_output[16]} {user_values_output[17]} {user_values_output[18]} {user_values_output[19]} {user_values_output[20]} {user_values_output[21]} {user_values_output[22]} {user_values_output[23]} {user_values_output[24]} {user_values_output[25]} {user_values_output[26]} {user_values_output[27]} {user_values_output[28]} {user_values_output[29]} {user_values_output[30]} {user_values_output[31]} {user_values_output[32]} {user_values_output[33]} {user_values_output[34]} {user_values_output[35]} {user_values_output[36]} {user_values_output[37]} {user_values_output[38]} {user_values_output[39]} {user_values_output[40]} {user_values_output[41]} {user_values_output[42]} {user_values_output[43]} {user_values_output[44]} {user_values_output[45]} {user_values_output[46]} {user_values_output[47]} {user_values_output[48]} {user_values_output[49]} {user_values_output[50]} {user_values_output[51]} {user_values_output[52]} {user_values_output[53]} {user_values_output[54]} {user_values_output[55]} {user_values_output[56]} {user_values_output[57]} {user_values_output[58]} {user_values_output[59]} {user_values_output[60]} {user_values_output[61]} {user_values_output[62]} {user_values_output[63]}]]

connect_debug_port u_ila_0/probe0 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_tx_status_arr_o[1][txbufstatus][0]} {GEM_style_source_links[0].i_gth_wrapper/gth_tx_status_arr_o[1][txbufstatus][1]}]]
connect_debug_port u_ila_0/probe10 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_tx_status_arr_o[0][txbufstatus][0]} {GEM_style_source_links[0].i_gth_wrapper/gth_tx_status_arr_o[0][txbufstatus][1]}]]
connect_debug_port u_ila_0/probe11 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_gt_rxreset_done_o[0]} {GEM_style_source_links[0].i_gth_wrapper/gth_gt_rxreset_done_o[1]}]]
connect_debug_port u_ila_0/probe12 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_gt_txreset_done_o[0]} {GEM_style_source_links[0].i_gth_wrapper/gth_gt_txreset_done_o[1]}]]
connect_debug_port u_ila_0/probe13 [get_nets [list {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[0]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[1]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[2]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[3]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[4]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[5]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[6]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[7]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[8]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[9]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[10]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[11]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[12]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[13]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[14]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[15]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[16]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[17]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[18]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[19]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[20]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[21]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[22]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[23]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[24]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[25]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[26]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[27]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[28]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[29]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[30]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[31]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[32]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[33]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[34]} {GEM_style_source_links[0].i_gbt/rx_data_valid_arr_o[35]}]]
connect_debug_port u_ila_0/probe14 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[1][rxclkcorcnt][0]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[1][rxclkcorcnt][1]}]]
connect_debug_port u_ila_0/probe15 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[1][rxdisperr][0]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[1][rxdisperr][1]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[1][rxdisperr][2]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[1][rxdisperr][3]}]]
connect_debug_port u_ila_0/probe16 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[0][rxnotintable][0]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[0][rxnotintable][1]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[0][rxnotintable][2]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[0][rxnotintable][3]}]]
connect_debug_port u_ila_0/probe17 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[0][rxdisperr][0]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[0][rxdisperr][1]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[0][rxdisperr][2]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[0][rxdisperr][3]}]]
connect_debug_port u_ila_0/probe18 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[0][rxclkcorcnt][0]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[0][rxclkcorcnt][1]}]]
connect_debug_port u_ila_0/probe19 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[0][rxbufstatus][0]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[0][rxbufstatus][1]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[0][rxbufstatus][2]}]]
connect_debug_port u_ila_0/probe20 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[1][rxbufstatus][0]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[1][rxbufstatus][1]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[1][rxbufstatus][2]}]]
connect_debug_port u_ila_0/probe21 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[1][rxnotintable][0]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[1][rxnotintable][1]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[1][rxnotintable][2]} {GEM_style_source_links[0].i_gth_wrapper/gth_rx_status_arr_o[1][rxnotintable][3]}]]
connect_debug_port u_ila_0/probe22 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_cpll_status_arr_o[0][cpllfbclklost]}]]
connect_debug_port u_ila_0/probe23 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_cpll_status_arr_o[0][cplllock]}]]
connect_debug_port u_ila_0/probe24 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_cpll_status_arr_o[0][cpllrefclklost]}]]
connect_debug_port u_ila_0/probe25 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_cpll_status_arr_o[1][cpllfbclklost]}]]
connect_debug_port u_ila_0/probe26 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_cpll_status_arr_o[1][cplllock]}]]
connect_debug_port u_ila_0/probe27 [get_nets [list {GEM_style_source_links[0].i_gth_wrapper/gth_cpll_status_arr_o[1][cpllrefclklost]}]]
connect_debug_port u_ila_0/probe29 [get_nets [list {GEM_style_source_links[0].i_gbt/link_status_arr_o[0][gbt_rx_had_not_ready]}]]
connect_debug_port u_ila_0/probe30 [get_nets [list {GEM_style_source_links[0].i_gbt/link_status_arr_o[0][gbt_rx_ready]}]]
connect_debug_port u_ila_0/probe31 [get_nets [list {GEM_style_source_links[0].i_gbt/link_status_arr_o[0][gbt_rx_sync_status][had_ovf]}]]
connect_debug_port u_ila_0/probe32 [get_nets [list {GEM_style_source_links[0].i_gbt/link_status_arr_o[0][gbt_rx_sync_status][had_unf]}]]
connect_debug_port u_ila_0/probe33 [get_nets [list {GEM_style_source_links[0].i_gbt/link_status_arr_o[1][gbt_rx_had_not_ready]}]]
connect_debug_port u_ila_0/probe34 [get_nets [list {GEM_style_source_links[0].i_gbt/link_status_arr_o[1][gbt_rx_ready]}]]
connect_debug_port u_ila_0/probe35 [get_nets [list {GEM_style_source_links[0].i_gbt/link_status_arr_o[1][gbt_rx_sync_status][had_ovf]}]]
connect_debug_port u_ila_0/probe36 [get_nets [list {GEM_style_source_links[0].i_gbt/link_status_arr_o[1][gbt_rx_sync_status][had_unf]}]]

