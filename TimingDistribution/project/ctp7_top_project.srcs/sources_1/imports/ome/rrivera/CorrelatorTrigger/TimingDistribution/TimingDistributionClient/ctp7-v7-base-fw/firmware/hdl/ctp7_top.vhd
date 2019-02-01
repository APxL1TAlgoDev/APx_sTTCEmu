library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;


use work.StdRtlPkg.all;
use work.AxiLitePkg.all;

-- packages added for GEM style pieces
use work.ttc_pkg.all;
use work.system_package.all;
use work.gth_pkg.all;
use work.gem_pkg.all;
-- end packages added for GEM style pieces

library UNISIM;
use UNISIM.VCOMPONENTS.all;

entity ctp7_top is
  generic (
    TPD_G        : time   := 1 ns;
    BUILD_INFO_G : BuildInfoType;
    XIL_DEVICE_G : string := "7SERIES"
    );
  port (

    clk_200_diff_in_clk_p : in sl;
    clk_200_diff_in_clk_n : in sl;

    clk_40_ttc_p_i : in sl;             -- TTC backplane clock signals
    clk_40_ttc_n_i : in sl;
    ttc_data_p_i   : in sl;
    ttc_data_n_i   : in sl;

    LEDs : out slv (1 downto 0);

    LED_GREEN_o : out sl;
    LED_RED_o   : out sl;
    LED_BLUE_o  : out sl;

    refclk_F_0_p_i : in slv (3 downto 0);
    refclk_F_0_n_i : in slv (3 downto 0);
    refclk_F_1_p_i : in slv (3 downto 0);
    refclk_F_1_n_i : in slv (3 downto 0);
    
    refclk_B_0_p_i : in slv (3 downto 0);
    refclk_B_0_n_i : in slv (3 downto 0);
    refclk_B_1_p_i : in slv (3 downto 0);
    refclk_B_1_n_i : in slv (3 downto 0);

    axi_c2c_v7_to_zynq_data        : out slv (16 downto 0);
    axi_c2c_v7_to_zynq_clk         : out sl;
    axi_c2c_zynq_to_v7_clk         : in  sl;
    axi_c2c_zynq_to_v7_data        : in  slv (16 downto 0);
    axi_c2c_v7_to_zynq_link_status : out sl;
    axi_c2c_zynq_to_v7_reset       : in  sl
    );
end ctp7_top;

