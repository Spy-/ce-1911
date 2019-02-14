library ieee;
use ieee.std_logic_1164.all;

entity MyBusMux is
	port(
		D3 : in std_logic_vector(3 downto 0);
		D2 : in std_logic_vector(3 downto 0);
		D1 : in std_logic_vector(3 downto 0);
		D0 : in std_logic_vector(7 downto 0);
		S  : in std_logic_vector(1 downto 0);
	
		Y : out std_logic_vector(7 downto 0)
	);
end entity MyBusMux;

architecture dataflow of MyBusMux is

begin

	with S select
	Y <= D0         when B"00",
		  b"0000"&D2 when b"10",
		  b"0000"&D1 when b"01",
		  b"0000"&D3 when others;

end architecture dataflow;