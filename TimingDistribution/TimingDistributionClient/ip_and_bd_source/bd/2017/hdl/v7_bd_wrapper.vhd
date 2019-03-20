--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
--Date        : Tue Nov 27 12:34:48 2018
--Host        : correlator2.fnal.gov running 64-bit Scientific Linux release 7.5 (Nitrogen)
--Command     : generate_target v7_bd_wrapper.bd
--Design      : v7_bd_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity v7_bd_wrapper is
  port (
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_clk : out STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rst_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    axi_c2c_v7_to_zynq_clk : out STD_LOGIC;
    axi_c2c_v7_to_zynq_data : out STD_LOGIC_VECTOR ( 16 downto 0 );
    axi_c2c_v7_to_zynq_link_status : out STD_LOGIC;
    axi_c2c_zynq_to_v7_clk : in STD_LOGIC;
    axi_c2c_zynq_to_v7_data : in STD_LOGIC_VECTOR ( 16 downto 0 );
    axi_c2c_zynq_to_v7_reset : in STD_LOGIC;
    clk_100mhz : out STD_LOGIC;
    clk_200_diff_in_clk_n : in STD_LOGIC;
    clk_200_diff_in_clk_p : in STD_LOGIC;
    clk_200mhz : out STD_LOGIC;
    clk_50mhz : out STD_LOGIC
  );
end v7_bd_wrapper;

architecture STRUCTURE of v7_bd_wrapper is
  component v7_bd is
  port (
    clk_200_diff_in_clk_n : in STD_LOGIC;
    clk_200_diff_in_clk_p : in STD_LOGIC;
    axi_c2c_zynq_to_v7_clk : in STD_LOGIC;
    axi_c2c_zynq_to_v7_data : in STD_LOGIC_VECTOR ( 16 downto 0 );
    axi_c2c_v7_to_zynq_link_status : out STD_LOGIC;
    axi_c2c_v7_to_zynq_clk : out STD_LOGIC;
    axi_c2c_v7_to_zynq_data : out STD_LOGIC_VECTOR ( 16 downto 0 );
    clk_200mhz : out STD_LOGIC;
    M_AXI_clk : out STD_LOGIC;
    clk_50mhz : out STD_LOGIC;
    axi_c2c_zynq_to_v7_reset : in STD_LOGIC;
    M_AXI_rst_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    clk_100mhz : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component v7_bd;
begin
v7_bd_i: component v7_bd
     port map (
      M_AXI_araddr(31 downto 0) => M_AXI_araddr(31 downto 0),
      M_AXI_arprot(2 downto 0) => M_AXI_arprot(2 downto 0),
      M_AXI_arready(0) => M_AXI_arready(0),
      M_AXI_arvalid(0) => M_AXI_arvalid(0),
      M_AXI_awaddr(31 downto 0) => M_AXI_awaddr(31 downto 0),
      M_AXI_awprot(2 downto 0) => M_AXI_awprot(2 downto 0),
      M_AXI_awready(0) => M_AXI_awready(0),
      M_AXI_awvalid(0) => M_AXI_awvalid(0),
      M_AXI_bready(0) => M_AXI_bready(0),
      M_AXI_bresp(1 downto 0) => M_AXI_bresp(1 downto 0),
      M_AXI_bvalid(0) => M_AXI_bvalid(0),
      M_AXI_clk => M_AXI_clk,
      M_AXI_rdata(31 downto 0) => M_AXI_rdata(31 downto 0),
      M_AXI_rready(0) => M_AXI_rready(0),
      M_AXI_rresp(1 downto 0) => M_AXI_rresp(1 downto 0),
      M_AXI_rst_n(0) => M_AXI_rst_n(0),
      M_AXI_rvalid(0) => M_AXI_rvalid(0),
      M_AXI_wdata(31 downto 0) => M_AXI_wdata(31 downto 0),
      M_AXI_wready(0) => M_AXI_wready(0),
      M_AXI_wstrb(3 downto 0) => M_AXI_wstrb(3 downto 0),
      M_AXI_wvalid(0) => M_AXI_wvalid(0),
      axi_c2c_v7_to_zynq_clk => axi_c2c_v7_to_zynq_clk,
      axi_c2c_v7_to_zynq_data(16 downto 0) => axi_c2c_v7_to_zynq_data(16 downto 0),
      axi_c2c_v7_to_zynq_link_status => axi_c2c_v7_to_zynq_link_status,
      axi_c2c_zynq_to_v7_clk => axi_c2c_zynq_to_v7_clk,
      axi_c2c_zynq_to_v7_data(16 downto 0) => axi_c2c_zynq_to_v7_data(16 downto 0),
      axi_c2c_zynq_to_v7_reset => axi_c2c_zynq_to_v7_reset,
      clk_100mhz => clk_100mhz,
      clk_200_diff_in_clk_n => clk_200_diff_in_clk_n,
      clk_200_diff_in_clk_p => clk_200_diff_in_clk_p,
      clk_200mhz => clk_200mhz,
      clk_50mhz => clk_50mhz
    );
end STRUCTURE;
