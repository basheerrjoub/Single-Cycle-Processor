library IEEE;
use IEEE.std_logic_1164.all;

entity decoder2x4 is
	port (a: in std_logic_vector(1 downto 0);
	z: out std_logic_vector(3 downto 0));
end entity;

Architecture exp1 of decoder2x4 is
begin
	z <= "0001" when a = "00" else
		 "0010" when a = "01" else
	     "0100" when a = "10" else
		 "1000" when a = "11" else
		 "XXXX";
end architecture;