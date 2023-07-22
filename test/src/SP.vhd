library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SP is
    Port ( clk : in  STD_LOGIC;
           write, read : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (31 downto 0);
           data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end SP;

architecture Behavioral of SP is
    type stack_array is array (0 to 31) of std_logic_vector (31 downto 0);
    signal stack : stack_array;
    signal stack_pointer : integer range 0 to 31 := 0; -- stack pointer
begin
    process(clk, write, read)
    begin

            if write = '1' then
                stack(stack_pointer) <= data_in;
                stack_pointer <= stack_pointer + 1;
            elsif read = '1' and stack_pointer > 0 then
                stack_pointer <= stack_pointer - 1;
                data_out <= stack(stack_pointer);
            elsif read = '1' and stack_pointer = 0 then
                data_out <= x"00000000"; --End Of Program
            end if;
    end process;
end Behavioral;
