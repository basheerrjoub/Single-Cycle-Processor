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



type mem is array (0 to 4096) of
	std_logic_vector(31 downto 0);
Signal code : mem:=(


	x"0000000A",
	x"44444444",
	x"44444444",

	others=> x"00000000");

begin

    process(clk)
    begin
        if (rising_edge(clk)) then
            if Write='1' then
                code(conv_integer(Address(15 downto 0))) <= Data_in;
            end if;
            if Read='1' then
                Data_out <= code(conv_integer(Address(15 downto 0)));
            else
                Data_out <= (others => '0');
            end if;
        end if;
    end process;

end behav;
----------------------------------------------------------------