library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.all;
-- VHDL code for ALU of the MIPS Processor
entity ALU is
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUOP : in  STD_LOGIC_VECTOR (2 downto 0);
		   zero: out std_logic ;
           rslt : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

	signal	result: std_logic_vector (31 downto 0):=x"00000000";

begin
	process(ALUOP,a,b)
		begin
		 case ALUOP is
			 when "000" =>
			  result <= a + b; -- add
			 when "001" =>
			  result <= a - b; -- sub
			 when "010" =>
			  result <= a and b; -- and
			 when others => result <= x"00000000";
		 end case;
	end process;
	zero <= '1' when result=x"0000" else '0';
	rslt <= result;

end Behavioral;
