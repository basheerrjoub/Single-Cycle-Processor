library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity RegisterFile is
    Port ( clk : in  STD_LOGIC;
           RegWr : in  STD_LOGIC;
           RA : in  STD_LOGIC_VECTOR (4 downto 0);
           RB : in  STD_LOGIC_VECTOR (4 downto 0);
           RW : in  STD_LOGIC_VECTOR (4 downto 0);
           BUSA : out  STD_LOGIC_VECTOR (31 downto 0);
           BUSB : out  STD_LOGIC_VECTOR (31 downto 0);
           BUSW : in  STD_LOGIC_VECTOR (31 downto 0));
end entity RegisterFile;

architecture Behavioral of RegisterFile is

type ram_type is array(0 to 31) of std_logic_vector(31 downto 0);
signal ram : ram_type;
begin

	process(clk)
	begin
		if(clk'event and clk='1') then
				if (RegWr='1') then
					ram(conv_integer(RW))<=BUSW;
				end if;
		end if;
	end process;

	process(Ra,RB)
	begin
		if( conv_integer(Ra)=0) then BUSA<=x"00000000";
		else BUSA<=ram(conv_integer(Ra));
		end if;
		if(conv_integer(RB)=0) then BUSB<=x"00000000";
		else BUSB<=ram(conv_integer(RB));
		end if;
	end process;

end Behavioral;
