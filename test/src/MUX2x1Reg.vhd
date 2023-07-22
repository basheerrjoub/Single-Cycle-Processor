library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2x1Reg is
    Port ( sel : in  STD_LOGIC;
           A : in  STD_LOGIC_VECTOR (4 downto 0);
           B : in  STD_LOGIC_VECTOR (4 downto 0);
           O : out  STD_LOGIC_VECTOR (4 downto 0));
end MUX2x1Reg;

architecture Behavioral of MUX2x1Reg is

begin
	o <= 	a 	when sel='0' else b;

end Behavioral;
