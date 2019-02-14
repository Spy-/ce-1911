library ieee;
use ieee.std_logic_1164.all;

entity testbench_dff1911 is
end entity testbench_dff1911;

architecture dataflow of testbench_dff1911 is
	signal CLK, CLR, LD, D: std_logic;
	signal Q, QBAR: std_logic;
	
	component dff1911 is
	port(CLK, CLR, LD, D: in std_logic;
	     Q,QBAR: out std_logic);
	end component dff1911;
	
begin

	UUT: dff1911 port map(CLR=>CLR,LD=>LD,D=>D,CLK=>CLK,Q=>Q,QBAR=>QBAR);
	
	test: process
	begin
		CLK<='0'; CLR<='0'; LD<='0'; D<='0'; WAIT FOR 0.5US;
		CLK<='1'; CLR<='0'; LD<='0'; D<='0'; WAIT FOR 0.5US;
		CLK<='0'; CLR<='0'; LD<='0'; D<='1'; WAIT FOR 0.5US;
		CLK<='1'; CLR<='0'; LD<='0'; D<='1'; WAIT FOR 0.5US;
		CLK<='0'; CLR<='0'; LD<='1'; D<='0'; WAIT FOR 0.5US;
		CLK<='1'; CLR<='0'; LD<='1'; D<='0'; WAIT FOR 0.5US;
		CLK<='0'; CLR<='0'; LD<='1'; D<='1'; WAIT FOR 0.5US;
		CLK<='1'; CLR<='0'; LD<='1'; D<='1'; WAIT FOR 0.5US;
		CLK<='0'; CLR<='0'; LD<='0'; D<='1'; WAIT FOR 0.5US;
		CLK<='1'; CLR<='0'; LD<='0'; D<='1'; WAIT FOR 0.5US;
		CLK<='0'; CLR<='1'; LD<='0'; D<='1'; WAIT FOR 0.5US;
		CLK<='1'; CLR<='1'; LD<='0'; D<='1'; WAIT FOR 0.5US;
		CLK<='1'; CLR<='0'; LD<='0'; D<='1'; WAIT FOR 0.5US;
	end process test;
end architecture dataflow;