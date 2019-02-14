library ieee;
use ieee.std_logic_1164.all;

entity nsl is
	port(
		U: in std_logic;
		Q: in std_logic_vector(3 downto 0);
		D: out std_logic_vector(3 downto 0)
	);
end entity nsl;

architecture df of nsl is

signal input: std_logic_vector(4 downto 0);

begin

input <= U & Q;

with input select D <=
	"0000" when "00000", -- Count down
	"0000" when "00001",
	"0001" when "00010",
	"0010" when "00011",
	"0011" when "00100",
	"0100" when "00101",
	"0101" when "00110",
	"0110" when "00111",
	"0111" when "01000",
	"1000" when "01001",
	"1001" when "01010",
	"1010" when "01011",
	"1011" when "01100",
	"1100" when "01101",
	"1101" when "01110",
	"1110" when "01111",
	"0001" when "10000", -- Count up
	"0010" when "10001",
	"0011" when "10010",
	"0100" when "10011",
	"0101" when "10100",
	"0110" when "10101",
	"0111" when "10110",
	"1000" when "10111",
	"1001" when "11000",
	"1010" when "11001",
	"1011" when "11010",
	"1100" when "11011",
	"1101" when "11100",
	"1110" when "11101",
	"1111" when "11110",
	"1111" when "11111",
	"0000" when others;

		
end architecture df;