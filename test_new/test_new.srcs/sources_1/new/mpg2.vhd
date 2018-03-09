----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2018 09:44:59 PM
-- Design Name: 
-- Module Name: mpg - Behavioral
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

entity mpg2 is
--  Port ( );
Port ( clk : in STD_LOGIC;
       btn : in STD_LOGIC;
       enable : out STD_LOGIC);
end mpg2;

architecture Behavioral of mpg2 is
signal cont: std_logic_vector(15 downto 0);
signal tmp1 : std_logic;
signal tmp2 : std_logic;
signal tmp3 : std_logic;
signal qreg1: std_logic;
signal qreg2: std_logic;
signal qreg3: std_logic;
--signal enreg: std_logic;
begin

process (clk)
begin
   if clk ='1' and clk'event then
      cont <= cont + 1;
   end if;
end process;

process (clk)
    begin
        if (clk'event and clk='1') then
            if ( cont = "1111111111111111") then
                --for i in 0 to 14 loop
                --    tmp1(i+1) <= tmp1(i);
                --end loop;
                --tmp1(0) <= btn;
                tmp1 <= btn;
            end if;
        end if;
end process;

--qreg1 <= tmp1(15);
qreg1 <= tmp1;

process (clk)
    begin
        if (clk'event and clk='1') then
           -- for i in 0 to 14 loop
           --     tmp2(i+1) <= tmp2(i);
           -- end loop;
           -- tmp2(0) <= qreg1;
           tmp2 <= qreg1;
        end if;
end process;

--qreg2 <= tmp2(15);
qreg2 <= tmp2;

process (clk)
    begin
        if (clk'event and clk='1') then
            --for i in 0 to 14 loop
            --    tmp3(i+1) <= tmp3(i);
            --end loop;
            --tmp3(0) <= qreg2;
            tmp3 <= qreg2;
        end if;
end process;

--qreg3 <= tmp3(15);
qreg3 <= tmp3;
enable <= qreg2 and qreg3;			
					
end Behavioral;
