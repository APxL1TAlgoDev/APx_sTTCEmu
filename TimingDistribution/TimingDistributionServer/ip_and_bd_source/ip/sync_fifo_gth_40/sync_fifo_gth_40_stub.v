// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Tue Mar 19 21:27:51 2019
// Host        : correlator2.fnal.gov running 64-bit Scientific Linux release 7.6 (Nitrogen)
// Command     : write_verilog -force -mode synth_stub
//               /home/rrivera/CorrelatorTrigger/APx_sTTCEmu/TimingDistribution/TimingDistributionClient/ctp7-v7-base-fw/build/ctp7_top/ctp7_top_project.srcs/sources_1/ip/sync_fifo_gth_40/sync_fifo_gth_40_stub.v
// Design      : sync_fifo_gth_40
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_2,Vivado 2018.2" *)
module sync_fifo_gth_40(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, 
  overflow, empty, valid, underflow)
/* synthesis syn_black_box black_box_pad_pin="rst,wr_clk,rd_clk,din[39:0],wr_en,rd_en,dout[39:0],full,overflow,empty,valid,underflow" */;
  input rst;
  input wr_clk;
  input rd_clk;
  input [39:0]din;
  input wr_en;
  input rd_en;
  output [39:0]dout;
  output full;
  output overflow;
  output empty;
  output valid;
  output underflow;
endmodule
