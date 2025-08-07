library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity enable_gen is
    Port ( clkref : in  STD_LOGIC;
           rst    : in  STD_LOGIC;
           enable : out STD_LOGIC);
end enable_gen;

architecture Behavioral of enable_gen is
    constant EVAL_CYCLES : integer := 100; 
    signal counter : integer := 0;
    signal en : STD_LOGIC := '0';
begin
    process(clkref, rst)
    begin
        if rst = '1' then
            counter <= 0;
            en <= '0';
        elsif rising_edge(clkref) then
            if counter < EVAL_CYCLES then
                en <= '1';
                counter <= counter + 1;
            else
                en <= '0';
                counter <= 0;
            end if;
        end if;
    end process;
    enable <= en;
end Behavioral;
