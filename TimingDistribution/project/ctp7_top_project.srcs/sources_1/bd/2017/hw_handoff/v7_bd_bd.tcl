
################################################################
# This is a generated script based on design: v7_bd
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2018.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source v7_bd_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7vx690tffg1927-2
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name v7_bd

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set M_AXI [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.HAS_BURST {0} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.PROTOCOL {AXI4LITE} \
   ] $M_AXI
  set clk_200_diff_in [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 clk_200_diff_in ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {200000000} \
   ] $clk_200_diff_in

  # Create ports
  set M_AXI_clk [ create_bd_port -dir O -type clk M_AXI_clk ]
  set M_AXI_rst_n [ create_bd_port -dir O -from 0 -to 0 -type rst M_AXI_rst_n ]
  set axi_c2c_v7_to_zynq_clk [ create_bd_port -dir O -type clk axi_c2c_v7_to_zynq_clk ]
  set axi_c2c_v7_to_zynq_data [ create_bd_port -dir O -from 16 -to 0 axi_c2c_v7_to_zynq_data ]
  set axi_c2c_v7_to_zynq_link_status [ create_bd_port -dir O axi_c2c_v7_to_zynq_link_status ]
  set axi_c2c_zynq_to_v7_clk [ create_bd_port -dir I -type clk axi_c2c_zynq_to_v7_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {250000000} \
 ] $axi_c2c_zynq_to_v7_clk
  set axi_c2c_zynq_to_v7_data [ create_bd_port -dir I -from 16 -to 0 axi_c2c_zynq_to_v7_data ]
  set axi_c2c_zynq_to_v7_reset [ create_bd_port -dir I -type rst axi_c2c_zynq_to_v7_reset ]
  set clk_100mhz [ create_bd_port -dir O -type clk clk_100mhz ]
  set clk_200mhz [ create_bd_port -dir O -type clk clk_200mhz ]
  set clk_50mhz [ create_bd_port -dir O -type clk clk_50mhz ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {M_AXI} \
 ] $clk_50mhz

  # Create instance: axi_chip2chip_0, and set properties
  set axi_chip2chip_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_chip2chip:5.0 axi_chip2chip_0 ]
  set_property -dict [ list \
   CONFIG.C_AURORA_WIDTH {64} \
   CONFIG.C_AXI_ADDR_WIDTH {32} \
   CONFIG.C_COMMON_CLK {0} \
   CONFIG.C_INCLUDE_AXILITE {2} \
   CONFIG.C_INTERFACE_MODE {1} \
   CONFIG.C_MASTER_FPGA {0} \
   CONFIG.C_M_AXI_ID_WIDTH {8} \
   CONFIG.C_M_AXI_WUSER_WIDTH {0} \
 ] $axi_chip2chip_0

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ENABLE_ADVANCED_OPTIONS {1} \
   CONFIG.M00_HAS_REGSLICE {0} \
   CONFIG.M01_HAS_REGSLICE {0} \
   CONFIG.M02_HAS_REGSLICE {0} \
   CONFIG.M03_HAS_REGSLICE {4} \
   CONFIG.M04_HAS_REGSLICE {4} \
   CONFIG.M05_HAS_REGSLICE {4} \
   CONFIG.M06_HAS_REGSLICE {4} \
   CONFIG.M07_HAS_REGSLICE {4} \
   CONFIG.M08_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {2} \
   CONFIG.S00_HAS_DATA_FIFO {0} \
   CONFIG.S00_HAS_REGSLICE {0} \
 ] $axi_interconnect_0

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.AXI_DRP {false} \
   CONFIG.CLKIN1_JITTER_PS {50.0} \
   CONFIG.CLKOUT1_DRIVES {BUFGCE} \
   CONFIG.CLKOUT1_JITTER {98.146} \
   CONFIG.CLKOUT1_PHASE_ERROR {89.971} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200} \
   CONFIG.CLKOUT2_DRIVES {BUFGCE} \
   CONFIG.CLKOUT2_JITTER {112.316} \
   CONFIG.CLKOUT2_PHASE_ERROR {89.971} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {100} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.CLKOUT3_DRIVES {BUFGCE} \
   CONFIG.CLKOUT3_JITTER {129.198} \
   CONFIG.CLKOUT3_PHASE_ERROR {89.971} \
   CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {50} \
   CONFIG.CLKOUT3_USED {true} \
   CONFIG.CLKOUT4_JITTER {89.608} \
   CONFIG.CLKOUT4_PHASE_ERROR {82.655} \
   CONFIG.CLKOUT4_REQUESTED_OUT_FREQ {100.000} \
   CONFIG.CLKOUT4_USED {false} \
   CONFIG.CLKOUT5_JITTER {127.032} \
   CONFIG.CLKOUT5_PHASE_ERROR {82.655} \
   CONFIG.CLKOUT5_USED {false} \
   CONFIG.ENABLE_CLOCK_MONITOR {false} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {5.000} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {5.000} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {10} \
   CONFIG.MMCM_CLKOUT2_DIVIDE {20} \
   CONFIG.MMCM_CLKOUT3_DIVIDE {1} \
   CONFIG.MMCM_DIVCLK_DIVIDE {1} \
   CONFIG.NUM_OUT_CLKS {3} \
   CONFIG.PHASE_DUTY_CONFIG {false} \
   CONFIG.PRIMITIVE {MMCM} \
   CONFIG.PRIM_IN_FREQ {200} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
   CONFIG.USE_DYN_RECONFIG {false} \
   CONFIG.USE_PHASE_ALIGNMENT {false} \
   CONFIG.USE_RESET {false} \
   CONFIG.USE_SAFE_CLOCK_STARTUP {true} \
 ] $clk_wiz_0

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]
  set_property -dict [ list \
   CONFIG.C_AUX_RESET_HIGH {0} \
 ] $proc_sys_reset_0

  # Create instance: xadc_wiz_0, and set properties
  set xadc_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0 ]
  set_property -dict [ list \
   CONFIG.ADC_CONVERSION_RATE {962} \
   CONFIG.CHANNEL_AVERAGING {64} \
   CONFIG.DCLK_FREQUENCY {50} \
   CONFIG.ENABLE_TEMP_BUS {false} \
   CONFIG.INTERFACE_SELECTION {Enable_AXI} \
   CONFIG.OT_ALARM {false} \
   CONFIG.USER_TEMP_ALARM {false} \
   CONFIG.VCCAUX_ALARM {false} \
   CONFIG.VCCINT_ALARM {false} \
 ] $xadc_wiz_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_chip2chip_0_m_axi [get_bd_intf_pins axi_chip2chip_0/m_axi] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axi_chip2chip_0_m_axi_lite [get_bd_intf_pins axi_chip2chip_0/m_axi_lite] [get_bd_intf_pins axi_interconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins xadc_wiz_0/s_axi_lite]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_ports M_AXI] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net clk_200_diff_in_1 [get_bd_intf_ports clk_200_diff_in] [get_bd_intf_pins clk_wiz_0/CLK_IN1_D]

  # Create port connections
  connect_bd_net -net ARESETN_1 [get_bd_pins axi_chip2chip_0/m_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins proc_sys_reset_0/interconnect_aresetn]
  connect_bd_net -net axi_c2c_zynq_to_v7_clk_1 [get_bd_ports axi_c2c_zynq_to_v7_clk] [get_bd_pins axi_chip2chip_0/axi_c2c_selio_rx_clk_in]
  connect_bd_net -net axi_c2c_zynq_to_v7_data_1 [get_bd_ports axi_c2c_zynq_to_v7_data] [get_bd_pins axi_chip2chip_0/axi_c2c_selio_rx_data_in]
  connect_bd_net -net axi_chip2chip_0_axi_c2c_link_status_out [get_bd_ports axi_c2c_v7_to_zynq_link_status] [get_bd_pins axi_chip2chip_0/axi_c2c_link_status_out]
  connect_bd_net -net axi_chip2chip_0_axi_c2c_selio_tx_clk_out [get_bd_ports axi_c2c_v7_to_zynq_clk] [get_bd_pins axi_chip2chip_0/axi_c2c_selio_tx_clk_out]
  connect_bd_net -net axi_chip2chip_0_axi_c2c_selio_tx_data_out [get_bd_ports axi_c2c_v7_to_zynq_data] [get_bd_pins axi_chip2chip_0/axi_c2c_selio_tx_data_out]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_ports clk_200mhz] [get_bd_pins axi_chip2chip_0/idelay_ref_clk] [get_bd_pins clk_wiz_0/clk_out1]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_ports clk_100mhz] [get_bd_pins clk_wiz_0/clk_out2]
  connect_bd_net -net clk_wiz_0_clk_out3 [get_bd_ports M_AXI_clk] [get_bd_ports clk_50mhz] [get_bd_pins axi_chip2chip_0/m_aclk] [get_bd_pins axi_chip2chip_0/m_axi_lite_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins clk_wiz_0/clk_out3] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins xadc_wiz_0/s_axi_aclk]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_0/dcm_locked]
  connect_bd_net -net m_aresetn_1 [get_bd_ports axi_c2c_zynq_to_v7_reset] [get_bd_pins proc_sys_reset_0/ext_reset_in]
  connect_bd_net -net vio_0_probe_out0 [get_bd_ports M_AXI_rst_n] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins xadc_wiz_0/s_axi_aresetn]

  # Create address segments
  create_bd_addr_seg -range 0x08000000 -offset 0x60000000 [get_bd_addr_spaces axi_chip2chip_0/MAXI-Lite] [get_bd_addr_segs M_AXI/Reg] SEG_M_AXI_Reg
  create_bd_addr_seg -range 0x08000000 -offset 0x60000000 [get_bd_addr_spaces axi_chip2chip_0/MAXI] [get_bd_addr_segs M_AXI/Reg] SEG_M_AXI_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x68000000 [get_bd_addr_spaces axi_chip2chip_0/MAXI-Lite] [get_bd_addr_segs xadc_wiz_0/s_axi_lite/Reg] SEG_xadc_wiz_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x68000000 [get_bd_addr_spaces axi_chip2chip_0/MAXI] [get_bd_addr_segs xadc_wiz_0/s_axi_lite/Reg] SEG_xadc_wiz_0_Reg


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


