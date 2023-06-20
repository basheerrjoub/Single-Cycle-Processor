library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MainControl is
    Port ( TypeCode : in  STD_LOGIC_VECTOR (1 downto 0);
           Funct : in  STD_LOGIC_VECTOR (4 downto 0);
           RegWr, EXTOP, ALUSrc, MemRd, MemWr, WBdata : out  std_logic);
end MainControl;
-------------------------------------------------------------------
--RegWr   EXTOP   ALUSrc   MemRd   MemWr   WBdata
--  5       4       3        2       1        0
-------------------------------------------------------------------

architecture MainControl of MainControl is
signal controls: std_logic_vector(5 downto 0);
begin
	process(TypeCode,Funct)
		begin
		case TypeCode is
			when "00" => case Funct is --R Type
							when "00000" => controls <= "100000"; --AND
							when "00001" => controls <= "100000"; --ADD
							when "00010" => controls <= "100000"; --SUB
							when "00011" => controls <= "100000"; --CMP
							when others   => controls <= "------";
						end case;
			when "10" => case Funct is --I Types
							when "00000" => controls <= "101000"; --ANDI
							when "00001" => controls <= "111000"; --ADDI
							when "00010" => controls <= "101101"; --LW
							when "00011" => controls <= "001010"; --SW
							when "00100" => controls <= "010000"; --BEQ
							when others  => controls <= "------";
						end case;
			when "01" => case Funct is --J Type
							when "00000" => controls <= "000000"; --J
							when "00001" => controls <= "000000"; --JAL
							when others   => controls <= "------";
						end case;
			when "11" => case Funct is --S Type
							when "00000" => controls <= "100000"; --SLL
							when "00001" => controls <= "100000"; --SLR
							when "00010" => controls <= "100000"; --SLLV
							when "00011" => controls <= "100000"; --SLRV
							when others   => controls <= "------";
						end case;
			when others   => controls <= "------";
		end case;
	end process;

	WBdata	<=controls(0);
	MemWr	<=controls(1);
	MemRd	<=controls(2);
	ALUSrc	<=controls(3);
	EXTOP	<=controls(4);
	RegWr	<=controls(5);

end MainControl;
