-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
-- Date        : Thu Feb  7 10:38:39 2019
-- Host        : correlator2.fnal.gov running 64-bit Scientific Linux release 7.6 (Nitrogen)
-- Command     : write_vhdl -force -mode synth_stub
--               /home/rrivera/CorrelatorTrigger/TimingDistribution/TimingDistributionClient/ctp7-v7-base-fw/build/ctp7_top/ctp7_top_project.srcs/sources_1/ip/ttc_mmcm/ttc_mmcm_stub.vhdl
-- Design      : ttc_mmcm
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ttc_mmcm is
  Port ( 
    clk_ttc40_out : out STD_LOGIC;
    clk_ttc120_out : out STD_LOGIC;
    clk_ttc240_out : out STD_LOGIC;
    psclk : in STD_LOGIC;
    psen : in STD_LOGIC;
    psincdec : in STD_LOGIC;
    psdone : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1_p : in STD_LOGIC;
    clk_in1_n : in STD_LOGIC
  );

end ttc_mmcm;

architecture stub of ttc_mmcm is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_ttc40_out,clk_ttc120_out,clk_ttc240_out,psclk,psen,psincdec,psdone,reset,locked,clk_in1_p,clk_in1_n";
begin
end;
