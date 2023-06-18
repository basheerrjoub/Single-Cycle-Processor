library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Instruction_Memory is
    port(Address	: in std_logic_vector(31 downto 0);
		Instr: out std_logic_vector(31 downto 0));
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is
	type mem is array(0 to 1024) of std_logic_vector(31 downto 0);
	constant code : mem:=(


	x"10020004",
	x"10020004",
	x"0000000A",

	others=> x"00000000");

begin

	process(Address)
	begin
		Instr<=code(conv_integer(unsigned(Address(15 downto 0))));
	end process;

end Behavioral;