library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is
	port(
		A : in  std_logic_vector(7 downto 0);
		B : in  std_logic_vector(7 downto 0);
		S : in  std_logic_vector(2 downto 0);
		
		F : out std_logic_vector(7 downto 0)
	);
end entity alu;	

architecture dataflow of alu is

begin

	with S select F <=
		b"00000000" when b"000",
		b"00000001" when b"001",
		B - 1 		when b"010",
		A + B 		when b"011",
		A - B 		when b"100",
		A + A 		when b"101",
		A and B 		when b"110",
		A or B 		when others; 
		
end architecture dataflow;