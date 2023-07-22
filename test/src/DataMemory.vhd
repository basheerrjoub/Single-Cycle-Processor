library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------------

entity DataMemory is
port(clk:		in std_logic;
	Read:		in std_logic;
	Write:		in std_logic;
    Address:    in std_logic_vector(31 downto 0);
	Data_in: 	in std_logic_vector(31 downto 0);
	Data_out: 	out std_logic_vector(31 downto 0)
);
end DataMemory;

--------------------------------------------------------------

architecture behav of DataMemory is



type mem is array (0 to 65535) of
	std_logic_vector(31 downto 0);
Signal code : mem:=(


	x"0000000A",
	x"0000000B",
	x"0000000C",

	others=> x"00000000");

begin

 writeMem : process(CLK, ADDRESS, Write, Data_in)
            begin
			 if rising_edge(CLK) and Write = '1' then
                code(conv_integer(Address(15 downto 0))) <= Data_in;
            end if;

	        end process;

 readMem : process(CLK, ADDRESS, Read)
            begin
                if Read = '1' then
                Data_out <= code(conv_integer(Address(15 downto 0)));
				end if;
           end process;



end behav;
----------------------------------------------------------------