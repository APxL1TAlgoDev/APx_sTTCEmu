library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.StdRtlPkg.all;
use work.AxiLitePkg.all;

use work.ttc_pkg.all;

entity ttc_core is
  generic (
    TPD_G : time := 1 ns
    );
  port (

    clk_40_ttc_p_i : in sl;             -- TTC backplane clock signals
    clk_40_ttc_n_i : in sl;

    ttc_data_p_i : in sl;               -- TTC protocol backplane signals
    ttc_data_n_i : in sl;

    clk_40_bufg_o  : out sl;
    clk_120_bufg_o : out sl;
    clk_240_bufg_o : out sl;

    local_timing_ref_o : out t_timing_ref;
    ttc_cmds_o         : out t_ttc_cmds;
    ttc_daq_cntrs_o    : out t_ttc_daq_cntrs;

    -- AXI-Lite Interface
    axiClk         : in  sl;
    axiRst         : in  sl;
    axiReadMaster  : in  AxiLiteReadMasterType;
    axiReadSlave   : out AxiLiteReadSlaveType;
    axiWriteMaster : in  AxiLiteWriteMasterType;
    axiWriteSlave  : out AxiLiteWriteSlaveType
    );
end ttc_core;

architecture ttc_core_arch of ttc_core is

  component ttc_mmcm
    port
      (                                 -- Clock in ports
        clk_in1_p      : in  sl;
        clk_in1_n      : in  sl;
        -- Clock out ports
        clk_ttc40_out  : out sl;
        clk_ttc120_out : out sl;
        clk_ttc240_out : out sl;
        -- Dynamic phase shift ports
        psclk          : in  sl;
        psen           : in  sl;
        psincdec       : in  sl;
        psdone         : out sl;
        -- Status and control signals
        reset          : in  sl;
        locked         : out sl
        );
  end component;

  type TtcStatusType is record

    mmcm_locked : sl;
    bc0_locked  : sl;

    ttc_dec_err_cnt_sgl : slv(15 downto 0);
    ttc_dec_err_cnt_dbl : slv(15 downto 0);

    l1a_cnt       : slv(31 downto 0);
    bc0_cnt       : slv(31 downto 0);
    ec0_cnt       : slv(31 downto 0);
    resync_cnt    : slv(31 downto 0);
    oc0_cnt       : slv(31 downto 0);
    test_sync_cnt : slv(31 downto 0);
    start_cnt     : slv(31 downto 0);
    stop_cnt      : slv(31 downto 0);

  end record TtcStatusType;

  signal TtcStatus : TtcStatusType;



  type RegType is record

    mmcm_rst      : sl;
    bc0_stat_rst  : sl;
    axiReadSlave  : AxiLiteReadSlaveType;
    axiWriteSlave : AxiLiteWriteSlaveType;
  end record RegType;

  constant REG_INIT_C : RegType := (
    mmcm_rst      => '0',
    bc0_stat_rst  => '0',
    axiReadSlave  => AXI_LITE_READ_SLAVE_INIT_C,
    axiWriteSlave => AXI_LITE_WRITE_SLAVE_INIT_C);

  signal r   : RegType := REG_INIT_C;
  signal rin : RegType;

----
  signal s_clk_40  : sl;
  signal s_clk_120 : sl;
  signal s_clk_240 : sl;

  signal s_ttc_cmd : slv(7 downto 0);
  signal s_ttc_l1a : sl;

  signal s_local_timing_ref : t_timing_ref;

  signal s_l1a_cmd       : sl;
  signal s_bc0_cmd       : sl;
  signal s_ec0_cmd       : sl;
  signal s_resync_cmd    : sl;
  signal s_oc0_cmd       : sl;
  signal s_test_sync_cmd : sl;
  signal s_start_cmd     : sl;
  signal s_stop_cmd      : sl;

  constant C_NUM_OF_TTC_CMDS    : integer := 8;
  constant C_TTC_CMDS_CNT_WIDTH : integer := 32;

  signal ttc_cnt_sync : SlVectorArray(C_NUM_OF_TTC_CMDS-1 downto 0, C_TTC_CMDS_CNT_WIDTH-1 downto 0);
  signal ttc_cnt_rst  : sl;


  signal s_l1id_cnt  : slv(31 downto 0);
  signal s_orbit_cnt : slv(31 downto 0);

  signal s_bc0_stat     : t_bc0_stat;
  signal s_bc0_stat_rst : sl;

  signal s_mmcm_locked : sl;

  signal s_ttc_dec_err_cnt_rst : sl;
  signal s_ttc_dec_err_cnt_sgl : slv(15 downto 0);
  signal s_ttc_dec_err_cnt_dbl : slv(15 downto 0);


