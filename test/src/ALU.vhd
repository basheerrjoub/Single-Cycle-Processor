library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity ALU is
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUOP : in  STD_LOGIC_VECTOR (2 downto 0);
		  zero: out std_logic ;
           rslt : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

	signal	rslt_sub, rslt_and, rslt_add, tmp_res: std_logic_vector (31 downto 0):=x"00000000";

begin


	rslt_and <= a and b;
	rslt_add <= std_logic_vector(unsigned(a) + unsigned(b));
	rslt_sub <= std_logic_vector(unsigned(a) - unsigned(b));






     tmp_res <= rslt_and when (ALUOP = "010") else
		    rslt_add when (ALUOP = "000") else
        	    rslt_sub when (ALUOP = "001") else
             x"00000000";

	zero<=	'1' when (tmp_res=x"00000000") else '0';
	rslt<=tmp_res;
end Behavioral;
