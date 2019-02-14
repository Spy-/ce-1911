library ieee;
use ieee.std_logic_1164.all;

entity tb is
end entity tb;

architecture behav of tb is

	signal w,x,y,z: std_logic;
	signal F,G,H  : std_logic;

begin

	UUT: entity work.pex1 port map(w=>w,x=>x,y=>y,z=>z,
											 F=>F,G=>G,H=>H);
											 
	test: process
	begin
	
		w <= '0'; wait for 50ns; w <= '1'; wait for 50ns;
	
	end process test;
	
	test2:process
	begin
		x <= '0', '1' after 50ns, '0' after 300ns;
		y <= '0', '1' after 200ns;
		wait;
	end process test2;

end architecture behav;