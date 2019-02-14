library ieee;
use ieee.std_logic_1164.all;

entity testbench_traffic is 
end entity testbench_traffic;

architecture dataflow of testbench_traffic is 

	signal CLK, RST: std_logic; 
	signal LEDS: std_logic_vector(5 downto 0);
	signal SEG7: std_logic_vector(13 downto 0);
	
begin 

		UUT: entity work.traffic
			  port map(CLK=>CLK,RST=>RST,LEDs=>LEDS,SEG7=>SEG7); 
			 
		clock: process 
		begin 
			CLK <= '0'; wait for 20ns;
			CLK <= '1'; wait for 20ns;
		end process clock;
		
		tester : process
		begin 
			RST <= '0', '1' after 80ns;
			wait;
		end process tester;
		
end architecture dataflow;