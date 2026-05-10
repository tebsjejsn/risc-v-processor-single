library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD_UNSIGNED.all;

entity regfile is
    port(
        clk : in STD_LOGIC;
        a1  : in STD_LOGIC_VECTOR(4 downto 0);
        a2  : in STD_LOGIC_VECTOR(4 downto 0);
        a3  : in STD_LOGIC_VECTOR(4 downto 0);
        wd3 : in STD_LOGIC_VECTOR(31 downto 0);
        we3 : in STD_LOGIC;
        rd1 : out STD_LOGIC_VECTOR(31 downto 0);
        rd2 : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity regfile;

architecture behavioural of regfile is
    type ramtype is array (31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);

    signal mem: ramtype;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if we3 then
                mem(to_integer(a3)) <= wd3;
            end if;
        end if;
    end process;

    process(a1, a2)
    begin
        if (to_integer(a1) = 0) then
            rd1 <= (others => '0');
        else 
            rd1 <= mem(to_integer(a1));
        end if;

        if (to_integer(a2) = 0) then
            rd2 <= (others => '0');
        else
            rd2 <= mem(to_integer(a2));
        end if;
    end process;
end architecture behavioural;
