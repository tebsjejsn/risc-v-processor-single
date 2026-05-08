library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity datapath is 
    port(
        clk        : in STD_LOGIC;
        reset      : in STD_LOGIC;
        instr      : in STD_LOGIC_VECTOR(31 downto 0);
        ReadData   : in STD_LOGIC_VECTOR(31 downto 0);
        PCSrc      : in STD_LOGIC_VECTOR(1 downto 0);
        RegWrite   : in STD_LOGIC;
        ImmSrc     : in STD_LOGIC_VECTOR(1 downto 0);
        ALUSrc     : in STD_LOGIC;
        ALUControl : in STD_LOGIC_VECTOR(2 downto 0);
        ResultSrc  : in STD_LOGIC_VECTOR(1 downto 0);
        ALUResult  : buffer STD_LOGIC_VECTOR(31 downto 0);
        WriteData  : buffer STD_LOGIC_VECTOR(31 downto 0);
        PC         : buffer STD_LOGIC_VECTOR(31 downto 0);
        Zero       : out STD_LOGIC
    );
end entity datapath;

architecture struct of datapath is
    -- 2-way mux
    component mux2 is 
        generic(width: integer);
        port(
            d0 : in STD_LOGIC_VECTOR(width-1 downto 0);
            d1 : in STD_LOGIC_VECTOR(width-1 downto 0);
            s  : in STD_LOGIC;
            y  : out STD_LOGIC_VECTOR(width-1 downto 0));
    end component;
    -- 3-way mux
    component mux3 is
        generic(width: integer);
        port(
            d0 : in STD_LOGIC_VECTOR(width-1 downto 0);
            d1 : in STD_LOGIC_VECTOR(width-1 downto 0);
            d2 : in STD_LOGIC_VECTOR(width-1 downto 0);
            s  : in STD_LOGIC_VECTOR(1 downto 0);
            y  : out STD_LOGIC_VECTOR(width-1 downto 0));
    end component;
    -- Flip-flop with reset
    component flopr is
        port(
            clk   : in STD_LOGIC;
            reset : in STD_LOGIC;
            d     : in STD_LOGIC_VECTOR(31 downto 0);
            q     : out STD_LOGIC_VECTOR(31 downto 0));
    end component;
    -- Adder
    component adder is
        port(
            a : in STD_LOGIC_VECTOR(31 downto 0);
            b : in STD_LOGIC_VECTOR(31 downto 0);
            y : out STD_LOGIC_VECTOR(31 downto 0));
    end component;
    -- Register file with 2 read ports and 1 write port
    component regfile is
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
    end component;
    -- Immediate extend unit
    component extend is
        port(
            instr  : in STD_LOGIC_VECTOR(31 downto 7);
            immsrc : in STD_LOGIC_VECTOR(1 downto 0);
            immext : out STD_LOGIC_VECTOR(31 downto 0));
    end component;
    -- ALU
    component alu is
        port(
            srca       : in STD_LOGIC_VECTOR(31 downto 0);
            srcb       : in STD_LOGIC_VECTOR(31 downto 0);
            alucontrol : in STD_LOGIC_VECTOR(2 downto 0);
            Zero       : out STD_LOGIC;
            aluresult  : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- PC signals
    signal PCNext   : STD_LOGIC_VECTOR(31 downto 0);
    signal PCPlus4  : STD_LOGIC_VECTOR(31 downto 0);
    signal PCTarget : STD_LOGIC_VECTOR(31 downto 0);
    -- Extend unit signal
    signal ImmExt   : STD_LOGIC_VECTOR(31 downto 0);
    -- ALU signals
    signal SrcA     : STD_LOGIC_VECTOR(31 downto 0);
    signal SrcB     : STD_LOGIC_VECTOR(31 downto 0);
    -- Final mux signal
    signal Result   : STD_LOGIC_VECTOR(31 downto 0);
begin
    -- PC mux
    pcmux : mux3
        generic map(32) 
        port map(
            d0 => PCPlus4,
            d1 => PCTarget,
            d2 => ALUResult,
            s  => PCSrc,
            y  => PCNext
        );
    -- PC ff
    pcreg : flopr
        port map(
            clk   => clk,
            reset => reset,
            d     => PCNext,
            q     => PC
        );
    -- PC plus 4 adder
    pc4add : adder
        port map(
            a => PC,
            b => X"00000004",
            y => PCPlus4
        );
    -- Register file
    rf : regfile
        port map(
            clk => clk,
            a1  => instr(19 downto 15),
            a2  => instr(24 downto 20),
            a3  => instr(11 downto 7),
            wd3 => Result,
            we3 => RegWrite,
            rd1 => SrcA,
            rd2 => WriteData
        );
    -- ALU mux
    alumux : mux2
        generic map(32)
        port map(
            d0 => WriteData,
            d1 => ImmExt,
            s  => ALUSrc,
            y  => SrcB
        );
    -- ALU
    alumain : alu
        port map(
            srca => SrcA,
            srcb => SrcB,
            alucontrol => ALUControl,
            Zero => Zero,
            aluresult => ALUResult
        );
    -- Extend unit
    ext : extend
        port map(
            instr  => instr(31 downto 7),
            immsrc => ImmSrc,
            immext => ImmExt
        );
    -- PC target adder
    pctargetadd : adder
        port map(
            a => PC,
            b => ImmExt,
            y => PCTarget
        );
    -- Result mux
    resultmux : mux3
        generic map(32)
        port map(
            d0 => ALUResult,
            d1 => ReadData,
            d2 => PCPlus4,
            s  => ResultSrc,
            y  => Result
        );
end architecture struct;
