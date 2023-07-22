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
        X"08040024", --addi $0 $2 4
        X"08000022", --JAL 4 Jump to the function and push pc+4 to the stack
        X"0000000F", --After function
        X"0000000F",
        X"0000000F",
        X"0802000c", --addi $0 $1 1 --- start of the function
        X"00462000", --and $1 $3 $2
        X"20c0000c", --beq $3 $0 1
        X"0000000D", --Indicate ODD
        X"0000000E", --Indicate Even
        X"00000001", --Stop Bit just to pop the stack
        X"00000000",
		others => X"00000000"
    );

begin
    process(Address)
    begin
        Instr <= MEM(conv_integer(Address(15 downto 2)));
    end process;
end Behav;
