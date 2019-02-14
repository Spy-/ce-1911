-- example of a process

library ieee;
use ieee.std_logic_1164.all;

entity pex1 is
	port(
		w,x,y,z: in std_logic;
		F,G,H  : out std_logic
	);
end entity pex1;

architecture behav of pex1 is
begin
	
	F <= x;
	
	p1: process(all)
	begin
	
		G <= x;
		G <= w;
	
	end process p1;
	
	p2: process(all)
	begin
	
		H <= x;
	
	end process;
	
end;