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

signal cont: std_logic_vector(15 downto 0) := "0000000000000000";
signal en: std_logic;
signal qcat : std_logic_vector(6 downto 0);
signal qan : std_logic_vector(3 downto 0);
--signals for ALU
signal cont2: std_logic_vector(1 downto 0) := "00";
signal number1: std_logic_vector(15 downto 0) := "0000000000000000";
signal number2: std_logic_vector(15 downto 0) := "0000000000000000";
signal number3: std_logic_vector(15 downto 0) := "0000000000000000";
signal resultA: std_logic_vector(15 downto 0) := "0000000000000000";
signal resultS: std_logic_vector(15 downto 0) := "0000000000000000";
signal resultSHFr: std_logic_vector(15 downto 0) := "0000000000000000";
signal resultSHFl: std_logic_vector(15 downto 0) := "0000000000000000";
signal outmux: std_logic_vector(15 downto 0);
signal outzdet: std_logic;

begin

u1: mpg port map (clk, btn(0), en);
--u2: display port map (clk, cont(3 downto 0), cont(7 downto 4), cont(11 downto 8), cont(15 downto 12), qcat, qan); -- for counetr lab 1
u3: display port map (clk, outmux(3 downto 0), outmux(7 downto 4), outmux(11 downto 8), outmux(15 downto 12), qcat, qan);

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

-- ALU
--counter 2 bits
process(clk, en, btn(1))
begin 
if(clk'event and clk = '1') then
    if (en = '1') then
        cont2 <= cont2 + 1;
    end if;
end if;
end process;

--zero extend number1
process(sw)
begin
number1(3 downto 0) <= sw(3 downto 0);
end process;

--zero extend number2
process(sw)
begin
number2(3 downto 0) <= sw(7 downto 4);
end process;

--zero extend number3
process(sw)
begin
number3(7 downto 0) <= sw(7 downto 0);
end process;

--addition and substraction
process(number1, number2, cont2)
begin
    if(cont2 = "00") then
        resultA <= number1 + number2;
    end if;
    if (cont2 = "01") then
        resultS <= number1 - number2;
    end if;
end process;

--shift left/ shift right
process(number3, cont2)
begin
    if (cont2 = "10") then -- shift right
        resultSHFr(15 downto 0) <= "00" & number3(15 downto 2);
    end if;
    if (cont2 = "11") then --shift left
        resultSHFl(15 downto 0) <= number3(13 downto 0) & "00";
    end if;
end process;

--mux 
process (cont2, resultA, resultS, resultSHFr, resultSHFl)
begin
   case cont2 is
      when "00" => outmux <= resultA;
      when "01" => outmux <= resultS;
      when "10" => outmux <= resultSHFr;
      when "11" => outmux <= resultSHFl;
      when others => outmux <= "0000000000000000";
   end case;
end process;

--zero detector
process(outmux, outzdet)
begin
    outzdet <= outmux(0);
    for i in 1 to 15 loop
        outzdet <= outzdet nor outmux(i);
    end loop;
end process;

led(15) <= outzdet;

--led <= cont; -- output if we want to test onl the conter form lab 1
cat <= qcat;
an <= qan;

--firt ex of lab 1
--led <= sw;
--an <= btn(3 downto 0);
--cat <= (others=>'0');

end Behavioral;
