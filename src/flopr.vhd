library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity flopr is
    port(
        clk   : in STD_LOGIC;
        reset : in STD_LOGIC;
        d     : in STD_LOGIC_VECTOR(31 downto 0);
        q     : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity flopr;

architecture behavioural of flopr is
begin
    process(clk, reset)
    begin
        if (rising_edge(clk)) then
            if (reset) then
                q <= (others => '0');
            else
                q <= d;
            end if;
        end if;
    end process;
end architecture behavioural;
