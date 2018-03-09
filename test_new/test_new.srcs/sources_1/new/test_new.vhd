----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2018 11:28:22 PM
-- Design Name: 
-- Module Name: test_new - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_new is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (7 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_new;

architecture Behavioral of test_new is

component mpg2 is
Port ( clk : in STD_LOGIC;
       btn : in STD_LOGIC;
       enable : out STD_LOGIC);
end component;
signal en: std_logic;
signal count: std_logic_vector(2 downto 0);
signal output: std_logic_vector(7 downto 0);
begin
u1: mpg2 port map (clk, btn(0), en);

process (clk)
begin
   if clk='1' and clk'event then
      count <= count + 1;
   end if;
end process;


process(clk)
begin
   if ( clk'event and clk ='1') then
         case count is
            when "000" => output <= "00000001";
            when "001" => output <= "00000010";
            when "010" => output <= "00000100";
            when "011" => output <= "00001000";
            when "100" => output <= "00010000";
            when "101" => output <= "00100000";
            when "110" => output <= "01000000";
            when "111" => output <= "10000000";
            when others => output <= "00000000";
         end case;
      end if;
end process;

led <= output;

--process(clk )
--begin

--case output is 
--    when "00000000" => cat <="1111110";
--    when "00000001" => cat <="0110000";
--    when "00000010" => cat <="1101101";
--    when "00000011" => cat <="1111001";
--    when "00000100" => cat <="0010011";
--    when "00000101" => cat <="1011010";
--    when "00000110" => cat <="1011111";
--    when "00000111" => cat <="1110000";
--    when "00001000" => cat <="1111111";
--    when "00001001" => cat <="1111011";
--    when others => cat <= "0000000";
--end case;

end process;



end Behavioral;
