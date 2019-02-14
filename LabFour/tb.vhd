library ieee;
use ieee.std_logic_1164.all;

entity tb is
end entity tb;

architecture dataflow of tb is

	signal CLK, RST: std_logic;
	signal Y: std_logic_vector(3 downto 0);

begin

	UUT: entity work.engine port map(CLK=>CLK,RST=>RST,Y=>Y);
	
	clock: process
		begin
		CLK <= '0'; wait for 10ns;
		CLK <= '1'; wait for 10ns;
	end process clock;
	
	test: process
	begin
	
		RST <= '0', '1' after 20ns;
		
		wait;
	
	end process test;

end architecture dataflow;