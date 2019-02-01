-------------------------------------------------------------------------------
--                                                                            
--       Unit Name: gem_ctp7                                            
--                                                                            
--     Description: 
--
--                                                                            
-------------------------------------------------------------------------------
--                                                                            
--           Notes:                                                           
--                                                                            
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library UNISIM;
use UNISIM.VCOMPONENTS.all;

use work.gth_pkg.all;

use work.ctp7_utils_pkg.all;
use work.gem_ttc_pkg.all;
use work.system_package.all;
use work.gem_pkg.all;
use work.ipbus.all;
use work.axi_pkg.all;
use work.ipb_addr_decode.all;
use work.gem_board_config_package.all;

--============================================================================
--                                                          Entity declaration
--============================================================================
entity gem_ctp7 is
    generic(
        C_DATE_CODE      : std_logic_vector(31 downto 0) := x"00000000";
        C_GITHASH_CODE   : std_logic_vector(31 downto 0) := x"00000000";
        C_GIT_REPO_DIRTY : std_logic                     := '0'
    );
    port(
        clk_200_diff_in_clk_p          : in  std_logic;
        clk_200_diff_in_clk_n          : in  std_logic;

        clk_40_ttc_p_i                 : in  std_logic; -- TTC backplane clock signals
        clk_40_ttc_n_i                 : in  std_logic;
        ttc_data_p_i                   : in  std_logic;
        ttc_data_n_i                   : in  std_logic;

        LEDs                           : out std_logic_vector(1 downto 0);

        axi_c2c_v7_to_zynq_data        : out std_logic_vector(16 downto 0);
        axi_c2c_v7_to_zynq_clk         : out std_logic;
        axi_c2c_zynq_to_v7_clk         : in  std_logic;
        axi_c2c_zynq_to_v7_data        : in  std_logic_vector(16 downto 0);
        axi_c2c_v7_to_zynq_link_status : out std_logic;
        axi_c2c_zynq_to_v7_reset       : in  std_logic;

        refclk_F_0_p_i                 : in  std_logic_vector(3 downto 0);
        refclk_F_0_n_i                 : in  std_logic_vector(3 downto 0);
        refclk_F_1_p_i                 : in  std_logic_vector(3 downto 0);
        refclk_F_1_n_i                 : in  std_logic_vector(3 downto 0);

        refclk_B_0_p_i                 : in  std_logic_vector(3 downto 1);
        refclk_B_0_n_i                 : in  std_logic_vector(3 downto 1);
        refclk_B_1_p_i                 : in  std_logic_vector(3 downto 1);
        refclk_B_1_n_i                 : in  std_logic_vector(3 downto 1);
        
        -- AMC13 GTH
        amc13_gth_refclk_p             : in  std_logic;
        amc13_gth_refclk_n             : in  std_logic;
        amc_13_gth_rx_n                : in  std_logic;
        amc_13_gth_rx_p                : in  std_logic;
        amc13_gth_tx_n                 : out std_logic;
        amc13_gth_tx_p                 : out std_logic
        
    );
end gem_ctp7;

