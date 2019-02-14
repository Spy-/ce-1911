library ieee;
use ieee.std_logic_1164.all;

entity testbench_reg4 is
end entity testbench_reg4;

architecture dataflow of testbench_reg4 is

	signal CLK, LD, CLR: std_logic;
	signal D: std_logic_vector(3 downto 0);
	signal Q: std_logic_vector(3 downto 0);
	
	component reg4 is
		port(
			CLK: in std_logic;
			LD : in std_logic;
			CLR: in std_logic;
			D  : in std_logic_vector(3 downto 0);
			Q  : out std_logic_vector(3 downto 0)
		);
	end component reg4;
	
begin
		
		UUT: reg4 port map(CLK=>CLK, LD=>LD, CLR=>CLR, D=>D, Q=>Q);
		
		test: process
		begin
			CLK <= '0'; CLR <= '0'; LD <= '0';D <= X"4"; WAIT FOR 50NS;
			CLK <= '1'; CLR <= '0'; LD <= '0';D <= X"5"; WAIT FOR 50NS;
			CLK <= '0'; CLR <= '0'; LD <= '0';D <= X"5"; WAIT FOR 50NS;
			CLK <= '1'; CLR <= '0'; LD <= '0';D <= X"5"; WAIT FOR 50NS;
			CLK <= '0'; CLR <= '0'; LD <= '1';D <= X"5"; WAIT FOR 50NS;
			CLK <= '1'; CLR <= '0'; LD <= '1';D <= X"5"; WAIT FOR 50NS;
			CLK <= '0'; CLR <= '0'; LD <= '1';D <= X"A"; WAIT FOR 50NS;
			CLK <= '1'; CLR <= '0'; LD <= '1';D <= X"A"; WAIT FOR 50NS;
			CLK <= '0'; CLR <= '0'; LD <= '0';D <= X"C"; WAIT FOR 50NS;
			CLK <= '1'; CLR <= '0'; LD <= '0';D <= X"C"; WAIT FOR 50NS;
			CLK <= '0'; CLR <= '1'; LD <= '0';D <= X"C"; WAIT FOR 50NS;
			CLK <= '1'; CLR <= '1'; LD <= '0';D <= X"C"; WAIT FOR 50NS;
			CLK <= '1'; CLR <= '0'; LD <= '0';D <= X"C"; WAIT FOR 50NS;
		end process test;

end architecture dataflow;