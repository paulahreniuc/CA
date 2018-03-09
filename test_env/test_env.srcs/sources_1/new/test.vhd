----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2018 05:52:44 PM
-- Design Name: 
-- Module Name: test - Behavioral
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

entity test is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           enable: in STD_LOGIC);
end test;

architecture Behavioral of test is
--MPG component
component mpg is
Port ( clk : in STD_LOGIC;
       btn : in STD_LOGIC;
       enable : out STD_LOGIC);
end component ;

-- DISPLAY
component display is
  Port ( clk: in std_logic;
         digit1: in std_logic_vector(3 downto 0);
         digit2: in std_logic_vector(3 downto 0);
         digit3: in std_logic_vector(3 downto 0);
         digit4: in std_logic_vector(3 downto 0);
         cat : out std_logic_vector(6 downto 0);
         an : out std_logic_vector(3 downto 0));
end  component;

signal cont: std_logic_vector(15 downto 0) :="0000000000000000";
signal en: std_logic;
signal qcat : std_logic_vector(6 downto 0);
signal qan : std_logic_vector(3 downto 0);
begin

u1: mpg port map (clk, btn(0), en);
u2: display port map (clk, cont(3 downto 0), cont(7 downto 4), cont(11 downto 8), cont(15 downto 12), qcat, qan);
process(clk, btn(0), sw(0))
begin

if (clk'event and clk = '1')then
      if(en = '1') then -- enable that will be connected to MPG
        if (sw(0) = '1') then 
            cont <= cont + 1;
         else 
            cont <= cont - 1;
         end if;
      end if;
end if;


end process;

led <= cont;
cat <= qcat;
an <= qan;
--led <= sw;
--an <= btn(3 downto 0);
--cat <= (others=>'0');

end Behavioral;
