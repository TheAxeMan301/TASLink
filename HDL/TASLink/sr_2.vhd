----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:29:01 01/19/2016 
-- Design Name: 
-- Module Name:    shift_register - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shift_register2 is
    Port ( latch : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC;
           clk : in std_logic);
end shift_register2;

architecture Behavioral of shift_register2 is
  signal latched_data : std_logic_vector(7 downto 0) := "11111111";
  signal prev_clk : std_logic := '1';
  
  signal timer_active : std_logic := '0';
  signal timer : integer range 0 to 192 := 0;
begin
shift_out: process(clk)
  begin
    if (rising_edge(clk)) then
      if (latch = '1') then
        latched_data <= din;
      elsif (clock /= prev_clk and clock = '1') then
        if (timer_active = '0') then
          timer_active <= '1';
          timer <= 0;
        end if;
      end if;
      
      prev_clk <= clock;
      
      if (timer_active = '1') then
        if (timer = 192) then
          latched_data <= latched_data(6 downto 0) & '1';
          timer_active <= '0';
        else
          timer <= timer + 1;
        end if;
      end if;
    end if;
  end process;

dout <= latched_data(7);

end Behavioral;

