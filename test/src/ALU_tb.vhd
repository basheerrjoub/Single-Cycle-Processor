library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.all;
use ieee.numeric_std.all;

entity ALU_tb is
end ALU_tb;

architecture Behavior of ALU_tb is
    signal a, b, rslt: std_logic_vector(31 downto 0);
    signal SHAMT: std_logic_vector(4 downto 0);
    signal ALUOP: std_logic_vector(2 downto 0);
    signal zero: std_logic;

    component ALU is
        Port (
            a : in std_logic_vector(31 downto 0);
            b : in std_logic_vector(31 downto 0);
            SHAMT : in std_logic_vector(4 downto 0);
            ALUOP : in std_logic_vector(2 downto 0);
            zero: out std_logic;
            rslt: out std_logic_vector(31 downto 0)
        );
    end component ALU;

begin
    DUT: ALU port map (
        a => a,
        b => b,
        SHAMT => SHAMT,
        ALUOP => ALUOP,
        zero => zero,
        rslt => rslt
    );

    tb: process
    begin
        -- Testing Shift Left
        a <= x"00000002";  -- 2 in hexadecimal
        SHAMT <= "00010";  -- Shift by 2
        ALUOP <= "100";    -- Shift Left operation
        wait for 10 ns;
        assert rslt = x"00000008" report "Shift Left failed" severity error;

        -- Testing Shift Right
        a <= x"00000008";  -- 8 in hexadecimal
        SHAMT <= "00010";  -- Shift by 2
        ALUOP <= "101";    -- Shift Right operation
        wait for 10 ns;
        assert rslt = x"00000002" report "Shift Right failed" severity error;

        wait;
    end process tb;

end Behavior;
