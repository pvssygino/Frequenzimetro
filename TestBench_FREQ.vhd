library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_freq_meter is
end tb_freq_meter;

architecture Behavioral of tb_freq_meter is

    signal clk1      : std_logic := '0';
    signal clkref    : std_logic := '0';
    signal rst       : std_logic := '1';
    signal count_out : std_logic_vector(15 downto 0);
    signal enable_sig: std_logic;

   
    component enable_gen
        Port (
            clkref : in  std_logic;
            rst    : in  std_logic;
            enable : out std_logic
        );
    end component;

    component freq_counter
        Port (
            clk1      : in  std_logic;
            rst       : in  std_logic;
            enable    : in  std_logic;
            count_out : out std_logic_vector(15 downto 0)
        );
    end component;

begin

    -- Clock clk1 a 500 MHz = periodo 2 ns
    clk1_process : process
    begin
        while true loop
            clk1 <= '0';
            wait for 1 ns;
            clk1 <= '1';
            wait for 1 ns;
        end loop;
    end process;

    -- Clock clkref a 1 GHz = periodo 1 ns
    clkref_process : process
    begin
        while true loop
            clkref <= '0';
            wait for 0.5 ns;
            clkref <= '1';
            wait for 0.5 ns;
        end loop;
    end process;

    -- Reset iniziale
    rst_process : process
    begin
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        wait;
    end process;

    -- Istanziazione dei componenti
    en_inst : enable_gen
        port map (
            clkref => clkref,
            rst    => rst,
            enable => enable_sig
        );

    fc_inst : freq_counter
        port map (
            clk1      => clk1,
            rst       => rst,
            enable    => enable_sig,
            count_out => count_out
        );

end Behavioral;
