library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity alu is
    port(
        SrcA       : in STD_LOGIC_VECTOR(31 downto 0);
        SrcB       : in STD_LOGIC_VECTOR(31 downto 0);
        ALUControl : in STD_LOGIC_VECTOR(2 downto 0);
        Zero       : out STD_LOGIC;
        ALUResult  : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity alu;

architecture behavioural of alu is
    signal A : signed(31 downto 0);
    signal B: signed(31 downto 0);
begin
    A <= signed(SrcA);
    B <= signed(SrcB);

    process(all) begin
        case ALUControl is
            when "000" =>
                ALUResult <= STD_LOGIC_VECTOR(A + B);
            when "001" =>
                ALUResult <= STD_LOGIC_VECTOR(A - B);
            when "010" =>
                ALUResult <= (others => '0');

                if (signed(SrcA) < signed(SrcB)) then
                    ALUResult(0) <= '1';
                end if;
            when "100" =>
                ALUResult <= SrcA xor SrcB;
            when "110" => 
                ALUResult <= SrcA or SrcB;
            when "111" => 
                ALUResult <= SrcA and SrcB;
            when others =>
                ALUResult <= (others => '0');
        end case;

        if ((A - B) = 0) then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
    end process;
end architecture behavioural;