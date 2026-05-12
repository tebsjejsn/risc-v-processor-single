library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity riscvsingle is
    port(
        clk, reset : in STD_LOGIC;
        PC         : out STD_LOGIC_VECTOR(31 downto 0);
        instr      : in STD_LOGIC_VECTOR(31 downto 0);
        WriteData  : buffer STD_LOGIC_VECTOR(31 downto 0);
        ALUResult  : buffer STD_LOGIC_VECTOR(31 downto 0);
        ReadData   : in STD_LOGIC_VECTOR(31 downto 0);
        MemWrite   : out STD_LOGIC
    );
end entity riscvsingle;

architecture struct of riscvsingle is
    component datapath is
        port(
            clk        : in STD_LOGIC;
            reset      : in STD_LOGIC;
            instr      : in STD_LOGIC_VECTOR(31 downto 0);
            ReadData   : in STD_LOGIC_VECTOR(31 downto 0);
            PCSrc      : in STD_LOGIC_VECTOR(1 downto 0);
            RegWrite   : in STD_LOGIC;
            ImmType    : in STD_LOGIC_VECTOR(2 downto 0);
            ALUSrc     : in STD_LOGIC;
            ALUControl : in STD_LOGIC_VECTOR(2 downto 0);
            ResultSrc  : in STD_LOGIC_VECTOR(1 downto 0);
            ALUResult  : buffer STD_LOGIC_VECTOR(31 downto 0);
            WriteData  : buffer STD_LOGIC_VECTOR(31 downto 0);
            PC         : buffer STD_LOGIC_VECTOR(31 downto 0);
            Zero       : out STD_LOGIC
        );
    end component;
    
    component main_dec is
        port(
            opcode    : in STD_LOGIC_VECTOR(6 downto 0);
            funct3    : in STD_LOGIC_VECTOR(2 downto 0);
            Zero      : in STD_LOGIC;
            PCSrc     : out STD_LOGIC_VECTOR(1 downto 0);
            RegWrite  : out STD_LOGIC;
            ALUSrc    : out STD_LOGIC;
            MemWrite  : out STD_LOGIC;
            ResultSrc : out STD_LOGIC_VECTOR(1 downto 0);
            ImmType   : out STD_LOGIC_VECTOR(2 downto 0) 
        );
    end component;

    component alu_dec is
        port(
            funct3     : in STD_LOGIC_VECTOR(2 downto 0);
            funct7     : in STD_LOGIC_VECTOR(6 downto 0);
            opcode     : in STD_LOGIC_VECTOR(6 downto 0);
            ALUControl : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    signal PCSrc      : STD_LOGIC_VECTOR(1 downto 0);
    signal RegWrite   : STD_LOGIC;
    signal ImmType    : STD_LOGIC_VECTOR(2 downto 0);
    signal ALUSrc     : STD_LOGIC;
    signal ALUControl : STD_LOGIC_VECTOR(2 downto 0);
    signal Zero       : STD_LOGIC;
    signal ResultSrc  : STD_LOGIC_VECTOR(1 downto 0);
begin
    dp : datapath
        port map(
            clk => clk,
            reset => reset,
            instr => instr,
            ReadData => ReadData,
            PCSrc => PCSrc,
            RegWrite => RegWrite,
            ImmType => ImmType,
            ALUSrc => ALUSrc,
            ALUControl => ALUControl,
            ResultSrc => ResultSrc,
            ALUResult => ALUResult,
            WriteData => WriteData,
            PC => PC,
            Zero => Zero
         );

    m_dec : main_dec
        port map(
            opcode => instr(6 downto 0),
            funct3 => instr(14 downto 12),
            Zero => Zero,
            PCSrc => PCSrc,
            ALUSrc => ALUSrc,
            RegWrite => RegWrite,
            MemWrite => MemWrite,
            ResultSrc => ResultSrc,
            ImmType => ImmType
        );

    a_dec : alu_dec
        port map(
            funct3 => instr(14 downto 12),
            funct7 => instr(31 downto 25),
            opcode => instr(6 downto 0),
            ALUControl => ALUControl
        );
end architecture struct;
