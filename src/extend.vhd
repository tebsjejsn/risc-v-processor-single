library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity extend is
    port(
        instr   : in STD_LOGIC_VECTOR(31 downto 7);
        immtype : in STD_LOGIC_VECTOR(2 downto 0);
        immext  : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity;

architecture behavioural of extend is
begin
    process(all)
        variable imm12 : STD_LOGIC_VECTOR(11 downto 0);
        variable imm13 : STD_LOGIC_VECTOR(12 downto 0);
        variable imm21 : STD_LOGIC_VECTOR(20 downto 0);
    begin
        case immtype is
            when "000" =>
                immext <= (others => '0');
            when "001" =>
                imm12 := instr(31 downto 20);
                immext <= ((31 downto 12 => instr(31)) & imm12);
            when "010" =>
                imm12 := (instr(31 downto 25) & instr(11 downto 7));
                immext <= ((31 downto 12 => instr(31)) & imm12);
            when "011" =>
                imm13 := (instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0');
                immext <= ((31 downto 13 => instr(31)) & imm13);
            when "100" =>
                imm21 := (instr(31) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0');
                immext <= ((31 downto 21 => instr(31)) & imm21);
            when others =>
                immext <= (others => '0');
        end case;
    end process;
end architecture;