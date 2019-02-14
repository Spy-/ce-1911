library ieee;
use ieee.std_logic_1164.all;

entity TL is
port(
	CLK, CLR, LD: in std_logic;
	G1,G2, Y1,Y2, R1,R2: out std_logic;
	segment: out std_logic_vector(15 downto 0)
);
end entity TL;

architecture behav of TL is

type state is(S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11);
signal current_state, next_state: state;

-- outputs
constant Green1: std_logic_vector(15 downto 0) := x"CA42";
constant SLOW  : std_logic_vector(15 downto 0) := x"CA42";
constant STOP  : std_logic_vector(15 downto 0) := x"CA42";
constant Green2: std_logic_vector(15 downto 0) := x"CA42";

-- slow clock
signal RST: std_logic;
signal CLK1HZ: std_logic;
signal CNT: integer range 0 to 25000000;

-- change quartus encoding of state machine
--attribute syn_encoding: string;
--attribute syn_encoding of state: type is "sequential";
--attribute syn_encoding of state: type is "gray";

-- pins
attribute chip_pin: string;
attribute chip_pin of clk: signal is "p11";

begin

-- register
	reg: process(all)
	begin
		if rising_edge(CLK1HZ) then
			if CLR = '0' then current_state <= S0;
			elsif LD = '1' then current_state <= next_state;
			end if;
		end if;
	end process;
	
-- nsl
	nsl: process(all)
	begin
		case current_state is
			when S0  => next_state <= S1;
			when S1  => next_state <= S2;
			when S2  => next_state <= S3;
			when S3  => next_state <= S4;
			when S4  => next_state <= S5;
			when S5  => next_state <= S6;
			when S6  => next_state <= S7;
			when S7  => next_state <= S8;
			when S8  => next_state <= S9;
			when S9  => next_state <= S10;
			when S10 => next_state <= S11;
			when S11 => next_state <= S0;
		end case;
	end process;
	
-- ol
	with current_state select G1 <=
		'1' when S1|S2|S3,
		'0' when others;
	with current_state select G2 <=
		'1' when S7|S8|S9,
		'0' when others;
	with current_state select Y1 <=
		'1' when S4|S5,
		'0' when others;
	with current_state select Y2 <=
		'1' when S10|S11,
		'0' when others;
	with current_state select R1 <=
		'1' when S0|S6|S7|S8|S9|S10|S11,
		'0' when others;
	with current_state select R2 <=
		'1' when S0|S1|S2|S3|S4|S5|S6,
		'0' when others;

		
	with current_state select segment <=
		STOP   when S0|S6,
		SLOW   when S4|S5|S10|S11,
		Green1 when S1|S2|S3,
		Green2 when others;
		
-- slow Clock
	SCLK: process(RST, CLK)
	begin
		if RST = '0'
		then CNT <= 0;
		elsif rising_edge(CLK) then
		CNT <= CNT + 1;
			if CNT = 25000000 then
			CLK1HZ <= not CLK1HZ;
			CNT <= 0; end if;
		end if;
	end process;

end architecture behav;