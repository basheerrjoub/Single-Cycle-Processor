-- File: Adder.vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder4 is
    Port (
        add_input: in std_logic_vector(29 downto 0);
        add_output: out std_logic_vector(31 downto 0)
    );
end Adder4;

architecture Behavioral of Adder4 is
begin
        -- Adding '00' to the 2 least significant bits after addition
        add_output <= std_logic_vector(signed(add_input) + 1) & "00";

end Behavioral;
