library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity controller is
	port(
		CLK      : in  std_logic;
		RST      : in  std_logic;
		GO       : in  std_logic;
		FUNCSEL  : in  std_logic_vector(1 downto 0);
		
		MUXS     : out  std_logic_vector(1 downto 0);
		LDA      : out  std_logic;
		LDB      : out  std_logic;
		ALUS     : out  std_logic_vector(2 downto 0);
		DISPSEL  : out  std_logic_vector(2 downto 0)
	);
end entity controller;

architecture behavioral of controller is

	signal q : std_logic_vector(4 downto 0);

begin

	calc: process(RST, CLK, GO, FUNCSEL) 
	begin 
		if falling_edge(clk) then 
			if rst = '0' then q <= B"00000";
			elsif q = B"00000" then q <= B"00001";
			elsif q = B"01000" then q <= B"01000"; -- saturate first calc
			elsif q = B"01111" then q <= B"01111"; -- saturate second calc
			elsif q = B"10111" then q <= B"10111"; -- saturate third calc
			elsif q = B"11111" then q <= B"11111"; -- saturate first calc
			elsif q = B"00001" then 
				if GO = '1' then q <= B"00001"; -- saturate in reset
				elsif GO = '0' and FUNCSEL = "00" then q <= B"00010"; -- begin calculation
				elsif GO = '0' and FUNCSEL = "01" then q <= B"01001"; -- begin calculation
				elsif GO = '0' and FUNCSEL = "10" then q <= B"10000"; -- begin calculation
				elsif GO = '0' and FUNCSEL = "11" then q <= B"11000"; -- begin calculation
				end if;
			else q <= q+1;
			end if;
		end if;
	end process calc;
			 
	-- output multiplexars 
	with q select 
	LDA <= '1' when B"00100"|B"01000"|B"01101"|B"01110"|B"01111"|B"10111"|B"11010"|B"11110"|B"11111"|B"11100"|B"11101",
			 '0' when others;
		  
	with q select 
	LDB <= '1' when B"00011"|B"01000"|B"01010"|B"01011"|B"01100"|B"01111"|B"10010"|B"10101"|B"10111"|B"11001"|B"11011"|B"11111",
			 '0' when others;
		  
	with q select 
	ALUS <= B"000" when B"00010"|B"00100"|B"01000"|B"01001"|B"01101"|B"01111"|B"10000"|B"10111"|B"11000"|B"11011"|B"11111",
	        B"101" when B"01011"|B"11010",
		     B"100" when B"01110",
			  B"001" when B"10010",
			  B"010" when B"11001",
		     B"011" when others;
			  
	with q select 
	MUXS <= B"10" when B"00010"|B"01001"|B"11000",
	        B"11" when B"00100"|B"01101"|B"10000"|B"11011",  
		     B"00" when others;
			  
	with q select 
	DISPSEL <= B"000" when B"00000",
	           B"001" when B"00001",
				  B"010" when others;

end architecture behavioral;