architecture ctp7_top_arch of ctp7_top is

  component v7_bd is
    port (

      M_AXI_clk                      : out sl;
      M_AXI_rst_n                    : out slv (0 downto 0);
      M_AXI_araddr                   : out slv (31 downto 0);
      M_AXI_arprot                   : out slv (2 downto 0);
      M_AXI_arready                  : in  slv (0 to 0);
      M_AXI_arvalid                  : out slv (0 to 0);
      M_AXI_awaddr                   : out slv (31 downto 0);
      M_AXI_awprot                   : out slv (2 downto 0);
      M_AXI_awready                  : in  slv (0 to 0);
      M_AXI_awvalid                  : out slv (0 to 0);
      M_AXI_bready                   : out slv (0 to 0);
      M_AXI_bresp                    : in  slv (1 downto 0);
      M_AXI_bvalid                   : in  slv (0 to 0);
      M_AXI_rdata                    : in  slv (31 downto 0);
      M_AXI_rready                   : out slv (0 to 0);
      M_AXI_rresp                    : in  slv (1 downto 0);
      M_AXI_rvalid                   : in  slv (0 to 0);
      M_AXI_wdata                    : out slv (31 downto 0);
      M_AXI_wready                   : in  slv (0 to 0);
      M_AXI_wstrb                    : out slv (3 downto 0);
      M_AXI_wvalid                   : out slv (0 to 0);
      axi_c2c_v7_to_zynq_clk         : out sl;
      axi_c2c_v7_to_zynq_data        : out slv (16 downto 0);
      axi_c2c_v7_to_zynq_link_status : out sl;
      axi_c2c_zynq_to_v7_clk         : in  sl;
      axi_c2c_zynq_to_v7_data        : in  slv (16 downto 0);
      axi_c2c_zynq_to_v7_reset       : in  sl;
      clk_100mhz                     : out sl;
      clk_200_diff_in_clk_n          : in  sl;
      clk_200_diff_in_clk_p          : in  sl;
      clk_200mhz                     : out sl;
      clk_50mhz                      : out sl
      );
  end component v7_bd;

  signal s_LED_FP : slv(31 downto 0);

  signal clk_50mhz  : sl;
  signal clk_100mhz : sl;
  signal clk_200mhz : sl;
  
  signal M_AXI_clk     : sl;
  signal M_AXI_rst_n   : slv (0 downto 0);
  signal M_AXI_rst     : sl;
  signal M_AXI_araddr  : slv (31 downto 0);
  signal M_AXI_arprot  : slv (2 downto 0);
  signal M_AXI_arready : slv (0 to 0);
  signal M_AXI_arvalid : slv (0 to 0);
  signal M_AXI_awaddr  : slv (31 downto 0);
  signal M_AXI_awprot  : slv (2 downto 0);
  signal M_AXI_awready : slv (0 to 0);
  signal M_AXI_awvalid : slv (0 to 0);
  signal M_AXI_bready  : slv (0 to 0);
  signal M_AXI_bresp   : slv (1 downto 0);
  signal M_AXI_bvalid  : slv (0 to 0);
  signal M_AXI_rdata   : slv (31 downto 0);
  signal M_AXI_rready  : slv (0 to 0);
  signal M_AXI_rresp   : slv (1 downto 0);
  signal M_AXI_rvalid  : slv (0 to 0);
  signal M_AXI_wdata   : slv (31 downto 0);
  signal M_AXI_wready  : slv (0 to 0);
  signal M_AXI_wstrb   : slv (3 downto 0);
  signal M_AXI_wvalid  : slv (0 to 0);


  signal s_ttc_clk_40  : sl;
  signal s_ttc_clk_120 : sl;
  signal s_ttc_clk_240 : sl;

  signal s_ttc_cmds    : t_ttc_cmds;
  signal ttc_daq_cntrs : t_ttc_daq_cntrs;

  signal s_local_timing_ref : t_timing_ref;

  constant AXI_CLK_FREQUENCY_G : real := 50.00E+6;

  constant NUM_AXI_MASTERS_C : natural := 3;

  constant VERSION_INDEX_C : natural := 0;
  constant TTC_INDEX_C     : natural := 1;
  constant TEST_INDEX_C    : natural := 2;

  -- constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXI_MASTERS_C, x"0000_0000", 20, 16);
  constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := (
    VERSION_INDEX_C => (
      baseAddr      => x"6000_0000",
      addrBits      => 16,
      connectivity  => x"FFFF"),
    TTC_INDEX_C     => (
      baseAddr      => x"6001_0000",
      addrBits      => 16,
      connectivity  => x"FFFF"),
    TEST_INDEX_C    => (
      baseAddr      => x"6003_0000",
      addrBits      => 16,
      connectivity  => x"FFFF"));

  signal mAxilWriteMaster : AxiLiteWriteMasterType;
  signal mAxilWriteSlave  : AxiLiteWriteSlaveType;
  signal mAxilReadMaster  : AxiLiteReadMasterType;
  signal mAxilReadSlave   : AxiLiteReadSlaveType;

  signal mAxilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
  signal mAxilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0) := (others => AXI_LITE_WRITE_SLAVE_EMPTY_DECERR_C);
  signal mAxilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
  signal mAxilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0)  := (others => AXI_LITE_READ_SLAVE_EMPTY_DECERR_C);

