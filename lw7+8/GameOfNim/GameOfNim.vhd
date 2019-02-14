library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GameOfNim is
	port(
		row      : in std_logic_vector(1 downto 0);
		num      : in std_logic_vector(2 downto 0);
		rst      : in std_logic;
		clk      : in std_logic;
		nextTurn : in std_logic;
		HEX0     : out std_logic_vector(6 downto 0);
		HEX1     : out std_logic_vector(6 downto 0);
		HEX2     : out std_logic_vector(6 downto 0);
		HEX3     : out std_logic_vector(6 downto 0);
		HEX4     : out std_logic_vector(6 downto 0);
		HEX5     : out std_logic_vector(6 downto 0)
	);
end entity GameOfNim;

architecture behav of GameOfNim is

	-- types
	type states is (
		reset,
		play,
		win, lose
	);
	
	type playerState is (
		p1,
		p2
	);

	-- state signals
	signal player       : playerState := p1;
	signal nextPlayer   : playerState;
	signal nextGameState    : states;
	signal currentGameState : states;
	
	-- slow clock signal
	signal cnt    : integer range 0 to 25000000;
	signal clk1Hz : std_logic;
	
	-- coin pile counts
	signal pileOne   : integer range 0 to 5 := 4;
	signal pileTwo   : integer range 0 to 5 := 0;
	signal pileThree : integer range 0 to 5 := 2;
	
	signal validTurn : std_logic := '0';
	
	-- constants
	constant blank : std_logic_vector(6 downto 0) := b"1111111";
	constant one   : std_logic_vector(6 downto 0) := b"1111001";
	constant two   : std_logic_vector(6 downto 0) := b"0100100";
	
	constant letter_W : std_logic_vector(6 downto 0) := b"0000001";
	constant letter_I : std_logic_vector(6 downto 0) := b"1111011";
	constant letter_N : std_logic_vector(6 downto 0) := b"0101011";
	constant letter_R : std_logic_vector(6 downto 0) := b"0101111";
	constant letter_E : std_logic_vector(6 downto 0) := b"0000110";
	constant letter_S : std_logic_vector(6 downto 0) := b"0010011";
	constant letter_T : std_logic_vector(6 downto 0) := b"0000111";
	
	constant ooo : std_logic_vector(6 downto 0) := b"1111111";
	constant ool : std_logic_vector(6 downto 0) := b"1110111";
	constant olo : std_logic_vector(6 downto 0) := b"0111111";
	constant loo : std_logic_vector(6 downto 0) := b"1111110";
	constant oll : std_logic_vector(6 downto 0) := b"0110111";
	constant lol : std_logic_vector(6 downto 0) := b"1110110";
	constant llo : std_logic_vector(6 downto 0) := b"0111110";
	constant lll : std_logic_vector(6 downto 0) := b"0110110";
	
	
	-- attributes
	attribute chip_pin: string;
	
	attribute chip_pin of clk  : signal is "P11";
	attribute chip_pin of rst  : signal is "B8";
	attribute chip_pin of nextTurn : signal is "A7";
	
	attribute chip_pin of row : signal is "F15,B14";
	attribute chip_pin of num : signal is "D12,C11,C10";
	
	attribute chip_pin of HEX5 : signal is "N20,N19,M20,N18,L18,K20,J20";
	attribute chip_pin of HEX4 : signal is "F20,F19,H19,J18,E19,E20,F18";
	attribute chip_pin of HEX3 : signal is "E17,D19,C20,C19,E21,E22,F21";
	attribute chip_pin of HEX2 : signal is "B22,C22,B21,A21,B19,A20,B20";
	attribute chip_pin of HEX1 : signal is "B17,A18,A17,B16,E18,D18,C18";
	attribute chip_pin of HEX0 : signal is "C17,D17,E16,C16,C15,E15,C14";
	
