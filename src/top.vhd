library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity top is
    port(
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        WriteData : buffer STD_LOGIC_VECTOR(31 downto 0);
        dataAdr : buffer STD_LOGIC_VECTOR(31 downto 0);
        MemWrite : buffer STD_LOGIC
    );
end entity top;

architecture struct of top is
    component riscvsingle is
        port(
            clk, reset : in STD_LOGIC;
            PC         : out STD_LOGIC_VECTOR(31 downto 0);
            instr      : in STD_LOGIC_VECTOR(31 downto 0);
            WriteData  : buffer STD_LOGIC_VECTOR(31 downto 0);
            ALUResult  : buffer STD_LOGIC_VECTOR(31 downto 0);
            ReadData   : in STD_LOGIC_VECTOR(31 downto 0);
            MemWrite   : buffer STD_LOGIC
        );
    end component;

    component imem is
        port(
            A  : in STD_LOGIC_VECTOR(31 downto 0);
            rd : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component dmem is
        port(
            A : in STD_LOGIC_VECTOR(31 downto 0);
            wd : in STD_LOGIC_VECTOR(31 downto 0);
            clk : in STD_LOGIC;
            MemWrite : in STD_LOGIC;
            ReadData : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    signal PC : STD_LOGIC_VECTOR(31 downto 0);
    signal instr : STD_LOGIC_VECTOR(31 downto 0);
    signal ReadData : STD_LOGIC_VECTOR(31 downto 0);
begin
    riscv : riscvsingle
        port map(
            clk       => clk,
            reset     => reset,
            PC        => PC,
            instr     => instr,
            WriteData => WriteData,
            ALUResult => dataAdr,
            ReadData  => ReadData,
            MemWrite  => MemWrite
        );

    imem1 : imem
        port map(
            A  => PC,
            rd => instr
        );

    dmem1 : dmem
        port map(
            A => dataAdr,
            wd => WriteData,
            clk => clk,
            MemWrite => MemWrite,
            ReadData => ReadData
        );
end architecture struct;