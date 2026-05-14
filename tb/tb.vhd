library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD_UNSIGNED.all;

entity tb is
end entity tb;

architecture sim of tb is
    component top is
        port(
            clk       : in STD_LOGIC;
            reset     : in STD_LOGIC;
            WriteData : buffer STD_LOGIC_VECTOR(31 downto 0);
            dataAdr   : buffer STD_LOGIC_VECTOR(31 downto 0);
            MemWrite  : buffer STD_LOGIC
        );
    end component;

    signal clk : STD_LOGIC;
    signal reset : STD_LOGIC;
    signal WriteData : STD_LOGIC_VECTOR(31 downto 0);
    signal dataAdr : STD_LOGIC_VECTOR(31 downto 0);
    signal MemWrite : STD_LOGIC;
begin
    dut : top
        port map(
            clk => clk,
            reset => reset,
            WriteData => WriteData,
            dataAdr => dataAdr,
            MemWrite => MemWrite
        );

    process begin
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;
    end process;

    process begin
        reset <= '1';
        wait for 22 ns;
        reset <= '0';
        wait;
    end process;

    process(clk) begin
        if (clk'event and clk = '0' and MemWrite = '1') then
            if (to_integer(dataAdr) = 100 and to_integer(WriteData) = 25) then
                report "NO ERROS: Simulation successful" severity failure;
            elsif (dataAdr /= 96) then
                report "Simulation Failed" severity failure;
            end if;
        end if;
    end process;
end architecture sim;