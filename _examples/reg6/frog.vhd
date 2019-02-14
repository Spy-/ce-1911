library ieee;
use ieee.std_logic_1164.all;

entity frog is
	port(
		CLK,  CLR, LD, S: in std_logic;
		scared: out std_logic;
		position: out std_logic_vector(1 downto 0)
	);
end entity frog;

architecture behav of frog is 

   --signal Q, D: std_logic_vector(1 downto 0);
	type state is(S0, S1, S2, S3);
	signal currentState, nextState: state;

begin

-- register 4
	reg: process(all)
	begin
		
		if CLR = '1' then currentState <= S0;
		elsif rising_edge(CLK) then
			if LD = '1' then currentState <= nextState;
			end if;
		end if;
	
	end process;

-- nsl
	nsl: process(all)
	begin
	
		nextState <= currentState;
		scared <= S;
	
		case currentState is 
			when S0 => 
				if S = '0' then 
					nextState <= S1;
				end if;
			when S1 => 
				if S = '0' then 
					nextState <= S2;
				end if;
			when S2 => 
				if S = '0' then 
					nextState <= S3;
				end if;
			when S3 => 
				scared <= '0';
				
		end case;
	end process;

-- ol
	with currentState select position <=
		"00" when S0,
		"01" when S1,
		"10" when S2,
		"11" when others;



end architecture behav;