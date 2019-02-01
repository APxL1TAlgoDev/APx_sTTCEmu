-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
-- Date        : Mon Nov 12 14:38:36 2018
-- Host        : correlator2.fnal.gov running 64-bit Scientific Linux release 7.5 (Nitrogen)
-- Command     : write_vhdl -force -mode synth_stub
--               /home/rrivera/CorrelatorTrigger/TimingDistribution/GEM_AMC-3/ctp7/work_dir/gem_amc.runs/sync_fifo_gth_40_synth_1/sync_fifo_gth_40_stub.vhdl
-- Design      : sync_fifo_gth_40
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sync_fifo_gth_40 is
  Port ( 
    rst : in STD_LOGIC;
    wr_clk : in STD_LOGIC;
    rd_clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 39 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 39 downto 0 );
    full : out STD_LOGIC;
    overflow : out STD_LOGIC;
    empty : out STD_LOGIC;
    valid : out STD_LOGIC;
    underflow : out STD_LOGIC
  );

end sync_fifo_gth_40;

architecture stub of sync_fifo_gth_40 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "rst,wr_clk,rd_clk,din[39:0],wr_en,rd_en,dout[39:0],full,overflow,empty,valid,underflow";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fifo_generator_v13_2_2,Vivado 2018.2";
begin
end;
