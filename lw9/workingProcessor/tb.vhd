library ieee;
use ieee.std_logic_1164.all;

entity tb is
end entity tb;

architecture behavioral of tb is

	signal CLK      :  std_logic;
	signal RST      :  std_logic;
	signal GO       :  std_logic;
	signal SLIDERS :  std_logic_vector(9 downto 0);
	signal SEG75,SEG74,SEG73,SEG72,SEG71,SEG70: std_logic_vector(7 downto 0);
	
begin

	UUT: entity work.lw9
		  port map(CLK=>CLK,RST=>RST,GO=>GO,SLIDERS=>SLIDERS,SEG75=>SEG75,SEG74=>SEG74,SEG73=>SEG73,SEG72=>SEG72,SEG71=>SEG71,SEG70=>SEG70); 
			  
	clock: process 
	begin 
		CLK <= '0'; wait for 500us;
		CLK <= '1'; wait for 500us;
	end process clock;
		
	tester : process
	begin 
		RST <= '1','0' after 1ms, '1' after 2ms;
		GO  <= '1','0' after 3ms, '1' after 4ms;
		wait; 
	end process tester;
	
	equation: process
	begin
		-- (8x+4y)   y=A x=8 (68)
--		SLIDERS <= b"0000000000",b"0010101000" after 2ms;
		-- (5x-y)    y=5 x=5 (14)
--		SLIDERS <= b"0000000000",b"0101010101" after 2ms;
		-- (12y+6)   y=F x=D (6A)
--		SLIDERS <= b"0000000000",b"1011111101" after 2ms;
		-- (2x+3y-2) y=2 x=3 (0A)
		SLIDERS <= b"0000000000",b"1100100011" after 2ms;
		wait;
	end process equation;

end architecture behavioral;