begin


  i_ctp7_ttc_clocks : ttc_mmcm
    port map (
      -- Clock in ports
      clk_in1_p      => clk_40_ttc_p_i,
      clk_in1_n      => clk_40_ttc_n_i,
      -- Clock out ports  
      clk_ttc40_out  => s_clk_40,
      clk_ttc120_out => s_clk_120,
      clk_ttc240_out => s_clk_240,
      -- Dynamic phase shift ports                 
      psclk          => axiClk,
      psen           => '0',
      psincdec       => '1',
      psdone         => open,
      -- Status and control signals                
      reset          => r.mmcm_rst,
      locked         => s_mmcm_locked
      );

  i_ttc_cmd : entity work.ttc_cmd
    port map(
      clk_40_i             => s_clk_40,
      ttc_data_p_i         => ttc_data_p_i,
      ttc_data_n_i         => ttc_data_n_i,
      ttc_cmd_o            => s_ttc_cmd,
      ttc_l1a_o            => s_ttc_l1a,
      tcc_err_cnt_rst_i    => s_ttc_dec_err_cnt_rst,
      ttc_err_single_cnt_o => s_ttc_dec_err_cnt_sgl,
      ttc_err_double_cnt_o => s_ttc_dec_err_cnt_dbl
      );

  i_local_timing_ref_gen : entity work.local_timing_ref_gen
    port map (
      clk_240_i          => s_clk_240,
      bc0_i              => s_bc0_cmd,
      bc0_stat_rst_i     => s_bc0_stat_rst,
      bc0_stat_o         => s_bc0_stat,
      local_timing_ref_o => s_local_timing_ref
      );

  process(s_clk_40) is
  begin
    if (rising_edge(s_clk_40)) then

      if (s_ttc_cmd = C_TTC_BGO_BC0) then s_bc0_cmd             <= '1'; else s_bc0_cmd <= '0'; end if;
      if (s_ttc_cmd = C_TTC_BGO_EC0) then s_ec0_cmd             <= '1'; else s_ec0_cmd <= '0'; end if;
      if (s_ttc_cmd = C_TTC_BGO_RESYNC) then s_resync_cmd       <= '1'; else s_resync_cmd <= '0'; end if;
      if (s_ttc_cmd = C_TTC_BGO_OC0) then s_oc0_cmd             <= '1'; else s_oc0_cmd <= '0'; end if;
      if (s_ttc_cmd = C_TTC_BGO_TEST_SYNC) then s_test_sync_cmd <= '1'; else s_test_sync_cmd <= '0'; end if;
      if (s_ttc_cmd = C_TTC_BGO_START) then s_start_cmd         <= '1'; else s_start_cmd <= '0'; end if;
      if (s_ttc_cmd = C_TTC_BGO_STOP) then s_stop_cmd           <= '1'; else s_stop_cmd <= '0'; end if;

      s_l1a_cmd <= s_ttc_l1a;

    end if;
  end process;

  process(s_clk_40) is
  begin
    if (rising_edge(s_clk_40)) then

      if (s_oc0_cmd = '1') then
        s_orbit_cnt <= (others => '0');
      elsif (s_bc0_cmd = '1') then
        s_orbit_cnt <= slv(unsigned(s_orbit_cnt) + 1);
      end if;

    end if;
  end process;

  process(s_clk_40) is
  begin
    if (rising_edge(s_clk_40)) then

      if (s_ec0_cmd = '1') then
        s_l1id_cnt <= (others => '0');
      elsif (s_l1a_cmd = '1') then
        s_l1id_cnt <= slv(unsigned(s_l1id_cnt) + 1);
      end if;

    end if;
  end process;



  comb : process (axiReadMaster, axiRst, axiWriteMaster, r, TtcStatus) is
    variable v      : RegType;
    variable axilEp : AxiLiteEndpointType;
  begin
    -- Latch the current value
    v := r;


    ------------------------      
    -- AXI-Lite Transactions
    ------------------------      

    -- Determine the transaction type
    axiSlaveWaitTxn(axilEp, axiWriteMaster, axiReadMaster, v.axiWriteSlave, v.axiReadSlave);

    axiSlaveRegisterR(axilEp, x"000", 0, TtcStatus.mmcm_locked);
    axiSlaveRegister(axilEp, x"004", 0, v.mmcm_rst);

    axiSlaveRegisterR(axilEp, x"008", 0, TtcStatus.bc0_locked);
    axiSlaveRegister(axilEp, x"00C", 0, v.bc0_stat_rst);

    axiSlaveRegisterR(axilEp, x"010", 0, TtcStatus.ttc_dec_err_cnt_sgl);
    axiSlaveRegisterR(axilEp, x"014", 0, TtcStatus.ttc_dec_err_cnt_dbl);

    axiSlaveRegisterR(axilEp, x"020", 0, TtcStatus.l1a_cnt);
    axiSlaveRegisterR(axilEp, x"024", 0, TtcStatus.bc0_cnt);
    axiSlaveRegisterR(axilEp, x"028", 0, TtcStatus.ec0_cnt);
    axiSlaveRegisterR(axilEp, x"02C", 0, TtcStatus.resync_cnt);
    axiSlaveRegisterR(axilEp, x"030", 0, TtcStatus.oc0_cnt);
    axiSlaveRegisterR(axilEp, x"034", 0, TtcStatus.test_sync_cnt);
    axiSlaveRegisterR(axilEp, x"038", 0, TtcStatus.start_cnt);
    axiSlaveRegisterR(axilEp, x"03C", 0, TtcStatus.stop_cnt);

    axiSlaveDefault(axilEp, v.axiWriteSlave, v.axiReadSlave, AXI_RESP_DECERR_C);

    --------
    -- Reset
    --------
    if (axiRst = '1') then
      v := REG_INIT_C;
    end if;

    -- Register the variable for next clock cycle
    rin <= v;

    -- Outputs 
    axiReadSlave  <= r.axiReadSlave;
    axiWriteSlave <= r.axiWriteSlave;

  end process comb;

  seq : process (axiClk) is
  begin
    if (rising_edge(axiClk)) then
      r <= rin after TPD_G;
    end if;
  end process seq;

  U_mmcm_locked_sync : entity work.Synchronizer

    port map (
      clk     => axiClk,
      rst     => axiRst,
      dataIn  => s_mmcm_locked,
      dataOut => TtcStatus.mmcm_locked
      );

  U_bc0_locked_sync : entity work.Synchronizer

    port map (
      clk     => axiClk,
      rst     => axiRst,
      dataIn  => s_bc0_stat.locked,
      dataOut => TtcStatus.bc0_locked
      );

  U_bc0_stat_rst_sync : entity work.Synchronizer

    port map (
      clk     => s_clk_240,
      rst     => '0',
      dataIn  => r.bc0_stat_rst,
      dataOut => s_bc0_stat_rst
      );

  U_sync_ttc_dec_errs : entity work.SynchronizerFifo
    generic map (
      TPD_G        => TPD_G,
      DATA_WIDTH_G => 32)
    port map (
      wr_clk            => s_clk_40,
      din(15 downto 0)  => s_ttc_dec_err_cnt_sgl,
      din(31 downto 16) => s_ttc_dec_err_cnt_dbl,

      rd_clk             => axiClk,
      dout(15 downto 0)  => TtcStatus.ttc_dec_err_cnt_sgl,
      dout(31 downto 16) => TtcStatus.ttc_dec_err_cnt_dbl
      );

  U_TtcCnts_SyncOneShotCntVec : entity work.SynchronizerOneShotCntVector
    generic map (
      TPD_G       => TPD_G,
      CNT_WIDTH_G => C_TTC_CMDS_CNT_WIDTH,
      WIDTH_G     => C_NUM_OF_TTC_CMDS)
    port map (
      -- Write Ports (wrClk domain)    
      dataIn(0) => s_l1a_cmd,
      dataIn(1) => s_bc0_cmd,
      dataIn(2) => s_ec0_cmd,
      dataIn(3) => s_resync_cmd,
      dataIn(4) => s_oc0_cmd,
      dataIn(5) => s_test_sync_cmd,
      dataIn(6) => s_start_cmd,
      dataIn(7) => s_stop_cmd,

      -- Read Ports (rdClk domain)    
      rollOverEn => (others => '1'),
      cntRst     => ttc_cnt_rst,
      dataOut    => open,
      cntOut     => ttc_cnt_sync,
      -- Clocks and Reset Ports
      wrClk      => s_clk_40,
      wrRst      => '0',
      rdClk      => axiClk,
      rdRst      => axiRst
      );

  TtcStatus.l1a_cnt       <= muxSlVectorArray(ttc_cnt_sync, 0);
  TtcStatus.bc0_cnt       <= muxSlVectorArray(ttc_cnt_sync, 1);
  TtcStatus.ec0_cnt       <= muxSlVectorArray(ttc_cnt_sync, 2);
  TtcStatus.resync_cnt    <= muxSlVectorArray(ttc_cnt_sync, 3);
  TtcStatus.oc0_cnt       <= muxSlVectorArray(ttc_cnt_sync, 4);
  TtcStatus.test_sync_cnt <= muxSlVectorArray(ttc_cnt_sync, 5);
  TtcStatus.start_cnt     <= muxSlVectorArray(ttc_cnt_sync, 6);
  TtcStatus.stop_cnt      <= muxSlVectorArray(ttc_cnt_sync, 7);

  ttc_daq_cntrs_o.orbit <= s_orbit_cnt;
  ttc_daq_cntrs_o.L1ID  <= s_l1id_cnt;

  ttc_cmds_o.l1a       <= s_l1a_cmd;
  ttc_cmds_o.bc0       <= s_bc0_cmd;
  ttc_cmds_o.resync    <= s_resync_cmd;
  ttc_cmds_o.start     <= s_start_cmd;
  ttc_cmds_o.stop      <= s_stop_cmd;
  ttc_cmds_o.ec0       <= s_ec0_cmd;
  ttc_cmds_o.test_sync <= s_test_sync_cmd;

  local_timing_ref_o <= s_local_timing_ref;

  clk_40_bufg_o  <= s_clk_40;
  clk_120_bufg_o <= s_clk_120;
  clk_240_bufg_o <= s_clk_240;

end architecture ttc_core_arch;
