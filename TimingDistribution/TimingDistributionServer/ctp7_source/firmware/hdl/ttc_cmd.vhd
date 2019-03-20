
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.StdRtlPkg.all;

library unisim;
use unisim.VComponents.all;

--============================================================================
--                                                          Entity declaration
--============================================================================
entity ttc_cmd is
  port(
    clk_40_i : in sl;            -- Main TTC clock

    ttc_data_p_i : in sl;        -- TTC datastream from AMC13
    ttc_data_n_i : in sl;

    ttc_cmd_o : out slv(7 downto 0);  -- B-command output (zero if no command)
    ttc_l1a_o : out sl;          -- L1A output

    tcc_err_cnt_rst_i    : in  sl;  -- Err ctr reset
    ttc_err_single_cnt_o : out slv(15 downto 0);
    ttc_err_double_cnt_o : out slv(15 downto 0)
    );
end ttc_cmd;

--============================================================================
--                                                        Architecture section
--============================================================================
architecture ttc_cmd_arch of ttc_cmd is

--============================================================================
--                                                         Signal declarations
--============================================================================
  signal s_ttc_data_ibufds        : sl;
  signal s_ttc_data, s_ttc_data_d : slv(1 downto 0);

  signal s_ttc_stb : sl;
  signal s_ttc_cmd : slv(7 downto 0);

  signal s_ttc_l1a : sl;

  signal s_ttc_err_single, s_ttc_err_double         : sl;
  signal s_ttc_err_single_cnt, s_ttc_err_double_cnt : unsigned(15 downto 0);

--============================================================================
--                                                          Architecture begin
--============================================================================
begin

  i_bufds_fab_b : IBUFDS
    port map(
      i  => ttc_data_p_i,
      ib => ttc_data_n_i,
      o  => s_ttc_data_ibufds
      );

  i_ddr_ttc_data : IDDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE"
      )
    port map(
      q1 => s_ttc_data(0),
      q2 => s_ttc_data(1),
      c  => clk_40_i,
      ce => '1',
      d  => s_ttc_data_ibufds,
      r  => '0',
      s  => '0'
      );

  i_ttc_decoder : entity work.ttc_decoder
    port map(
      ttc_clk   => clk_40_i,
      ttc_data  => s_ttc_data,
      l1accept  => s_ttc_l1a,
      sinerrstr => s_ttc_err_single,
      dberrstr  => s_ttc_err_double,
      brcststr  => s_ttc_stb,
      brcst     => s_ttc_cmd
      );

  process(clk_40_i)
  begin
    if rising_edge(clk_40_i) then
      if tcc_err_cnt_rst_i = '1' then
        s_ttc_err_single_cnt <= (others => '0');
        s_ttc_err_double_cnt <= (others => '0');
      else
        if s_ttc_err_single = '1' and s_ttc_err_single_cnt /= X"ffff" then
          s_ttc_err_single_cnt <= s_ttc_err_single_cnt + 1;
        end if;
        if s_ttc_err_double = '1' and s_ttc_err_double_cnt /= X"ffff" then
          s_ttc_err_double_cnt <= s_ttc_err_double_cnt + 1;
        end if;
      end if;
    end if;
  end process;

  ----

  ttc_l1a_o <= s_ttc_l1a;
  ttc_cmd_o <= s_ttc_cmd when s_ttc_stb = '1' else X"00";

  ttc_err_single_cnt_o <= slv(s_ttc_err_single_cnt);
  ttc_err_double_cnt_o <= slv(s_ttc_err_double_cnt);

end ttc_cmd_arch;
--============================================================================
--                                                            Architecture end
--============================================================================
