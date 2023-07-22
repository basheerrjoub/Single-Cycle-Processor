library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.all;
use ieee.numeric_std.all;

entity ALU is
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
		  b : in  STD_LOGIC_VECTOR (31 downto 0);
           SHAMT : in std_logic_vector(4 downto 0);
           ALUOP : in  STD_LOGIC_VECTOR (2 downto 0);
		  zero: out std_logic ;
           rslt : out  STD_LOGIC_VECTOR (31 downto 0);
           negative : out std_logic;
           carry : out std_logic);
end ALU;

architecture Behavioral of ALU is

	signal	result: std_logic_vector (31 downto 0):=x"00000000";
	signal  cmp_result: std_logic := '0';
    signal  carry_flag: std_logic := '0'; -- signal for carry flag
    signal  negative_flag: std_logic := '0'; -- signal for negative flag

begin
	process(ALUOP,a,b, SHAMT)
		begin
		 case ALUOP is
			 when "000" =>
                carry_flag <= '0';
                if unsigned(a) + unsigned(b) > x"FFFFFFFF" then
                    carry_flag <= '1';
                end if;
			 	result <= a + b; -- add
			 when "001" =>
                carry_flag <= '0';
                if unsigned(a) < unsigned(b) then
                    carry_flag <= '1';
                end if;
			  	result <= a - b; -- sub
			 when "010" =>
                carry_flag <= '0';
			 	result <= a and b; -- and
			 when "011" =>
                carry_flag <= '0';
				 if signed(a) < signed(b) then
				 	cmp_result <= '1'; -- cmp if a < b set cmp_result = 1
				else
					cmp_result <= '0';
				end if;
			 when "100" =>
                carry_flag <= '0';
			 	result <= std_logic_vector(signed(a) sll to_integer(unsigned(SHAMT))); --Shift Left
			 when "101" =>
                carry_flag <= '0';
			  	result <= std_logic_vector(signed(a) srl to_integer(unsigned(SHAMT))); --Shift Right
			 when others =>
                carry_flag <= '0';
                result <= x"00000000";
		 end case;

         -- Set negative flag
         if signed(result) < 0 then
             negative_flag <= '1';
         else
             negative_flag <= '0';
         end if;

	end process;

	zero <= '1' when result=x"00000000" or cmp_result = '1' else '0';
	rslt <= result;
    negative <= negative_flag; -- Set negative flag
    carry <= carry_flag; -- Set carry flag

end Behavioral;
