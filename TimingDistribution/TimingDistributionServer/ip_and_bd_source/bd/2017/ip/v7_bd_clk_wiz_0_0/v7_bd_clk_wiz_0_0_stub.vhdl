-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
-- Date        : Tue Nov 27 12:38:01 2018
-- Host        : correlator2.fnal.gov running 64-bit Scientific Linux release 7.5 (Nitrogen)
-- Command     : write_vhdl -force -mode synth_stub -rename_top v7_bd_clk_wiz_0_0 -prefix
--               v7_bd_clk_wiz_0_0_ v7_bd_clk_wiz_0_0_stub.vhdl
-- Design      : v7_bd_clk_wiz_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity v7_bd_clk_wiz_0_0 is
  Port ( 
    clk_out1 : out STD_LOGIC;
    clk_out2 : out STD_LOGIC;
    clk_out3 : out STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1_p : in STD_LOGIC;
    clk_in1_n : in STD_LOGIC
  );

end v7_bd_clk_wiz_0_0;

architecture stub of v7_bd_clk_wiz_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out1,clk_out2,clk_out3,locked,clk_in1_p,clk_in1_n";
begin
end;
