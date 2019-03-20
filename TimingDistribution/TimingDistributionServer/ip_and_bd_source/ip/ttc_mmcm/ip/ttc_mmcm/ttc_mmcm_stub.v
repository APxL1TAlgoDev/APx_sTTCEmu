// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Thu Feb  7 10:38:39 2019
// Host        : correlator2.fnal.gov running 64-bit Scientific Linux release 7.6 (Nitrogen)
// Command     : write_verilog -force -mode synth_stub
//               /home/rrivera/CorrelatorTrigger/TimingDistribution/TimingDistributionClient/ctp7-v7-base-fw/build/ctp7_top/ctp7_top_project.srcs/sources_1/ip/ttc_mmcm/ttc_mmcm_stub.v
// Design      : ttc_mmcm
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module ttc_mmcm(clk_ttc40_out, clk_ttc120_out, 
  clk_ttc240_out, psclk, psen, psincdec, psdone, reset, locked, clk_in1_p, clk_in1_n)
/* synthesis syn_black_box black_box_pad_pin="clk_ttc40_out,clk_ttc120_out,clk_ttc240_out,psclk,psen,psincdec,psdone,reset,locked,clk_in1_p,clk_in1_n" */;
  output clk_ttc40_out;
  output clk_ttc120_out;
  output clk_ttc240_out;
  input psclk;
  input psen;
  input psincdec;
  output psdone;
  input reset;
  output locked;
  input clk_in1_p;
  input clk_in1_n;
endmodule
