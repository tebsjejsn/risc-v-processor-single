library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity main_dec is
    port(
        opcode     : in STD_LOGIC_VECTOR(6 downto 0);
        funct3     : in STD_LOGIC_VECTOR(2 downto 0);
        Zero       : in STD_LOGIC;
        PCSrc      : out STD_LOGIC_VECTOR(1 downto 0);
        RegWrite   : out STD_LOGIC;
        ImmSrc     : out STD_LOGIC_VECTOR(1 downto 0);
        ALUSrc     : out STD_LOGIC;
        ALUControl : out STD_LOGIC_VECTOR(2 downto 0);
        MemWrite   : out STD_LOGIC;
        ResultSrc  : out STD_LOGIC_VECTOR(1 downto 0)
    );
end entity main_dec;

architecture behavioural of main_dec is
begin
    process(all)
    begin
        case opcode is
            -- lw instruction
            when "0000011" => 
                PCSrc <= "00";
                RegWrite <= '1';
                ImmSrc <= "00";
                ALUSrc <= '1';
                MemWrite <= '0';
                ResultSrc <= "01";
            -- sw instruction
            when "0100011" =>
                PCSrc <= "00";
                RegWrite <= '0';
                ImmSrc <= "00";
                ALUSrc <= '1';
                MemWrite <= '1';
                ResultSrc <= "00";
            -- i-type instructions (addi, xori, ori, andi, slti)
            when "0010011" => 
                PCSrc <= "00";
                RegWrite <= '1';
                ImmSrc <= "00";
                ALUSrc <= '1';
                MemWrite <= '0';
                ResultSrc <= "00";
            -- b-type instructions (beq, bne)
            when "1100011" =>
                RegWrite <= '0';
                ImmSrc <= "01";
                ALUSrc <= '0';
                MemWrite <= '0';
                ResultSrc <= "00";

                case funct3 is
                    -- beq
                    when "000" =>
                        PCSrc <= '0' & Zero;
                    -- bne
                    when "001" =>
                        PCSrc <= '0' & (not Zero);
                end case;
            -- r-type instructions (add, sub, xor, or, and, slt)
            when "0110011" => 
                PCSrc <= "00";
                RegWrite <= '1';
                ImmSrc <= "00";
                ALUSrc <= '0';
                MemWrite <= '0';
                ResultSrc <= "00";
            -- jal
            when "1101111" =>
                RegWrite <= '1';
                ImmSrc <= "10";
                MemWrite <= '0';
                ResultSrc <= "10";
                PCSrc <= "01";
                ALUSrc <= '0';
            -- jalr
            when "1100111" =>
                RegWrite <= '1';
                ImmSrc <= "10";
                MemWrite <= '0';
                ResultSrc <= "10";
                PCSrc <= "10";
                ALUSrc <= '1';
        end case;
    end process;

end architecture behavioural;