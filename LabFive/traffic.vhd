library ieee;
use ieee.std_logic_1164.all;

entity traffic is
port(CLK: in std_logic;
	  RST: in std_logic;
	  LEDS: out std_logic_vector(5 downto 0);
	  SEG7: out std_logic_vector(13 downto 0)  
	  );
end entity traffic;
architecture behavioral of traffic is 
	type states is (      
	                S0,
						 S1, S2,
						 
						 G1R2_1,G1R2_2,G1R2_3,G1R2_4,G1R2_5,G1R2_6,G1R2_7,G1R2_8,G1R2_9,
						 G1R2_10,G1R2_11,G1R2_12,G1R2_13,G1R2_14,G1R2_15,G1R2_16,G1R2_17,
						 G1R2_18,G1R2_19,G1R2_20,
						 
						 Y1R2_1,Y1R2_2,Y1R2_3,Y1R2_4,Y1R2_5,Y1R2_6,
						 
						 S3,S4,S5,
						 
						 R1G2_1,R1G2_2,R1G2_3,R1G2_4,R1G2_5,R1G2_6,R1G2_7,R1G2_8,R1G2_9,
						 R1G2_10,R1G2_11,R1G2_12,R1G2_13,R1G2_14,R1G2_15,R1G2_16,R1G2_17,
						 R1G2_18,R1G2_19,R1G2_20,
						 
						 R1Y2_1,R1Y2_2,R1Y2_3,R1Y2_4,R1Y2_5,R1Y2_6
						 );
						 
	signal D, Q: states;
	
	signal cnt: integer range 0 to 25000000;
	signal clk1Hz : std_logic;
 
 begin 
 
	-- next state logic
	-- any state moves to S0 if RST pushbutton is pressed 
	D <= S0 		 when Q=R1Y2_6 else
		  S1 		 when Q=S0  else            
		  S2      when Q=S1 else   
		  G1R2_1  when Q=S2 else   
		  G1R2_2  when Q=G1R2_1 else   
		  G1R2_3  when Q=G1R2_2 else   
		  G1R2_4  when Q=G1R2_3 else   
		  G1R2_5  when Q=G1R2_4 else   
		  G1R2_6  when Q=G1R2_5 else   
		  G1R2_7  when Q=G1R2_6 else   
		  G1R2_8  when Q=G1R2_7 else 
		  G1R2_9  when Q=G1R2_8 else 
		  G1R2_10 when Q=G1R2_9 else 
		  G1R2_11 when Q=G1R2_10 else 
		  G1R2_12 when Q=G1R2_11 else 
		  G1R2_13 when Q=G1R2_12 else 
		  G1R2_14 when Q=G1R2_13 else 
		  G1R2_15 when Q=G1R2_14 else 
		  G1R2_16 when Q=G1R2_15 else 
		  G1R2_17 when Q=G1R2_16 else
		  G1R2_18 when Q=G1R2_17 else 
		  G1R2_19 when Q=G1R2_18 else 
		  G1R2_20 when Q=G1R2_19 else 
		  Y1R2_1  when Q=G1R2_20 else 
		  Y1R2_2  when Q=Y1R2_1 else 
		  Y1R2_3  when Q=Y1R2_2 else 
		  Y1R2_4  when Q=Y1R2_3 else 
		  Y1R2_5  when Q=Y1R2_4 else 
		  Y1R2_6  when Q=Y1R2_5 else 
		  S3      when Q=Y1R2_6 else 
		  S4 		 when Q=S3 else
		  S5      when Q=S4 else
		  R1G2_1  when Q=S5 else
		  R1G2_2  when Q=R1G2_1 else
		  R1G2_3  when Q=R1G2_2 else
		  R1G2_4  when Q=R1G2_3 else
		  R1G2_5  when Q=R1G2_4 else
		  R1G2_6  when Q=R1G2_5 else
		  R1G2_7  when Q=R1G2_6 else
		  R1G2_8  when Q=R1G2_7 else
		  R1G2_9  when Q=R1G2_8 else
		  R1G2_10 when Q=R1G2_9 else
		  R1G2_11 when Q=R1G2_10 else
		  R1G2_12 when Q=R1G2_11 else
		  R1G2_13 when Q=R1G2_12 else
		  R1G2_14 when Q=R1G2_13 else
		  R1G2_15 when Q=R1G2_14 else
		  R1G2_16 when Q=R1G2_15 else
		  R1G2_17 when Q=R1G2_16 else
	     R1G2_18 when Q=R1G2_17 else
		  R1G2_19 when Q=R1G2_18 else
		  R1G2_20 when Q=R1G2_19 else
		  R1Y2_1  when Q=R1G2_20 else
		  R1Y2_2  when Q=R1Y2_1 else
		  R1Y2_3  when Q=R1Y2_2 else
		  R1Y2_4  when Q=R1Y2_3 else
		  R1Y2_5  when Q=R1Y2_4 else
		  R1Y2_6  when Q=R1Y2_5 else
		  S0;
		  
	-- state register
	reg: process(all) 
	begin 
		if rising_edge(clk1Hz) then 
			if RST = '0' then Q <= S0;
			else Q <= D;
			end if;
		end if;
	end process reg;
	
	--slow clock 
	counter: process (clk)
	begin	
		if rising_edge(clk) then 
			cnt <= cnt+1;
			if cnt = 25000000 then 
				clk1Hz <= not clk1Hz;
				cnt<=0;
			end if;
		end if;
	end process;
	
	-- output logic 
	with Q select 
	        
	LEDS <= B"110011" when G1R2_1|G1R2_2|G1R2_3|G1R2_4|G1R2_5|G1R2_6|G1R2_7|G1R2_8|G1R2_9|G1R2_10|G1R2_11|G1R2_12|G1R2_13|G1R2_14|G1R2_15|G1R2_16|G1R2_17|G1R2_18|G1R2_19|G1R2_20, -- g r
		     B"101011" when Y1R2_1|Y1R2_2|Y1R2_3|Y1R2_4|Y1R2_5|Y1R2_6,                                                                                                              -- y r
		     B"011101" when R1Y2_1|R1Y2_2|R1Y2_3|R1Y2_4|R1Y2_5|R1Y2_6,                                                                                                              -- r y
			  B"011110" when R1G2_1|R1G2_2|R1G2_3|R1G2_4|R1G2_5|R1G2_6|R1G2_7|R1G2_8|R1G2_9|R1G2_10|R1G2_11|R1G2_12|R1G2_13|R1G2_14|R1G2_15|R1G2_16|R1G2_17|R1G2_18|R1G2_19|R1G2_20, -- r g
		     B"011011" when others;                                                                                                                                                 -- r r
			  
	with Q select 
	
	SEG7 <= B"01000011001111" when G1R2_1|G1R2_2|G1R2_3|G1R2_4|G1R2_5|G1R2_6|G1R2_7|G1R2_8|G1R2_9|G1R2_10|G1R2_11|G1R2_12|G1R2_13|G1R2_14|G1R2_15|G1R2_16|G1R2_17|G1R2_18|G1R2_19|G1R2_20,
		     B"11001001110001" when Y1R2_1|Y1R2_2|Y1R2_3|Y1R2_4|Y1R2_5|Y1R2_6|R1Y2_1|R1Y2_2|R1Y2_3|R1Y2_4|R1Y2_5|R1Y2_6,
		     B"01000010010010" when R1G2_1|R1G2_2|R1G2_3|R1G2_4|R1G2_5|R1G2_6|R1G2_7|R1G2_8|R1G2_9|R1G2_10|R1G2_11|R1G2_12|R1G2_13|R1G2_14|R1G2_15|R1G2_16|R1G2_17|R1G2_18|R1G2_19|R1G2_20, 
		     B"11001001110000" when others;
	
end architecture behavioral;
