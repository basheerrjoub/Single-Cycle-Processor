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

type registerFile is array(31 downto 0) of std_logic_vector(31 downto 0);
signal r : registerFile;
begin

	writeReg : process(clk, RW, RegWr)
            begin
                if rising_edge(clk) and RegWr = '1' then
                    case RW is
                        when "00001" =>
                            r(1) <= BUSW;
                        when "00010" =>
                            r(2) <= BUSW;
                        when "00011" =>
                            r(3) <= BUSW;
                        when "00100" =>
                            r(4) <= BUSW;
                        when "00101" =>
                            r(5) <= BUSW;
                        when "00110" =>
                            r(6) <= BUSW;
                        when "00111" =>
                            r(7) <= BUSW;
                        when "01000" =>
                            r(8) <= BUSW;
                        when "01001" =>
                            r(9) <= BUSW;
                        when "01010" =>
                            r(10) <= BUSW;
                        when "01011" =>
                            r(11) <= BUSW;
                        when "01100" =>
                            r(12) <= BUSW;
                        when "01101" =>
                            r(13) <= BUSW;
                        when "01110" =>
                            r(14) <= BUSW;
                        when "01111" =>
                            r(15) <= BUSW;
                        when "10000" =>
                            r(16) <= BUSW;
                        when "10001" =>
                            r(17) <= BUSW;
                        when "10010" =>
                            r(18) <= BUSW;
                        when "10011" =>
                            r(19) <= BUSW;
                        when "10100" =>
                            r(20) <= BUSW;
                        when "10101" =>
                            r(21) <= BUSW;
                        when "10110" =>
                            r(22) <= BUSW;
                        when "10111" =>
                            r(23) <= BUSW;
                        when "11000" =>
                            r(24) <= BUSW;
                        when "11001" =>
                            r(25) <= BUSW;
                        when "11010" =>
                            r(26) <= BUSW;
                        when "11110" =>
                            r(30) <= BUSW;
					  when "11111" =>    -- return address register
                            r(31) <= BUSW;
                        when others => null;
                    end case;
                end if;
        end process;

        readReg1 : process(clk, RA)
            begin
                case RA is
                    when "00000" =>
                        BUSA <= r(0);
                    when "00001" =>
                        BUSA <= r(1);
                    when "00010" =>
                        BUSA <= r(2);
                    when "00011" =>
                        BUSA <= r(3);
                    when "00100" =>
                        BUSA <= r(4);
                    when "00101" =>
                        BUSA <= r(5);
                    when "00110" =>
                        BUSA <= r(6);
                    when "00111" =>
                        BUSA <= r(7);
                    when "01000" =>
                        BUSA <= r(8);
                    when "01001" =>
                        BUSA <= r(9);
                    when "01010" =>
                        BUSA <= r(10);
                    when "01011" =>
                        BUSA <= r(11);
                    when "01100" =>
                        BUSA <= r(12);
                    when "01101" =>
                        BUSA <= r(13);
                    when "01110" =>
                        BUSA <= r(14);
                    when "01111" =>
                        BUSA <= r(15);
                    when "10000" =>
                        BUSA <= r(16);
                    when "10001" =>
                        BUSA <= r(17);
                    when "10010" =>
                        BUSA <= r(18);
                    when "10011" =>
                        BUSA <= r(19);
                    when "10100" =>
                        BUSA <= r(20);
                    when "10101" =>
                        BUSA <= r(21);
                    when "10110" =>
                        BUSA <= r(22);
                    when "10111" =>
                        BUSA <= r(23);
                    when "11000" =>
                        BUSA <= r(24);
                    when "11001" =>
                        BUSA <= r(25);
                    when "11010" =>
                        BUSA <= r(26);
                    when "11011" =>
                        BUSA <= r(27);
                    when "11100" =>
                        BUSA <= r(28);
                    when "11101" =>
                        BUSA <= r(29);
                    when "11110" =>
                        BUSA <= r(30);
                    when "11111" =>
                        BUSA <= r(31);
                    when others => null;
                end case;
        end process;

        readReg2 : process(clk, RB)
            begin
                case RB is
                    when "00000" =>
                        BUSB <= r(0);
                    when "00001" =>
                        BUSB <= r(1);
                    when "00010" =>
                        BUSB <= r(2);
                    when "00011" =>
                        BUSB <= r(3);
                    when "00100" =>
                        BUSB <= r(4);
                    when "00101" =>
                        BUSB <= r(5);
                    when "00110" =>
                        BUSB <= r(6);
                    when "00111" =>
                        BUSB <= r(7);
                    when "01000" =>
                        BUSB <= r(8);
                    when "01001" =>
                        BUSB <= r(9);
                    when "01010" =>
                        BUSB <= r(10);
                    when "01011" =>
                        BUSB <= r(11);
                    when "01100" =>
                        BUSB <= r(12);
                    when "01101" =>
                        BUSB <= r(13);
                    when "01110" =>
                        BUSB <= r(14);
                    when "01111" =>
                        BUSB <= r(15);
                    when "10000" =>
                        BUSB <= r(16);
                    when "10001" =>
                        BUSB <= r(17);
                    when "10010" =>
                        BUSB <= r(18);
                    when "10011" =>
                        BUSB <= r(19);
                    when "10100" =>
                        BUSB <= r(20);
                    when "10101" =>
                        BUSB <= r(21);
                    when "10110" =>
                        BUSB <= r(22);
                    when "10111" =>
                        BUSB <= r(23);
                    when "11000" =>
                        BUSB <= r(24);
                    when "11001" =>
                        BUSB <= r(25);
                    when "11010" =>
                        BUSB <= r(26);
                    when "11011" =>
                        BUSB <= r(27);
                    when "11100" =>
                        BUSB <= r(28);
                    when "11101" =>
                        BUSB <= r(29);
                    when "11110" =>
                        BUSB <= r(30);
                    when "11111" =>
                        BUSB <= r(31);
                    when others => null;
                end case;
        end process;

        r(0) <= X"00000000";   -- zero register
        r(29) <= X"000000FC";  -- stack pointer
end Behavioral;
