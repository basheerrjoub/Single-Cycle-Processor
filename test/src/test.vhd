library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture tb of testbench is

    component processor is
        Port (clk: in STD_logic; reset: in  STD_LOGIC);
    end component;

    signal tb_clk: std_logic := '0';
    signal tb_reset: std_logic := '1';

    -- Define other signals if required

    constant clk_period: time := 10 ns;

begin
    -- Instantiate the device under test (DUT)
    DUT: processor port map (clk => tb_clk, reset => tb_reset);

    -- Clock generation process
    clk_process: process
    begin
        wait for clk_period/2;
        tb_clk <= not tb_clk;
    end process clk_process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Hold reset state for a while
        wait for clk_period * 10;
        tb_reset <= '0';

        -- Implement your test cases here

        -- Wait for everything to settle, then stop
        wait for clk_period * 100;
        assert false report "End of Test" severity failure;
    end process stimulus_process;

end tb;
