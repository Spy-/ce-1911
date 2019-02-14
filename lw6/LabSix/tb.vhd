library ieee;
use ieee.std_logic_1164.all;

entity tb is
end entity tb;

architecture behav of tb is

	signal CLK     : std_logic;
	signal RST     : std_logic;
	signal Quarter : std_logic;
	signal Pepsi   : std_logic;
	signal Water   : std_logic;
	signal VP      : std_logic;
	signal VW      : std_logic;
	signal HEX4		: std_logic_vector(6 downto 0);
	signal HEX3		: std_logic_vector(6 downto 0);
	signal HEX2		: std_logic_vector(6 downto 0);
	signal HEX1		: std_logic_vector(6 downto 0);
	signal HEX0		: std_logic_vector(6 downto 0);

begin

	UUT: entity work.lw6 port map(CLK     => CLK,
											RST     => RST,
											Quarter => Quarter,
											Pepsi   => Pepsi,
											Water   => Water,
											VP      => VP,
											VW      => VW,
											HEX4    => HEX4,
											HEX3    => HEX3,
											HEX2    => HEX2,
											HEX1    => HEX1,
											HEX0    => HEX0
										   );
											
	clock: process 
	begin 
		CLK <= '0'; wait for 500ms;
		CLK <= '1'; wait for 500ms;
	end process clock;
	
	reset: process
	begin
		RST <= '0', '1' after 2sec;
		wait;
	end process reset;	
	
	--QPW <= "000", "100" after 3s, "010" after 9s, "000" after 10s;	
	test1: process
	begin
		Quarter <= '0', '1' after 3sec, '0' after 9sec;
		Pepsi   <= '0', '1' after 9sec, '0' after 10sec;
		Water   <= '0';
		wait;
	end process test1;
	
	--QPW <= "000", "100" after 2sec, "010" after 3s, "100" after 4s, "001" after 5s, "100 after 6s, "001 after 7s;
--	test2: process
--	begin
--		Quarter <= '0', '1' after 2sec, '0' after 3sec, '1' after 4sec, '0' after 5sec, '1' after 6sec, '0' after 7sec;
--		Pepsi   <= '0', '1' after 3sec, '0' after 4sec;
--		Water   <= '0', '1' after 5sec, '0' after 6sec, '1' after 7sec;
--		wait;
--	end process test2;

	-- QPW <= "000", "100" after 2s, "011" after 3s, "100" after 10s, "011" after 11s; 
--	test3: process
--	begin
--		Quarter <= '0', '1' after 2sec, '0' after 3sec,  '1' after 10sec, '0' after 11sec;
--		Pepsi   <= '0', '1' after 3sec, '0' after 10sec, '1' after 11sec;
--		Water   <= '0', '1' after 3sec, '0' after 10sec, '1' after 11sec;
--		wait;
--	end process test3;

end architecture behav;