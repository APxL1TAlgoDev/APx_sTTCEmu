-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
-- Date        : Tue Mar 19 21:35:17 2019
-- Host        : correlator2.fnal.gov running 64-bit Scientific Linux release 7.6 (Nitrogen)
-- Command     : write_vhdl -force -mode synth_stub
--               /home/rrivera/CorrelatorTrigger/APx_sTTCEmu/TimingDistribution/TimingDistributionClient/ctp7-v7-base-fw/build/ctp7_top/ctp7_top_project.srcs/sources_1/ip/xlx_k7v7_rx_dpram/xlx_k7v7_rx_dpram_stub.vhdl
-- Design      : xlx_k7v7_rx_dpram
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xlx_k7v7_rx_dpram is
  Port ( 
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 4 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 39 downto 0 );
    clkb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 2 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 159 downto 0 )
  );

end xlx_k7v7_rx_dpram;

architecture stub of xlx_k7v7_rx_dpram is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,wea[0:0],addra[4:0],dina[39:0],clkb,addrb[2:0],doutb[159:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_1,Vivado 2018.2";
begin
end;
