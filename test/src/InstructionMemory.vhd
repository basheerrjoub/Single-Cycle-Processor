library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Instruction_Memory is
    port(
        Address: in std_logic_vector(31 downto 0);
        Instr: out std_logic_vector(31 downto 0)
    );
end Instruction_Memory;

architecture Behav of Instruction_Memory is
    -- Defining a 32-bit word ROM array of size 1024
    type ROM_Array is array (0 to 1023) of std_logic_vector(31 downto 0);


    constant MEM: ROM_Array := (
        X"1002000c",
        X"10020004",
        X"1002000c",
        X"00000012",
        X"00000003",
        X"00000004",
        X"00000005",
		others => X"00000000"
    );

begin
    process(Address)
    begin
        Instr <= MEM(conv_integer(Address(15 downto 2)));
    end process;
end Behav;
