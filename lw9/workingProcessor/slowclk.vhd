library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity slowClk is 
	port(  
		CLK: in std_logic;
		CLK1HZ: inout std_logic
	);
end entity SlowClk;

architecture BEHAVIORAL of slowClk is 
	signal cnt: integer range 0 to 25000000;
	
begin 

	slow: process(all)
	begin	
		if rising_edge(clk) then 
			cnt <= cnt+1;
			if cnt = 25000000 then 
				clk1Hz <= not clk1Hz;
				cnt<=0;
			end if;
		end if;
	end process;
	
end architecture BEHAVIORAL;