--============================================================================
--                                                        Architecture section
--============================================================================
architecture gem_ctp7_arch of gem_ctp7 is

    --============================================================================
    --                                                         Signal declarations
    --============================================================================

    -------------------------- System clocks ---------------------------------
    signal clk_50       : std_logic;
    signal clk_62p5     : std_logic;
    signal clk_200      : std_logic;

    -------------------------- AXI-IPbus bridge ---------------------------------
    --AXI
    signal axi_clk      : std_logic;
    signal axi_reset    : std_logic;
    signal ipb_axi_mosi : t_axi_lite_mosi;
    signal ipb_axi_miso : t_axi_lite_miso;
    --IPbus
    signal ipb_reset    : std_logic;
    signal ipb_clk      : std_logic;
    signal ipb_miso_arr : ipb_rbus_array(C_NUM_IPB_SLAVES - 1 downto 0) := (others => (ipb_rdata => (others => '0'), ipb_ack => '0', ipb_err => '0'));
    signal ipb_mosi_arr : ipb_wbus_array(C_NUM_IPB_SLAVES - 1 downto 0);

    -------------------------- TTC ---------------------------------
    signal ttc_clocks           : t_ttc_clks;
    signal ttc_clocks_locked    : std_logic;

    -------------------------- GTH ---------------------------------
    signal clk_gth_tx_arr       : std_logic_vector(g_NUM_OF_GTH_GTs - 1 downto 0);
    signal clk_gth_rx_arr       : std_logic_vector(g_NUM_OF_GTH_GTs - 1 downto 0);
    signal gth_tx_data_arr      : t_gt_8b10b_tx_data_arr(g_NUM_OF_GTH_GTs - 1 downto 0);
    signal gth_rx_data_arr      : t_gt_8b10b_rx_data_arr(g_NUM_OF_GTH_GTs - 1 downto 0);
    signal gth_gbt_tx_data_arr  : t_gt_gbt_data_arr(g_NUM_OF_GTH_GTs - 1 downto 0);
    signal gth_gbt_rx_data_arr  : t_gt_gbt_data_arr(g_NUM_OF_GTH_GTs - 1 downto 0);
    signal gth_rxreset_arr      : std_logic_vector(g_NUM_OF_GTH_GTs - 1 downto 0);
    signal gth_txreset_arr      : std_logic_vector(g_NUM_OF_GTH_GTs - 1 downto 0);

    
    -------------------- GTHs mapped to GEM links ---------------------------------
    
    -- Trigger RX GTX / GTH links (3.2Gbs, 16bit @ 160MHz w/ 8b10b encoding)
    signal gem_gt_trig0_rx_clk_arr  : std_logic_vector(CFG_NUM_OF_OHs - 1 downto 0);
    signal gem_gt_trig0_rx_data_arr : t_gt_8b10b_rx_data_arr(CFG_NUM_OF_OHs - 1 downto 0);
    signal gem_gt_trig1_rx_clk_arr  : std_logic_vector(CFG_NUM_OF_OHs - 1 downto 0);
    signal gem_gt_trig1_rx_data_arr : t_gt_8b10b_rx_data_arr(CFG_NUM_OF_OHs - 1 downto 0);

    -- GBT GTX/GTH links (4.8Gbs, 40bit @ 120MHz w/o 8b10b encoding)
    signal gem_gt_gbt_rx_data_arr   : t_gt_gbt_data_arr(CFG_NUM_OF_OHs * 3 - 1 downto 0);
    signal gem_gt_gbt_tx_data_arr   : t_gt_gbt_data_arr(CFG_NUM_OF_OHs * 3 - 1 downto 0);
    signal gem_gt_gbt_rx_clk_arr    : std_logic_vector(CFG_NUM_OF_OHs * 3 - 1 downto 0);
    signal gem_gt_gbt_tx_clk_arr    : std_logic_vector(CFG_NUM_OF_OHs * 3 - 1 downto 0);
    signal gth_gbt_common_rxusrclk  : std_logic;


    -------------------- AMC13 DAQLink ---------------------------------
    signal daq_to_daqlink       : t_daq_to_daqlink;
    signal daqlink_to_daq       : t_daqlink_to_daq;

    -------------------- GEM loader ---------------------------------
    signal to_gem_loader        : t_to_gem_loader;
    signal from_gem_loader      : t_from_gem_loader;

--============================================================================
--                                                          Architecture begin
--============================================================================

