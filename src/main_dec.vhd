library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity main_dec is
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
                ALUSrc <= '1';
                MemWrite <= '0';
                ResultSrc <= "01";
                ImmType <= "001";
            -- sw instruction
            when "0100011" =>
                PCSrc <= "00";
                RegWrite <= '0';
                ALUSrc <= '1';
                MemWrite <= '1';
                ResultSrc <= "00";
                ImmType <= "010";
            -- i-type instructions (addi, xori, ori, andi, slti)
            when "0010011" => 
                PCSrc <= "00";
                RegWrite <= '1';
                ALUSrc <= '1';
                MemWrite <= '0';
                ResultSrc <= "00";
                ImmType <= "001";
            -- b-type instructions (beq, bne)
            when "1100011" =>
                RegWrite <= '0';
                ALUSrc <= '0';
                MemWrite <= '0';
                ResultSrc <= "00";
                ImmType <= "011";

                case funct3 is
                    -- beq
                    when "000" =>
                        PCSrc <= '0' & Zero;
                    -- bne
                    when "001" =>
                        PCSrc <= '0' & (not Zero);
                    when others =>
                        PCSrc <= "00";
                end case;
            -- r-type instructions (add, sub, xor, or, and, slt)
            when "0110011" => 
                PCSrc <= "00";
                RegWrite <= '1';
                ALUSrc <= '0';
                MemWrite <= '0';
                ResultSrc <= "00";
                ImmType <= "000";
            -- jal
            when "1101111" =>
                RegWrite <= '1';
                MemWrite <= '0';
                ResultSrc <= "10";
                PCSrc <= "01";
                ALUSrc <= '0';
                ImmType <= "100";
            -- jalr
            when "1100111" =>
                RegWrite <= '1';
                MemWrite <= '0';
                ResultSrc <= "10";
                PCSrc <= "10";
                ALUSrc <= '1';
                ImmType <= "001";
            when others =>
                RegWrite <= '0';
                MemWrite <= '0';
                ResultSrc <= "00";
                PCSrc <= "00";
                ALUSrc <= '0';
                ImmType <= "000";
        end case;
    end process;

end architecture behavioural;