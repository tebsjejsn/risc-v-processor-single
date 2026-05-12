library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD_UNSIGNED.all;

entity dmem is
    port(
        A : in STD_LOGIC_VECTOR(31 downto 0);
        wd : in STD_LOGIC_VECTOR(31 downto 0);
        clk : in STD_LOGIC;
        MemWrite : in STD_LOGIC;
        ReadData : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity dmem;

architecture behavioural of dmem is
    type ramtype is array (63 downto 0) of STD_LOGIC_VECTOR(31 downto 0);

    signal mem : ramtype := (others => (others => '0'));
begin
    -- can also do with loop and wait logic
    process(clk)
    begin
        if rising_edge(clk) then
            if MemWrite then
                mem(to_integer(a(7 downto 2))) <= wd;
            end if;
        end if;
    end process;

    ReadData <= mem(to_integer(a(7 downto 2)));

end architecture behavioural;
