library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SLOWCLK is 
port(
	RST, CLK50MHZ: in std_logic;
	CLK1HZ: inout std_logic
);
end entity SLOWCLK;

architecture BEHAVIORAL of SLOWCLK is
	signal COUNT: integer;
	constant HALF: integer := 25000000;
	
begin

	UPDATE: process(RST, CLK50MHZ)
	begin
		if RST = '1' then COUNT <= 0; CLK1HZ <= '0';
		elsif rising_edge(CLK50MHZ) then COUNT <= COUNT + 1;
			if COUNT = HALF then CLK1HZ <= not CLK1HZ; COUNT <= 0;
			end if;
		end if;
	end process;

end architecture BEHAVIORAL;