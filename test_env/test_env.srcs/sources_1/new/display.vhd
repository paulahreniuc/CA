----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2018 04:27:29 PM
-- Design Name: 
-- Module Name: display - Behavioral
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

entity display is
  Port ( clk: in std_logic;
         digit1: in std_logic_vector(3 downto 0);
         digit2: in std_logic_vector(3 downto 0);
         digit3: in std_logic_vector(3 downto 0);
         digit4: in std_logic_vector(3 downto 0);
         cat : out std_logic_vector(6 downto 0);
         an : out std_logic_vector(3 downto 0));
end display;

architecture Behavioral of display is
signal muxout: std_logic_vector(3 downto 0);
signal count: std_logic_vector(15 downto 0);
signal sel: std_logic_vector(1 downto 0);
signal anout: std_logic_vector(3 downto 0);
signal catout: std_logic_vector(6 downto 0);

begin
--counter
process (clk)
    begin
        if (clk'event and clk='1') then
          count <= count +1;
         end if;
end process;
sel <= count(15 downto 14);    

--the mux in the upper part of the figure   
process (sel,digit1,digit2,digit3,digit4)
begin
   case sel is
      when "00" => muxout <= digit1;
      when "01" => muxout <= digit2;
      when "10" => muxout <= digit3;
      when "11" => muxout <= digit4;
      when others => muxout <= "0000";
   end case;
end process;

--the mux in the lower part of the figure

process (sel,digit1,digit2,digit3,digit4)
begin
   case sel is
      when "00" => anout <= "1110";
      when "01" => anout <= "1101";
      when "10" => anout <= "1011";
      when "11" => anout <= "0111";
      when others => anout <= "0000";
   end case;
end process;
an <= anout;

--hex to 7 segment display
process(clk)
begin
if ( clk'event and clk ='1') then
    case muxout is
            when "0001" => catout <= "1111001";--1
            when "0010" => catout <= "0100100";--2
            when "0011" => catout <= "0110000";--3
            when "0100" => catout <= "0011001";--4
            when "0101" => catout <= "0010010";--5
            when "0110" => catout <= "0000010";--6
            when "0111" => catout <= "1111000";--7
            when "1000" => catout <= "0000000";--8
            when "1001" => catout <= "0010000";--9
            when "1010" => catout <= "0001000";--A
            when "1011" => catout <= "0000011";--B
            when "1100" => catout <= "1000110";--C
            when "1101" => catout <= "0100001";--D
            when "1110" => catout <= "0000110";--E
            when "1111" => catout <= "0001110";--F
            when others => catout <= "1000000";
    end case;
end if;
end process;
cat <= catout;

end Behavioral;