begin

    -------------------------- SYSTEM ---------------------------------

    i_system : entity work.system
        --    generic map(
        --      C_DATE_CODE      => C_DATE_CODE,
        --      C_GITHASH_CODE   => C_GITHASH_CODE,
        --      C_GIT_REPO_DIRTY => C_GIT_REPO_DIRTY
        --    )
        port map(
            clk_200_diff_in_clk_p          => clk_200_diff_in_clk_p,
            clk_200_diff_in_clk_n          => clk_200_diff_in_clk_n,
            
            axi_c2c_v7_to_zynq_data        => axi_c2c_v7_to_zynq_data,
            axi_c2c_v7_to_zynq_clk         => axi_c2c_v7_to_zynq_clk,
            axi_c2c_zynq_to_v7_clk         => axi_c2c_zynq_to_v7_clk,
            axi_c2c_zynq_to_v7_data        => axi_c2c_zynq_to_v7_data,
            axi_c2c_v7_to_zynq_link_status => axi_c2c_v7_to_zynq_link_status,
            axi_c2c_zynq_to_v7_reset       => axi_c2c_zynq_to_v7_reset,
            
            refclk_F_0_p_i                 => refclk_F_0_p_i,
            refclk_F_0_n_i                 => refclk_F_0_n_i,
            refclk_F_1_p_i                 => refclk_F_1_p_i,
            refclk_F_1_n_i                 => refclk_F_1_n_i,
            refclk_B_0_p_i                 => refclk_B_0_p_i,
            refclk_B_0_n_i                 => refclk_B_0_n_i,
            refclk_B_1_p_i                 => refclk_B_1_p_i,
            refclk_B_1_n_i                 => refclk_B_1_n_i,

            clk_50_o                       => clk_50,
            clk_62p5_o                     => clk_62p5,
            clk_200_o                      => clk_200,
            
            axi_clk_o                      => axi_clk,
            axi_reset_o                    => axi_reset,
            ipb_axi_mosi_o                 => ipb_axi_mosi,
            ipb_axi_miso_i                 => ipb_axi_miso,
            
            clk_40_ttc_p_i                 => clk_40_ttc_p_i,
            clk_40_ttc_n_i                 => clk_40_ttc_n_i,
            ttc_clks_o                     => ttc_clocks,
            ttc_clks_locked_o              => ttc_clocks_locked,
            
            clk_gth_tx_arr_o               => gem_gt_gbt_tx_clk_arr, --clk_gth_tx_arr,
            clk_gth_rx_arr_o               => gem_gt_gbt_rx_clk_arr, --clk_gth_rx_arr,
            
            gth_tx_data_arr_i              => gth_tx_data_arr,
            gth_rx_data_arr_o              => gth_rx_data_arr,
            gth_gbt_tx_data_arr_i          => gem_gt_gbt_tx_data_arr,--gth_gbt_tx_data_arr,
            gth_gbt_rx_data_arr_o          => gem_gt_gbt_rx_data_arr,--gth_gbt_rx_data_arr,
                  

            gth_gbt_common_rxusrclk_o      => gth_gbt_common_rxusrclk,
            
            gth_rxreset_arr_o              => gth_rxreset_arr,
            gth_txreset_arr_o              => gth_txreset_arr,

            amc13_gth_refclk_p             => amc13_gth_refclk_p,
            amc13_gth_refclk_n             => amc13_gth_refclk_n,
            amc_13_gth_rx_n                => amc_13_gth_rx_n,
            amc_13_gth_rx_p                => amc_13_gth_rx_p,
            amc13_gth_tx_n                 => amc13_gth_tx_n,
            amc13_gth_tx_p                 => amc13_gth_tx_p,
            
            daq_to_daqlink_i               => daq_to_daqlink,
            daqlink_to_daq_o               => daqlink_to_daq,

            from_gem_loader_o              => from_gem_loader,
            to_gem_loader_i                => to_gem_loader
        );

    i_gbt : entity work.gbt
        generic map(
            GBT_BANK_ID     => 0,
            NUM_LINKS       => 36, --g_NUM_OF_OHs * 3,
            TX_OPTIMIZATION => 1,
            RX_OPTIMIZATION => 0,
            TX_ENCODING     => 0,
            RX_ENCODING     => 0
        )
        port map(
            reset_i                     => reset,
            cnt_reset_i                 => link_reset,
            tx_frame_clk_i              => ttc_clocks_i.clk_40,
            rx_frame_clk_i              => ttc_clocks_i.clk_40,
            rx_word_common_clk_i        => gt_gbt_rx_common_clk_i,
            tx_word_clk_arr_i           => gt_gbt_tx_clk_arr_i,
            rx_word_clk_arr_i           => gt_gbt_rx_clk_arr_i,
            tx_ready_arr_i              => (others => '1'),
            tx_we_arr_i                 => (others => '1'),
            tx_data_arr_i               => gbt_tx_data_arr, --for data transmit!
            tx_gearbox_aligned_arr_o    => gbt_tx_gearbox_aligned_arr,
            tx_gearbox_align_done_arr_o => gbt_tx_gearbox_align_done_arr,
            rx_frame_clk_rdy_arr_i      => (others => '1'),
            rx_word_clk_rdy_arr_i       => (others => '1'),
            rx_bitslip_nbr_arr_o        => gbt_rx_bitslip_nbr,
            rx_header_arr_o             => gbt_rx_header,
            rx_header_locked_arr_o      => gbt_rx_header_locked,
            rx_data_valid_arr_o         => gbt_rx_valid_arr,
            rx_data_arr_o               => gbt_rx_data_arr,
            mgt_rx_rdy_arr_i            => (others => '1'),
            mgt_tx_data_arr_o           => gt_gbt_tx_data_arr_o,
            mgt_rx_data_arr_i           => gt_gbt_rx_data_arr_i,
            link_status_arr_o           => gbt_link_status_arr
        );
        
  

--    -------------------------- GEM logic ---------------------------------
    
