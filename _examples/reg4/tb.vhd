--testbench for REG4

library ieee;
use ieee.std_logic_1164.all;

entity tb is
end entity;

architecture behav of tb is

   signal CLK, CLR, LD: std_logic;
	signal Q,D: std_logic_vector(3 downto 0);
	

begin	

	UUT: entity work.REG4 port map(CLK=>CLK, CLR=>CLR, LD=>LD, Q=>Q, D=>D);
	
	clock: process
			begin
			CLK <= '0'; wait for 50ns;
			CLK <= '1'; wait for 50ns;
	end process clock;	
	test: process
	begin
		LD <= '1';
		CLR <= '1', '0' after 200ns;
		D <= "0000", "0001" after 300ns, "1000" after 400 ns; 
    	wait;
		
	end process test;	

end architecture;