begin






  LED_GREEN_o <= s_LED_FP(0);
  LED_RED_o   <= s_LED_FP(1);
  LED_BLUE_o  <= s_LED_FP(2);

  i_v7_bd : v7_bd
    port map (
      M_AXI_clk                            => M_AXI_clk,
      M_AXI_rst_n(0)                       => M_AXI_rst_n(0),
      M_AXI_araddr(31 downto 0)            => M_AXI_araddr(31 downto 0),
      M_AXI_arprot(2 downto 0)             => M_AXI_arprot(2 downto 0),
      M_AXI_arready(0)                     => M_AXI_arready(0),
      M_AXI_arvalid(0)                     => M_AXI_arvalid(0),
      M_AXI_awaddr(31 downto 0)            => M_AXI_awaddr(31 downto 0),
      M_AXI_awprot(2 downto 0)             => M_AXI_awprot(2 downto 0),
      M_AXI_awready(0)                     => M_AXI_awready(0),
      M_AXI_awvalid(0)                     => M_AXI_awvalid(0),
      M_AXI_bready(0)                      => M_AXI_bready(0),
      M_AXI_bresp(1 downto 0)              => M_AXI_bresp(1 downto 0),
      M_AXI_bvalid(0)                      => M_AXI_bvalid(0),
      M_AXI_rdata(31 downto 0)             => M_AXI_rdata(31 downto 0),
      M_AXI_rready(0)                      => M_AXI_rready(0),
      M_AXI_rresp(1 downto 0)              => M_AXI_rresp(1 downto 0),
      M_AXI_rvalid(0)                      => M_AXI_rvalid(0),
      M_AXI_wdata(31 downto 0)             => M_AXI_wdata(31 downto 0),
      M_AXI_wready(0)                      => M_AXI_wready(0),
      M_AXI_wstrb(3 downto 0)              => M_AXI_wstrb(3 downto 0),
      M_AXI_wvalid(0)                      => M_AXI_wvalid(0),
      axi_c2c_v7_to_zynq_clk               => axi_c2c_v7_to_zynq_clk,
      axi_c2c_v7_to_zynq_data(16 downto 0) => axi_c2c_v7_to_zynq_data(16 downto 0),
      axi_c2c_v7_to_zynq_link_status       => axi_c2c_v7_to_zynq_link_status,
      axi_c2c_zynq_to_v7_clk               => axi_c2c_zynq_to_v7_clk,
      axi_c2c_zynq_to_v7_data(16 downto 0) => axi_c2c_zynq_to_v7_data(16 downto 0),
      axi_c2c_zynq_to_v7_reset             => axi_c2c_zynq_to_v7_reset,
      clk_100mhz                           => clk_100mhz,
      clk_200_diff_in_clk_n                => clk_200_diff_in_clk_n,
      clk_200_diff_in_clk_p                => clk_200_diff_in_clk_p,
      clk_200mhz                           => clk_200mhz,
      clk_50mhz                            => clk_50mhz
      );


  M_AXI_rst <= not M_AXI_rst_n(0);

  mAxilWriteMaster.awaddr <= M_AXI_awaddr;
  mAxilReadMaster.araddr  <= M_AXI_araddr;

  M_AXI_bresp <= mAxilWriteSlave.bresp;
  M_AXI_rresp <= mAxilReadSlave.rresp;

  M_AXI_awprot     <= mAxilWriteMaster.awprot;
  M_AXI_awvalid(0) <= mAxilWriteMaster.awvalid;
  M_AXI_wdata      <= mAxilWriteMaster.wdata;
  M_AXI_wstrb      <= mAxilWriteMaster.wstrb;
  M_AXI_wvalid(0)  <= mAxilWriteMaster.wvalid;
  M_AXI_bready(0)  <= mAxilWriteMaster.bready;
  M_AXI_awready(0) <= mAxilWriteSlave.awready;
  M_AXI_wready(0)  <= mAxilWriteSlave.wready;
  M_AXI_bvalid(0)  <= mAxilWriteSlave.bvalid;
  M_AXI_arprot     <= mAxilReadMaster.arprot;
  M_AXI_arvalid(0) <= mAxilReadMaster.arvalid;
  M_AXI_rready(0)  <= mAxilReadMaster.rready;
  M_AXI_arready(0) <= mAxilReadSlave.arready;
  M_AXI_rdata      <= mAxilReadSlave.rdata;
  M_AXI_rvalid(0)  <= mAxilReadSlave.rvalid;


