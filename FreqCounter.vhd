library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity freq_counter is
    Port ( clk1      : in  STD_LOGIC;
           rst       : in  STD_LOGIC;
           enable    : in  STD_LOGIC;
           count_out : out STD_LOGIC_VECTOR(15 downto 0));
end freq_counter;

architecture Behavioral of freq_counter is
    signal count      : unsigned(15 downto 0) := (others => '0');
    signal result     : unsigned(15 downto 0) := (others => '0');
    signal prev_en    : STD_LOGIC := '0';
begin
    process(clk1, rst)
    begin
        if rst = '1' then
            count <= (others => '0');
            result <= (others => '0');
        elsif rising_edge(clk1) then
            if enable = '1' then
                count <= count + 1;
            elsif enable = '0' and prev_en = '1' then
                result <= count;
                count <= (others => '0');
            end if;
            prev_en <= enable;
        end if;
    end process;
    count_out <= std_logic_vector(result);
end Behavioral;
