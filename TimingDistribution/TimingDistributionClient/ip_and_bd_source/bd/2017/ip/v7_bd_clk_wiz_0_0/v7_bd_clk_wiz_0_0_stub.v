// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Tue Nov 27 12:38:01 2018
// Host        : correlator2.fnal.gov running 64-bit Scientific Linux release 7.5 (Nitrogen)
// Command     : write_verilog -force -mode synth_stub -rename_top v7_bd_clk_wiz_0_0 -prefix
//               v7_bd_clk_wiz_0_0_ v7_bd_clk_wiz_0_0_stub.v
// Design      : v7_bd_clk_wiz_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module v7_bd_clk_wiz_0_0(clk_out1, clk_out2, clk_out3, locked, clk_in1_p, 
  clk_in1_n)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,clk_out2,clk_out3,locked,clk_in1_p,clk_in1_n" */;
  output clk_out1;
  output clk_out2;
  output clk_out3;
  output locked;
  input clk_in1_p;
  input clk_in1_n;
endmodule
