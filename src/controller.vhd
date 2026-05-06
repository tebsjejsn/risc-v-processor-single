library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity controller is
    port(
        opcode: in STD_LOGIC_VECTOR(6 downto 0);
        funct3: in STD_LOGIC_VECTOR(2 downto 0);
        Zero: in STD_LOGIC;
        PCSrc: out STD_LOGIC;
        RegWrite: out STD_LOGIC;
        ImmSrc: out STD_LOGIC_VECTOR(1 downto 0);
        ALUSrc: out STD_LOGIC;
        ALUControl: out STD_LOGIC_VECTOR(2 downto 0);
        MemWrite: out STD_LOGIC;
        ResultSrc: out STD_LOGIC_VECTOR(1 downto 0)
    );
end entity controller;

architecture behavioural of controller is
begin
    process(all)
    begin
        if (opcode /= (others => '0')) then
            -- regular instructions
            case opcode is
                -- lw instruction
                when "0000011" => 
                    PCSrc <= '0';
                    RegWrite <= '1';
                    ImmSrc <= "00";
                    ALUSrc <= '1';
                    -- ALUControl    COMPLETE AFTER ALU
                    MemWrite <= '0';
                    ResultSrc <= "01";
                -- sw instruction
                when "0100011" =>
                    PCSrc <= '0';
                    RegWrite <= '0';
                    ImmSrc <= "00";
                    ALUSrc <= '1';
                    -- ALUControl    COMPLETE AFTER ALU
                    MemWrite <= '1';
                    ResultSrc <= "00";
            end case;
        else
            -- r-type instructions
            case funct3 is
            end case;
        end if;
    end process;
end architecture behavioural;