library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BranchAdder is
    port (
        pc : in  std_logic_vector(31 downto 0);
        extend : in  std_logic_vector(31 downto 0);
        branchTarget : out std_logic_vector(31 downto 0)
    );
end entity BranchAdder;

architecture behavioral of BranchAdder is
begin
    process(pc, extend)
    begin
        branchTarget <= std_logic_vector(signed(pc) + signed(extend));
    end process;
end architecture behavioral;