---------------------------
  -- AXI-Lite Crossbar Module
  ---------------------------         
  U_XBAR : entity work.AxiLiteCrossbar
    generic map (
      TPD_G              => TPD_G,
      NUM_SLAVE_SLOTS_G  => 1,
      NUM_MASTER_SLOTS_G => NUM_AXI_MASTERS_C,
      MASTERS_CONFIG_G   => AXI_CONFIG_C)
    port map (
      sAxiWriteMasters(0) => mAxilWriteMaster,
      sAxiWriteSlaves(0)  => mAxilWriteSlave,
      sAxiReadMasters(0)  => mAxilReadMaster,
      sAxiReadSlaves(0)   => mAxilReadSlave,
      mAxiWriteMasters    => mAxilWriteMasters,
      mAxiWriteSlaves     => mAxilWriteSlaves,
      mAxiReadMasters     => mAxilReadMasters,
      mAxiReadSlaves      => mAxilReadSlaves,
      axiClk              => M_AXI_clk,
      axiClkRst           => M_AXI_rst);

  ---------------------------
  -- AXI-Lite: Version Module
  ---------------------------            
  U_AxiVersion : entity work.AxiVersion
    generic map (
      TPD_G           => TPD_G,
      CLK_PERIOD_G    => (1.0/AXI_CLK_FREQUENCY_G),
      BUILD_INFO_G    => BUILD_INFO_G,
      XIL_DEVICE_G    => XIL_DEVICE_G,
      EN_DEVICE_DNA_G => true)
    port map (
      axiReadMaster  => mAxilReadMasters(VERSION_INDEX_C),
      axiReadSlave   => mAxilReadSlaves(VERSION_INDEX_C),
      axiWriteMaster => mAxilWriteMasters(VERSION_INDEX_C),
      axiWriteSlave  => mAxilWriteSlaves(VERSION_INDEX_C),
      axiClk         => M_AXI_clk,
      axiRst         => M_AXI_rst);

  U_ttc_core : entity work.ttc_core
    port map (

      clk_40_ttc_p_i     => clk_40_ttc_p_i,
      clk_40_ttc_n_i     => clk_40_ttc_n_i,
      ttc_data_p_i       => ttc_data_p_i,
      ttc_data_n_i       => ttc_data_n_i,
      clk_40_bufg_o      => s_ttc_clk_40,
      clk_120_bufg_o     => s_ttc_clk_120,
      clk_240_bufg_o     => s_ttc_clk_240,
      local_timing_ref_o => s_local_timing_ref,
      ttc_cmds_o         => s_ttc_cmds,
      ttc_daq_cntrs_o    => ttc_daq_cntrs,

      axiReadMaster  => mAxilReadMasters(TTC_INDEX_C),
      axiReadSlave   => mAxilReadSlaves(TTC_INDEX_C),
      axiWriteMaster => mAxilWriteMasters(TTC_INDEX_C),
      axiWriteSlave  => mAxilWriteSlaves(TTC_INDEX_C),
      axiClk         => M_AXI_clk,
      axiRst         => M_AXI_rst);

  -------------------------------------------------------------
  -- Map the AXI-Lite to Test bus (never respond with an error)
  -------------------------------------------------------------
  mAxilReadSlaves(TEST_INDEX_C)  <= AXI_LITE_READ_SLAVE_EMPTY_OK_C;
  mAxilWriteSlaves(TEST_INDEX_C) <= AXI_LITE_WRITE_SLAVE_EMPTY_OK_C;



    --====================== GEM project's gth_wrapper and GBT
    
  GEM_style_source_links : for i in 0 to 0 generate
  
  
    signal ttc_clks_i  : t_ttc_clks;
    
    signal s_gth_common_reset : std_logic_vector(g_NUM_OF_GTH_COMMONs-1 downto 0);
    signal s_gth_gt_txreset   : std_logic_vector(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_gth_gt_rxreset   : std_logic_vector(g_NUM_OF_GTH_GTs-1 downto 0);
  
    signal s_gth_common_status_arr  : t_gth_common_status_arr(g_NUM_OF_GTH_COMMONs-1 downto 0);
    signal s_gth_common_drp_in_arr  : t_gth_common_drp_in_arr(g_NUM_OF_GTH_COMMONs-1 downto 0);
    signal s_gth_common_drp_out_arr : t_gth_common_drp_out_arr(g_NUM_OF_GTH_COMMONs-1 downto 0);
  
    signal s_gth_gt_txreset_done : std_logic_vector(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_gth_gt_rxreset_done : std_logic_vector(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_gth_rx_serial_arr   : t_gth_rx_serial_arr(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_gth_tx_serial_arr   : t_gth_tx_serial_arr(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_gth_gt_drp_in_arr   : t_gth_gt_drp_in_arr(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_gth_gt_drp_out_arr  : t_gth_gt_drp_out_arr(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_gth_tx_ctrl_arr     : t_gth_tx_ctrl_arr(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_gth_tx_status_arr   : t_gth_tx_status_arr(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_gth_rx_ctrl_arr     : t_gth_rx_ctrl_arr(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_gth_rx_ctrl_2_arr   : t_gth_rx_ctrl_2_arr(g_NUM_OF_GTH_GTs-1 downto 0);
  
    signal s_gth_rx_status_arr   : t_gth_rx_status_arr(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_gth_misc_ctrl_arr   : t_gth_misc_ctrl_arr(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_gth_misc_status_arr : t_gth_misc_status_arr(g_NUM_OF_GTH_GTs-1 downto 0);
    
    signal s_gth_tx_data_arr     : t_gt_8b10b_tx_data_arr(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_gth_rx_data_arr     : t_gt_8b10b_rx_data_arr(g_NUM_OF_GTH_GTs-1 downto 0);
  
    signal s_gth_gbt_tx_data_arr : t_gt_gbt_data_arr(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_gth_gbt_rx_data_arr : t_gt_gbt_data_arr(g_NUM_OF_GTH_GTs-1 downto 0);
    
    signal s_clk_gth_tx_usrclk_arr : std_logic_vector(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_clk_gth_rx_usrclk_arr : std_logic_vector(g_NUM_OF_GTH_GTs-1 downto 0);
    signal s_gth_cpll_status_arr   : t_gth_cpll_status_arr(g_NUM_OF_GTH_GTs-1 downto 0);
    
    
    signal gth_gbt_common_rxusrclk_o   : std_logic;
        
    signal reset : std_logic := '1';
    
    
    ---- for gbt
    signal gbt_link_status_arr      : t_gbt_link_status_arr(g_NUM_OF_GTH_GTs - 1 downto 0);
    signal gbt_rx_data_valid_arr    : std_logic_vector(g_NUM_OF_GTH_GTs - 1 downto 0);
    signal gbt_rx_data_arr          : t_gbt_frame_array(g_NUM_OF_GTH_GTs - 1 downto 0);
    signal gbt_tx_data_arr          : t_gbt_frame_array(g_NUM_OF_GTH_GTs - 1 downto 0);
    signal gbt_tx_data_source       : t_gbt_frame;
    
    attribute mark_debug : string;
    attribute mark_debug of reset : signal is "true";
    attribute mark_debug of gbt_link_status_arr : signal is "true";
    attribute mark_debug of gbt_rx_data_valid_arr : signal is "true";
    --attribute mark_debug of gbt_rx_data_arr : signal is "true";
    --attribute mark_debug of gbt_tx_data_arr : signal is "true";
    
    attribute mark_debug of gbt_tx_data_source : signal is "true";
        
  begin
  
    ttc_clks_i.clk_120 <= s_ttc_clk_120;
    ttc_clks_i.clk_40 <= s_ttc_clk_40;
    
    i_gth_wrapper : entity work.gth_wrapper
        generic map
        (
          g_EXAMPLE_SIMULATION     => 0,
          g_STABLE_CLOCK_PERIOD    => 20,
          g_NUM_OF_GTH_GTs         => g_NUM_OF_GTH_GTs,
          g_NUM_OF_GTH_COMMONs     => g_NUM_OF_GTH_COMMONs,
          g_GT_SIM_GTRESET_SPEEDUP => "FALSE"
    
          )
        port map (
          clk_stable_i => clk_50mhz,--s_clk_50,
    
          clk_gth_tx_usrclk_arr_o => s_clk_gth_tx_usrclk_arr,
          clk_gth_rx_usrclk_arr_o => s_clk_gth_rx_usrclk_arr,
          gth_cpll_status_arr_o   => s_gth_cpll_status_arr,          
    
          ttc_clks_i              => ttc_clks_i,
          ttc_clks_locked_i       => '1',--ttc_clks_locked,
          ttc_clks_reset_o        => open,--ttc_clks_reset,
    
          refclk_F_0_p_i          => refclk_F_0_p_i,
          refclk_F_0_n_i          => refclk_F_0_n_i,
          refclk_F_1_p_i          => refclk_F_1_p_i,
          refclk_F_1_n_i          => refclk_F_1_n_i,
          refclk_B_0_p_i          => refclk_B_0_p_i(3 downto 1),
          refclk_B_0_n_i          => refclk_B_0_n_i(3 downto 1),
          refclk_B_1_p_i          => refclk_B_1_p_i(3 downto 1),
          refclk_B_1_n_i          => refclk_B_1_n_i(3 downto 1),
          gth_common_reset_i      => s_gth_common_reset,
          gth_common_status_arr_o => s_gth_common_status_arr,
          gth_common_drp_arr_i    => s_gth_common_drp_in_arr,
          gth_common_drp_arr_o    => s_gth_common_drp_out_arr,
          gth_gt_txreset_i        => s_gth_gt_txreset,
          gth_gt_rxreset_i        => s_gth_gt_rxreset,
          gth_gt_txreset_done_o   => s_gth_gt_txreset_done,
          gth_gt_rxreset_done_o   => s_gth_gt_rxreset_done,
          gth_gt_drp_arr_i        => s_gth_gt_drp_in_arr,
          gth_gt_drp_arr_o        => s_gth_gt_drp_out_arr,
          gth_tx_ctrl_arr_i       => s_gth_tx_ctrl_arr,
          gth_tx_status_arr_o     => s_gth_tx_status_arr,
          gth_rx_ctrl_arr_i       => s_gth_rx_ctrl_arr,
          gth_rx_ctrl_2_arr_i     => s_gth_rx_ctrl_2_arr,
    
          gth_rx_status_arr_o   => s_gth_rx_status_arr,
          gth_misc_ctrl_arr_i   => s_gth_misc_ctrl_arr,
          gth_misc_status_arr_o => s_gth_misc_status_arr,
          
          gth_tx_data_arr_i     => s_gth_tx_data_arr,
          gth_rx_data_arr_o     => s_gth_rx_data_arr,
          gth_gbt_tx_data_arr_i => s_gth_gbt_tx_data_arr,
          gth_gbt_rx_data_arr_o => s_gth_gbt_rx_data_arr,      
          
          gth_tx_serial_arr_o   => s_gth_tx_serial_arr,
          gth_rx_serial_arr_i   => s_gth_rx_serial_arr,
    
          gth_gbt_common_rxusrclk_o => gth_gbt_common_rxusrclk_o,
          gth_gbt_common_txoutclk_o => open --ttc_clk_160_clean
          );
      
              
      i_gbt : entity work.gbt
          generic map(
              GBT_BANK_ID     => 0,
              NUM_LINKS       => g_NUM_OF_GTH_GTs, --36, g_NUM_OF_OHs * 3,
              TX_OPTIMIZATION => 1,
              RX_OPTIMIZATION => 0,
              TX_ENCODING     => 0,
              RX_ENCODING     => 0
          )
          port map(
              reset_i                     => reset,
              cnt_reset_i                 => '0', --link_reset,
              tx_frame_clk_i              => ttc_clks_i.clk_40,
              rx_frame_clk_i              => ttc_clks_i.clk_40,
              rx_word_common_clk_i        => gth_gbt_common_rxusrclk_o, --gt_gbt_rx_common_clk_i,
              tx_word_clk_arr_i           => s_clk_gth_tx_usrclk_arr, --equivalent to ttc_clks_i.clk_120 --gt_gbt_tx_clk_arr_i,
              rx_word_clk_arr_i           => s_clk_gth_rx_usrclk_arr, --gt_gbt_rx_clk_arr_i,
              tx_ready_arr_i              => (others => '1'),
              tx_we_arr_i                 => (others => '1'),
              tx_data_arr_i               => gbt_tx_data_arr, --for data transmit!
              tx_gearbox_aligned_arr_o    => open,--gbt_tx_gearbox_aligned_arr,
              tx_gearbox_align_done_arr_o => open,--gbt_tx_gearbox_align_done_arr,
              rx_frame_clk_rdy_arr_i      => (others => '1'),
              rx_word_clk_rdy_arr_i       => (others => '1'),
              rx_bitslip_nbr_arr_o        => open, --gbt_rx_bitslip_nbr,
              rx_header_arr_o             => open, --gbt_rx_header,
              rx_header_locked_arr_o      => open, --gbt_rx_header_locked,
              rx_data_valid_arr_o         => gbt_rx_data_valid_arr,
              rx_data_arr_o               => gbt_rx_data_arr,
              mgt_rx_rdy_arr_i            => (others => '1'),
              mgt_tx_data_arr_o           => s_gth_gbt_tx_data_arr, --gt_gbt_tx_data_arr_o,
              mgt_rx_data_arr_i           => s_gth_gbt_rx_data_arr, --gt_gbt_rx_data_arr_i,
              link_status_arr_o           => gbt_link_status_arr
          );
        
        -- create rx debug
        gen_rx_debug : for j in 0 to 0 generate 
              
              
            type t_gbt_ttc_array is array(integer range <>) of std_logic_vector(NUM_OF_TTC_CMDS-1 downto 0);
            
            signal gbt_rx_dbg_lo : t_gbt_ttc_array(g_NUM_OF_GTH_GTs-1 downto 0);   
            signal gbt_rx_dbg_hi : t_gbt_ttc_array(g_NUM_OF_GTH_GTs-1 downto 0);
                
            attribute mark_debug : string;
            attribute mark_debug of gbt_rx_dbg_lo : signal is "true";
            attribute mark_debug of gbt_rx_dbg_hi : signal is "true";
        begin 
        
            gen_rx_debug_mapping : for k in 0 to g_NUM_OF_GTH_GTs-1 generate
            begin
                gbt_rx_dbg_lo(k) <= gbt_rx_data_arr(k)(NUM_OF_TTC_CMDS-1 downto 0);
                gbt_rx_dbg_hi(k) <= gbt_rx_data_arr(k)(83 downto 84-NUM_OF_TTC_CMDS);
            end generate;
                    
        end generate; 
         
          
        -- create tx data
        gen_tx_data : for j in 0 to 0 generate 
        
            signal s_ttc_cmds_latch : t_ttc_cmds;              
            signal gen_ttc_cmds_sig : std_logic_vector(NUM_OF_TTC_CMDS-1 downto 0);
            signal gen_ttc_cmds_cnt : unsigned(19 downto 0) := (others => '0');          
            
            attribute mark_debug : string;
            attribute mark_debug of s_ttc_cmds_latch : signal is "true";
        begin
        
            --in ttc_pkg there are 7 commands
            --  for now, take those commands in the low bits of gbt data
            --gbt data is 84 bits, and top 4 bits are reserved for ASIC use
            --  for now, we are just using low 7 bits
          
          process(ttc_clks_i.clk_120) -- equivalent to s_clk_gth_tx_usrclk_arr(:)
          begin
          
            if (rising_edge(ttc_clks_i.clk_120)) then
                s_ttc_cmds_latch <= s_ttc_cmds;
                
                gbt_tx_data_source(0) <= s_ttc_cmds_latch.l1a or
                    ((not gen_ttc_cmds_sig(0)) and gen_ttc_cmds_cnt(0));
                gbt_tx_data_source(1) <= s_ttc_cmds_latch.bc0 or
                    ((not gen_ttc_cmds_sig(1)) and gen_ttc_cmds_cnt(1));
                gbt_tx_data_source(2) <= s_ttc_cmds_latch.resync or
                    ((not gen_ttc_cmds_sig(2)) and gen_ttc_cmds_cnt(2));
                gbt_tx_data_source(3) <= s_ttc_cmds_latch.start or
                    ((not gen_ttc_cmds_sig(3)) and gen_ttc_cmds_cnt(3));
                gbt_tx_data_source(4) <= s_ttc_cmds_latch.stop or
                    ((not gen_ttc_cmds_sig(4)) and gen_ttc_cmds_cnt(4));
                gbt_tx_data_source(5) <= s_ttc_cmds_latch.ec0 or
                    ((not gen_ttc_cmds_sig(5)) and gen_ttc_cmds_cnt(5));
                gbt_tx_data_source(6) <= s_ttc_cmds_latch.test_sync or
                    ((not gen_ttc_cmds_sig(6)) and gen_ttc_cmds_cnt(6));
            end if;
            
          end process;
          
            gen_fake_ttc_cmds : for k in 0 to 0 generate
            begin
                process(ttc_clks_i.clk_120) -- equivalent to s_clk_gth_tx_usrclk_arr(:)
                begin
                    if (rising_edge(ttc_clks_i.clk_120)) then
                        gen_ttc_cmds_cnt <= gen_ttc_cmds_cnt + 1;
                        gen_ttc_cmds_sig(k) <= gen_ttc_cmds_cnt(k);
                    end if;
                end process;
            end generate; 
          
          
        end generate;
        
        -- create tx data fanout
        gen_tx_data_fanout : for j in 0 to g_NUM_OF_GTH_GTs-1 generate 
        begin
          gbt_tx_data_arr(j) <= gbt_tx_data_source;          
        end generate;
        
        -- create reset for ~1 second
        gen_reset : for j in 0 to 0 generate 
        signal reset_counter : unsigned(25 downto 0) := (others => '1');
        begin
         process(ttc_clks_i.clk_40)
         begin         
           if(rising_edge(ttc_clks_i.clk_40)) then
               if(reset_counter = 0) then 
                   reset <= '0';
               else
                   reset_counter <= reset_counter - 1;
                   reset <= '1';
               end if;
           end if;
           
         end process;
        end generate;
         
             
     end generate;
     
     
      
end ctp7_top_arch;
