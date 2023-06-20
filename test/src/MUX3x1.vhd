library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX3x1 is
    Port ( sel : in  STD_LOGIC_VECTOR (1 downto 0);
           Zero : in  STD_LOGIC_VECTOR (31 downto 0);
           One : in  STD_LOGIC_VECTOR (31 downto 0);
		   Two : in  STD_LOGIC_VECTOR (31 downto 0);
           O : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX3x1;

architecture Behavioral of MUX3x1 is

begin

	O <= Zero when (sel="00") else
		 One  when (sel="01") else
		 Two  when (sel="10") else
		 Zero;


end Behavioral;