--    i_gem : entity work.gem_amc
--        generic map(
--            g_USE_TRIG_LINKS     => CFG_USE_TRIG_LINKS,
--            g_NUM_OF_OHs         => CFG_NUM_OF_OHs,
--            g_NUM_IPB_SLAVES     => C_NUM_IPB_SLAVES,
--            g_DAQ_CLK_FREQ       => 62_500_000 --50_000_000
--        )
--        port map(
--            reset_i                 => '0',
--            reset_pwrup_o           => open,
            
--            ttc_data_p_i            => ttc_data_p_i,
--            ttc_data_n_i            => ttc_data_n_i,
--            ttc_clocks_i            => ttc_clocks,
--            ttc_clocks_locked_i     => ttc_clocks_locked,
            
--            gt_trig0_rx_clk_arr_i   => gem_gt_trig0_rx_clk_arr,
--            gt_trig0_rx_data_arr_i  => gem_gt_trig0_rx_data_arr,
--            gt_trig1_rx_clk_arr_i   => gem_gt_trig1_rx_clk_arr,
--            gt_trig1_rx_data_arr_i  => gem_gt_trig1_rx_data_arr,

--            gt_gbt_rx_data_arr_i    => gem_gt_gbt_rx_data_arr,
--            gt_gbt_tx_data_arr_o    => gem_gt_gbt_tx_data_arr,
--            gt_gbt_rx_clk_arr_i     => gem_gt_gbt_rx_clk_arr,
--            gt_gbt_tx_clk_arr_i     => gem_gt_gbt_tx_clk_arr,
--            gt_gbt_rx_common_clk_i  => gth_gbt_common_rxusrclk,            
            
--            ipb_reset_i             => ipb_reset,
--            ipb_clk_i               => ipb_clk,
--            ipb_miso_arr_o          => ipb_miso_arr,
--            ipb_mosi_arr_i          => ipb_mosi_arr,

--            led_l1a_o               => LEDs(0),
--            led_trigger_o           => LEDs(1),
            
--            daq_data_clk_i          => clk_62p5, --clk_50,
--            daq_data_clk_locked_i   => '1',
--            daq_to_daqlink_o        => daq_to_daqlink,
--            daqlink_to_daq_i        => daqlink_to_daq,
            
--            board_id_i              => x"beef",

--            to_gem_loader_o         => to_gem_loader,
--            from_gem_loader_i       => from_gem_loader
--        );
        

--    -- GTH mapping to GEM links
--    g_gem_links : for i in 0 to CFG_NUM_OF_OHs - 1 generate

--        gth_gbt_tx_data_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).gbt0_link).tx) <= gem_gt_gbt_tx_data_arr(i * 3);
--        gth_gbt_tx_data_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).gbt1_link).tx) <= gem_gt_gbt_tx_data_arr(i * 3 + 1);
--        gth_gbt_tx_data_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).gbt2_link).tx) <= gem_gt_gbt_tx_data_arr(i * 3 + 2);
        
--        gem_gt_gbt_rx_data_arr(i * 3)     <= gth_gbt_rx_data_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).gbt0_link).rx);
--        gem_gt_gbt_rx_data_arr(i * 3 + 1) <= gth_gbt_rx_data_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).gbt1_link).rx);
--        gem_gt_gbt_rx_data_arr(i * 3 + 2) <= gth_gbt_rx_data_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).gbt2_link).rx);

--        gem_gt_gbt_rx_clk_arr(i * 3)     <= clk_gth_rx_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).gbt0_link).rx);
--        gem_gt_gbt_rx_clk_arr(i * 3 + 1) <= clk_gth_rx_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).gbt1_link).rx);
--        gem_gt_gbt_rx_clk_arr(i * 3 + 2) <= clk_gth_rx_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).gbt2_link).rx);
        
--        gem_gt_gbt_tx_clk_arr(i * 3)     <= clk_gth_tx_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).gbt0_link).tx);
--        gem_gt_gbt_tx_clk_arr(i * 3 + 1) <= clk_gth_tx_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).gbt1_link).tx);
--        gem_gt_gbt_tx_clk_arr(i * 3 + 2) <= clk_gth_tx_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).gbt2_link).tx);        

--        gem_gt_trig0_rx_clk_arr(i)  <= clk_gth_rx_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).trig0_rx_link).rx);
--        gem_gt_trig0_rx_data_arr(i) <= gth_rx_data_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).trig0_rx_link).rx);
--        gem_gt_trig1_rx_clk_arr(i)  <= clk_gth_rx_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).trig1_rx_link).rx);
--        gem_gt_trig1_rx_data_arr(i) <= gth_rx_data_arr(CFG_CXP_FIBER_TO_GTH_MAP(CFG_OH_LINK_CONFIG_ARR(i).trig1_rx_link).rx);
        
--    end generate; 

end gem_ctp7_arch;

--============================================================================
--                                                            Architecture end
--============================================================================

