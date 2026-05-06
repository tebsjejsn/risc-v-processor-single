library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity datapath is 
    port(clk:       in STD_LOGIC;
        reset:      in STD_LOGIC;
        instr:      in STD_LOGIC_VECTOR(31 downto 0);
        PCSrc:      in STD_LOGIC;
        RegWrite:   in STD_LOGIC;
        ImmSrc:     in STD_LOGIC_VECTOR(1 downto 0);
        ALUSrc:     in STD_LOGIC;
        ALUControl: in STD_LOGIC_VECTOR(2 downto 0);
        ResultSrc:  in STD_LOGIC_VECTOR(1 downto 0);
        ALUResult:  buffer STD_LOGIC_VECTOR(31 downto 0);
        WriteData:  buffer STD_LOGIC_VECTOR(31 downto 0);
        PC:         buffer STD_LOGIC_VECTOR(31 downto 0);
        Zero:       out STD_LOGIC);
end entity datapath;

architecture struct of datapath is
    component mux2 is 
        generic(width: integer);
        port(d0: in STD_LOGIC_VECTOR(width-1 downto 0);
             d1: in STD_LOGIC_VECTOR(width-1 downto 0);
             s:  in STD_LOGIC;
             y:  out STD_LOGIC_VECTOR(width-1 downto 0));
    end component;

    component mux3 is
        generic(width: integer);
        port(d0: in STD_LOGIC_VECTOR(width-1 downto 0);
             d1: in STD_LOGIC_VECTOR(width-1 downto 0);
             d2: in STD_LOGIC_VECTOR(width-1 downto 0);
             s:  in STD_LOGIC_VECTOR(1 downto 0);
             y:  out STD_LOGIC_VECTOR(width-1 downto 0));
    end component;

    component flopr is
        port(clk:   in STD_LOGIC;
             reset: in STD_LOGIC;
             d:     in STD_LOGIC_VECTOR(31 downto 0);
             q:     out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    component adder is
        port(a: in STD_LOGIC_VECTOR(31 downto 0);
             b: in STD_LOGIC_VECTOR(31 downto 0);
             y: out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    component regfile is
        port(a1:  in STD_LOGIC_VECTOR(4 downto 0);
             a2:  in STD_LOGIC_VECTOR(4 downto 0);
             a3:  in STD_LOGIC_VECTOR(4 downto 0);
             wd3: in STD_LOGIC_VECTOR(31 downto 0);
             we3: in STD_LOGIC;
             rd1: out STD_LOGIC_VECTOR(31 downto 0);
             rd2: out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    component extend is
        port(instr:  in STD_LOGIC_VECTOR(31 downto 7);
             immsrc: in STD_LOGIC_VECTOR(1 downto 0);
             immext: out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    component alu is
        port(a: in STD_LOGIC_VECTOR(31 downto 0);
             b: in STD_LOGIC_VECTOR(31 downto 0);
             y: out STD_LOGIC_VECTOR(31 downto 0));
    end component;
begin
end architecture struct;
