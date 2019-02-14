library ieee;
use ieee.std_logic_1164.all;

entity reg4 is
	port(
		LD, CLR, CLK: in std_logic;
		D: in std_logic_vector(3 downto 0);
		Q: out std_logic_vector(3 downto 0)
	);
end entity reg4;

architecture behav of reg4 is

begin
	
	reg: process(all)
	begin
		
		if CLR = '1' then Q <= "0000";
		elsif rising_edge(CLK) then
			if LD = '1' then Q <= D;
			end if;
		end if;
	
	end process;

end architecture behav;