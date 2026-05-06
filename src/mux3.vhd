library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux3 is
    generic(width: integer := 8);
    port(
        d0 : in STD_LOGIC_VECTOR(width-1 downto 0);
        d1 : in STD_LOGIC_VECTOR(width-1 downto 0);
        d2 : in STD_LOGIC_VECTOR(width-1 downto 0);
        s  : in STD_LOGIC_VECTOR(1 downto 0);
        y  : out STD_LOGIC_VECTOR(width-1 downto 0)
    );
end entity mux3;

architecture behavioural of mux3 is
begin
    process(all) begin
        case s is
            when "00" => y <= d0;
            when "01" => y <= d1;
            when "10" => y <= d2;
        end case;
    end process;
end architecture behavioural;