begin

	-- slow clock
	counter: process(all)
	begin	
		if rising_edge(clk) then 
			cnt <= cnt+1;
			if cnt = 25000000 then 
				clk1Hz <= not clk1Hz;
				cnt<=0;
			end if;
		end if;
	end process;
	
	
	-- register
	syncReg: process(all)
	begin
		if rising_edge(clk1Hz) then
			if RST = '0' then currentGameState <= reset;
			else 
				currentGameState <= nextGameState;
				player           <= nextPlayer;
			end if;
		end if;
	end process;
	
	
	
	-- nsl
	
	process(all)
	begin
		-- determine if the current inputs are a valid turn
		if    row = "01" and pileOne   >= to_integer(unsigned(num)) and to_integer(unsigned(num)) > 0 then validTurn <= '1';
		elsif row = "10" and pileTwo   >= to_integer(unsigned(num)) and to_integer(unsigned(num)) > 0 then validTurn <= '1';
		elsif row = "11" and pileThree >= to_integer(unsigned(num)) and to_integer(unsigned(num)) > 0 then validTurn <= '1';
		else  validTurn <= '0';
		end if;
		
		-- handle switching current player
		if    player = p1 and nextTurn = '0' and validTurn = '1' then nextPlayer <= p2;
		elsif player = p2 and nextTurn = '0' and validTurn = '1' then nextPlayer <= p1;
		else  nextPlayer <= player;
		end if;
		
		-- update pile amounts on valid turn
		if nextTurn = '0' and validTurn = '1' and rising_edge(clk1Hz) then
			if    row = "01" then pileOne   <= pileOne   - to_integer(unsigned(num));
			elsif row = "10" then pileTwo   <= pileTwo   - to_integer(unsigned(num));
			elsif row = "11" then pileThree <= pileThree - to_integer(unsigned(num));
			end if;
		end if;
		
		-- check for a winner
		if pileOne = 0 and pileTwo = 0 and pileThree = 0 then
			if    player = p1 then nextGameState <= win;
			elsif player = p2 then nextGameState <= lose;
			end if;
		end if;
		
		-- reset functionality
		if currentGameState = reset then 
			nextGameState <= play;
			nextPlayer    <= p1;
			pileOne       <= 5;
			pileTwo       <= 4;
			pileThree     <= 3;
		end if;
		
	end process;
	
	

	-----------------------------------------------------------------------------------------
	-----------------------------------OUTPUT LOGIC------------------------------------------
	-----------------------------------------------------------------------------------------
	
	process(all)
	begin
	
		if currentGameState = play then
			-- player output
			if    player = p1 then HEX5 <= one;
			elsif player = p2 then HEX5 <= two;
			else  HEX5 <= blank;
			end if;
			
			-- pile one output
			if pileOne >= 5 then HEX4(3) <= '0'; else HEX4(3) <= '1'; end if;
			if pileOne >= 4 then HEX3(3) <= '0'; else HEX3(3) <= '1'; end if;
			if pileOne >= 3 then HEX2(3) <= '0'; else HEX2(3) <= '1'; end if;
			if pileOne >= 2 then HEX1(3) <= '0'; else HEX1(3) <= '1'; end if;
			if pileOne >= 1 then HEX0(3) <= '0'; else HEX0(3) <= '1'; end if;
			
			-- pile one output
			if pileTwo >= 5 then HEX4(6) <= '0'; else HEX4(6) <= '1'; end if;
			if pileTwo >= 4 then HEX3(6) <= '0'; else HEX3(6) <= '1'; end if;
			if pileTwo >= 3 then HEX2(6) <= '0'; else HEX2(6) <= '1'; end if;
			if pileTwo >= 2 then HEX1(6) <= '0'; else HEX1(6) <= '1'; end if;
			if pileTwo >= 1 then HEX0(6) <= '0'; else HEX0(6) <= '1'; end if;
			
			-- pile one output
			if pileThree >= 5 then HEX4(0) <= '0'; else HEX4(0) <= '1'; end if;
			if pileThree >= 4 then HEX3(0) <= '0'; else HEX3(0) <= '1'; end if;
			if pileThree >= 3 then HEX2(0) <= '0'; else HEX2(0) <= '1'; end if;
			if pileThree >= 2 then HEX1(0) <= '0'; else HEX1(0) <= '1'; end if;
			if pileThree >= 1 then HEX0(0) <= '0'; else HEX0(0) <= '1'; end if;
			
			HEX4(1) <= '1';
			HEX4(2) <= '1';
			HEX4(4) <= '1';
			HEX4(5) <= '1';
			
			HEX3(1) <= '1';
			HEX3(2) <= '1';
			HEX3(4) <= '1';
			HEX3(5) <= '1';
			
			HEX2(1) <= '1';
			HEX2(2) <= '1';
			HEX2(4) <= '1';
			HEX2(5) <= '1';
			
			HEX1(1) <= '1';
			HEX1(2) <= '1';
			HEX1(4) <= '1';
			HEX1(5) <= '1';
			
			HEX1(1) <= '1';
			HEX1(2) <= '1';
			HEX1(4) <= '1';
			HEX1(5) <= '1';
			
			HEX0(1) <= '1';
			HEX0(2) <= '1';
			HEX0(4) <= '1';
			HEX0(5) <= '1';
		end if;
		
		if currentGameState = win then
			HEX5 <= one;
			HEX4 <= blank;
			HEX3 <= letter_W;
			HEX2 <= letter_I;
			HEX1 <= letter_N;
			HEX0 <= letter_S;
		end if;
	
		if currentGameState = lose then
			HEX5 <= two;
			HEX4 <= blank;
			HEX3 <= letter_W;
			HEX2 <= letter_I;
			HEX1 <= letter_N;
			HEX0 <= letter_S;
		end if;	
		
		if currentGameState = reset then
			HEX5 <= blank;
			HEX4 <= letter_R;
			HEX3 <= letter_E;
			HEX2 <= letter_S;
			HEX1 <= letter_E;
			HEX0 <= letter_T;
		end if;	
	
	end process;
	
	
	
end architecture behav;