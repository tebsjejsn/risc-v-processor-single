library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity alu_dec is
    port(
        funct3     : in STD_LOGIC_VECTOR(2 downto 0);
        funct7     : in STD_LOGIC_VECTOR(6 downto 0);
        opcode     : in STD_LOGIC_VECTOR(6 downto 0);
        ALUControl : out STD_LOGIC_VECTOR(2 downto 0)
    );
end entity alu_dec;

architecture behavioural of alu_dec is
begin
    process(all)
    begin
        case opcode is
            -- lw
            when "0000011" =>
                ALUControl <= "000";
            -- sw
            when "0100011" =>
                ALUControl <= "000";
            -- r-type
            when "0110011" =>
                case funct3 is
                    -- add/sub
                    when "000" =>
                        -- add
                        if (funct7 = "0000000") then
                            ALUControl <= "000";
                        -- sub
                        else
                            ALUControl <= "001";
                        end if;
                    -- xor
                    when "100" =>
                        ALUControl <= "100";
                    -- or
                    when "110" =>
                        ALUControl <= "110";
                    -- and
                    when "111" =>
                        ALUControl <= "111";
                    -- slt
                    when "010" =>
                        ALUControl <= "010";
                    when others =>
                        ALUControl <= "000";
                end case;
            -- i-type
            when "0010011" =>
                case funct3 is
                    -- addi
                    when "000" =>
                        ALUControl <= "000";
                    -- xori
                    when "100" =>
                        ALUControl <= "100";
                    -- ori
                    when "110" =>
                        ALUControl <= "110";
                    -- andi
                    when "111" =>
                        ALUControl <= "111";
                    -- slti
                    when "010" =>
                        ALUControl <= "010";
                    when others =>
                        ALUControl <= "000";
                end case;
            -- b-type
            when "1100011" =>
                ALUControl <= "001";
            -- jal
            when "1101111" =>
                ALUControl <= "000";
            -- jalr
            when "1100111" =>
                ALUControl <= "000";
            when others => 
                ALUControl <= "000";
        end case;
    end process;
end architecture behavioural;