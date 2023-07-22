library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity RegisterFile_tb is
end RegisterFile_tb;

architecture behavior of RegisterFile_tb is

   -- Component Declaration for the Unit Under Test (UUT)
   component RegisterFile
   port(
        clk : in  std_logic;
        RegWr : in  std_logic;
        RA : in  std_logic_vector(4 downto 0);
        RB : in  std_logic_vector(4 downto 0);
        RW : in  std_logic_vector(4 downto 0);
        BUSA : out  std_logic_vector(31 downto 0);
        BUSB : out  std_logic_vector(31 downto 0);
        BUSW : in  std_logic_vector(31 downto 0)
        );
   end component;

   --Inputs
   signal clk : std_logic := '0';
   signal RegWr : std_logic := '0';
   signal RA : std_logic_vector(4 downto 0) := (others => '0');
   signal RB : std_logic_vector(4 downto 0) := (others => '0');
   signal RW : std_logic_vector(4 downto 0) := (others => '0');
   signal BUSW : std_logic_vector(31 downto 0) := (others => '0');

    --Outputs
   signal BUSA : std_logic_vector(31 downto 0);
   signal BUSB : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;

begin

   -- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile port map (
          clk => clk,
          RegWr => RegWr,
          RA => RA,
          RB => RB,
          RW => RW,
          BUSA => BUSA,
          BUSB => BUSB,
          BUSW => BUSW
        );

   -- Clock process definitions
   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;

      -- write data to registers
      RegWr <= '1';
      RW <= "00001";
      BUSW <= X"0000000A";
      wait for clk_period;

      RW <= "00010";
      BUSW <= X"00000014";
      wait for clk_period;

      -- read data from registers
      RegWr <= '0';
      RA <= "00001";
      RB <= "00010";
      wait for clk_period;

      -- Assert the final result
      assert (BUSA = X"0000000A" and BUSB = X"00000014") report "Test failed" severity error;

      -- done
      wait;
   end process;

end;
