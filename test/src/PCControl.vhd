library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PCControl is
    Port ( TypeCode : in  STD_LOGIC_VECTOR (1 downto 0);
		  ALUzero: in STd_logic;
           Funct : in  STD_LOGIC_VECTOR (4 downto 0);
		  PCSrc: out STD_LOGIC_VECTOR(1 downto 0));
end PCControl;

--PCSRC
architecture Beh of PCControl is
signal controls: std_logic_vector(5 downto 0);
begin
	process(TypeCode,Funct, ALUzero)
		begin
		case TypeCode is
			when "10" => case Funct is --I Types
							when "00100" =>
								if ALUzero = '1' then --Check if ALUzero is 1
									PCSrc <= "10"; --BEQ
								else
									PCSrc <= "00";
								end if;
							when others  => PCSrc<="00";
						end case;
			when "01" => case Funct is --J Type
							when "00000" => PCSrc<="01"; --J
							when "00001" => PCSrc<="00"; --JAL
							when others  => PCSrc<="00";
						end case;
			when others => PCSrc<="00";
		end case;
	end process;

end Beh;
