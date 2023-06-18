library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Extender is
    Port ( din : in  STD_LOGIC_VECTOR (13 downto 0);
	       ExtOp: in STD_logic;
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Extender;

architecture Behavioral of Extender is
begin
	process(ExtOp, din)
	begin
		if ExtOp = '1' then
			if din(13) = '0' then
				dout <= "000000000000000000" & din;
			else
				dout <= "111111111111111111" & din;
			end if;
		else
			dout <= "000000000000000000" & din; -- Zero extension
		end if;
	end process;
end Behavioral;
