library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUControl is
    Port ( ALUType : in  STD_LOGIC_VECTOR (1 downto 0);
           Funct : in  STD_LOGIC_VECTOR (4 downto 0);
           ALUOP : out  STD_LOGIC_VECTOR (2 downto 0));
end ALUControl;

architecture Behavioral of ALUControl is

begin

	process(ALUType,Funct)
	begin
		case ALUType is
				when "11" => ALUOP <="010";
				when "01" => ALUOP <="110";
				--R Type: 00
				when others => case Funct is
								when "00000" => ALUOP <= "010"; --AND
								when "00001" => ALUOP <= "000"; --ADD
								when "00010" => ALUOP <= "001"; --SUB
								when "00011" => ALUOP <= "011"; --CMP
								when others => ALUOP <=   "---";
							  end case;
		end case;
	end process;

end Behavioral;