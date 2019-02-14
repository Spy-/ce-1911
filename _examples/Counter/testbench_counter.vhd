library ieee;
use ieee.std_logic_1164.all;

entity testbench_counter is
end entity testbench_counter;

architecture dataflow of testbench_counter is

	signal CLK, U, CLR, LD: std_logic;
	signal Q: std_logic_vector(3 downto 0);
	signal SEGMENT: std_logic_vector(6 downto 0);

begin

	UUT: entity work.counter port map(
		U => U,
		CLK => CLK,
		LD => LD,
		CLR => CLR,
		Q => Q,
		SEGMENT => SEGMENT
	);
	
	clock: process
	begin
		CLK <= '0'; wait for 50ns;
		CLK <= '1'; wait for 50ns;
	end process clock;
	
	test: process
	begin
		CLR <= '1', '0' after 200ns;
		U <= '1', '0' after 2200ns;
		LD <= '1';
		wait;
	end process test;

end architecture dataflow;