library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PCControl is
    Port ( clk : in STD_LOGIC;
		  TypeCode : in  STD_LOGIC_VECTOR (1 downto 0);
           stop: in STD_LOGIC;
           ALUzero: in STD_LOGIC;
           Funct : in  STD_LOGIC_VECTOR (4 downto 0);
           stackWr, stackRd: out STD_LOGIC;
           PCSrc: out STD_LOGIC_VECTOR(1 downto 0));
end PCControl;

architecture Beh of PCControl is
    signal controls: std_logic_vector(5 downto 0);
    signal stop_delayed: STD_LOGIC; -- added new signal to hold the delayed stop signal
begin
    -- Delay logic
    process(clk)
    begin
        if rising_edge(clk) then
            stop_delayed <= stop;
        end if;
    end process;

    -- Original PCControl logic
    process(TypeCode,Funct, ALUzero, stop_delayed, clk)
    begin
        if stop_delayed = '1' then
            PCSrc <= "11";
            stackWr <= '0';
            stackRd <= '1';

        else
            case TypeCode is
                when "10" => case Funct is --I Types
                                when "00100" =>
                                    if ALUzero = '1' then --Check if ALUzero is 1
                                        PCSrc <= "10"; --BEQ
									stackWr <= '0';
                                    else
                                        PCSrc <= "00";
									stackWr <= '0';
                                    end if;
                                when others  => PCSrc<="00"; stackWr <= '0';
                            end case;
                when "01" => case Funct is --J Type
                                when "00000" => PCSrc<="01"; stackWr <= '0'; --J
                                when "00001" => PCSrc<="01"; --JAL  == J + push
                                        stackWr <= '1';
                                        stackRd <= '0';
                                when others  => PCSrc<="00";stackWr <= '0';
                            end case;
                when others => PCSrc<="00";stackWr <= '0';
            end case;
        end if;
    end process;

end Beh;
