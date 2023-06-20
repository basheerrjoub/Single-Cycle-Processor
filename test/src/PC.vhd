library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    Port (
		clk : in std_logic;
		reset : in  STD_LOGIC;
        data_in : in STD_LOGIC_VECTOR(31 downto 0);
        data_out : out std_logic_vector(31 downto 0)
    );
end entity PC;

architecture Behavioral of PC is
begin
    process(clk, reset)
    begin
		if(reset='1') then
				data_out <= (others=>'0');
        elsif rising_edge(clk) then
                data_out <= data_in;
        end if;
    end process;

end Behavioral;