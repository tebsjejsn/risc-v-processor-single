library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux2 is
    generic(width: integer := 8);
    port(
        d0 : in STD_LOGIC_VECTOR(width-1 downto 0);
        d1 : in STD_LOGIC_VECTOR(width-1 downto 0);
        s  : in STD_LOGIC;
        y  : out STD_LOGIC_VECTOR(width-1 downto 0)
    );
end entity mux2;

architecture behavioural of mux2 is
begin
    y <= d0 when s = '0' else d1;
end architecture behavioural;