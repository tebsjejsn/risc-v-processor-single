library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity adder is
    port(
        a : in STD_LOGIC_VECTOR(31 downto 0);
        b : in STD_LOGIC_VECTOR(31 downto 0);
        y : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity adder;

architecture behavioural of adder is
begin
    y <= STD_LOGIC_VECTOR(signed(a) + signed(b));
end architecture behavioural;