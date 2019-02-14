library ieee;
use ieee.std_logic_1164.all;

entity engine is
	port(
		CLK: in std_logic; 
		RST: in std_logic;
		Y: out std_logic_vector(3 downto 0)
	);
end entity engine;

architecture behavioral of engine is 

	type state is(
		S0,                  -- Reset State
		S1,S2,S3,S4,S5,      -- Y3 States
		S6,S7,S8,S9,S10,     -- Y2 States
		S11,S12,S13,S14,S15, -- Y1 States
		S16,S17,S18,S19,S20  -- Y0 States
	);
	
	signal D, Q: state;

begin

	-- register
	reg: process(all)
	begin
		
		if rising_edge(CLK) then
			if RST = '0' then Q <= S0;
			else Q <= D;
			end if;
		end if;
	end process reg;
	
	-- nsl
	D <= -- S0 when Q=S
		S1 when Q=S0 or Q=S20 else            
		S2 when Q=S1 else   
		S3 when Q=S2 else   
		S4 when Q=S3 else   
		S5 when Q=S4 else   
		S6 when Q=S5 else   
		S7 when Q=S6 else   
		S8 when Q=S7 else   
		S9 when Q=S8 else   
		S10 when Q=S9 else 
		S11 when Q=S10 else 
		S12 when Q=S11 else 
		S13 when Q=S12 else 
		S14 when Q=S13 else 
		S15 when Q=S14 else 
		S16 when Q=S15 else 
		S17 when Q=S16 else 
		S18 when Q=S17 else 
		S19 when Q=S18 else 
		S20 when Q=S19 else
      S20;
	
	
	-- ol
	with Q select Y <=
		B"1000" when S1 |S2 |S3 |S4 |S5,
		B"0100" when S6 |S7 |S8 |S9 |S10,
		B"0010" when S11|S12|S13|S14|S15,
		B"0001" when S16|S17|S18|S19|S20,
		B"0000" when others;
	
end architecture behavioral;