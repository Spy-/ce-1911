library ieee;
use ieee.std_logic_1164.all;

entity reg4 is
port(CLK, CLR, LD: in std_logic;
	  D: in std_logic_vector(3 downto 0);
	  Q: out std_logic_vector(3 downto 0));
end entity reg4;

architecture behavioral of reg4 is 
begin 

	update: process(CLK, CLR, LD)
	begin
		if rising_edge(CLK) then
			if CLR = '1' then Q <= X"0";
			elsif LD = '1' then Q <= D;
			end if;
		end if;
	end process update;
	
end architecture behavioral;