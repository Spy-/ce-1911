library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity reg8 is 
	port(
		D   : in std_logic_vector(7 downto 0);
		LD  : in std_logic;
		RST : in std_logic;
		CLK : in std_logic;
		
		Q : out std_logic_vector(7 downto 0)
	);
end entity reg8;	

architecture behavioral of reg8 is

begin

	reg: process(RST, CLK, LD)
	begin
		
		if rising_edge(CLK) then
			if RST = '0' then Q <= b"00000000";
			elsif LD = '0' then
				Q <= D;
			end if;
		end if;	
		
	end process reg;
	
end architecture behavioral;