library ieee;
use ieee.std_logic_1164.all;

entity lw6 is
	port(
		CLK     : in  std_logic;
		RST     : in  std_logic;
		Quarter : in  std_logic;
		Pepsi   : in  std_logic;
		Water   : in  std_logic;
		VP      : out std_logic;
		VW      : out std_logic;
		HEX4    : out std_logic_vector(6 downto 0);
		HEX3    : out std_logic_vector(6 downto 0);
		HEX2    : out std_logic_vector(6 downto 0);
		HEX1    : out std_logic_vector(6 downto 0);
		HEX0    : out std_logic_vector(6 downto 0)
	);
end entity lw6;

architecture behav of lw6 is

	-- types
	type states is (
		reset,
		S0, S25, S50, S75, S100, S125, S150,
		vPepsi, vWater,
		n0, n25, n50, n75, n100, n125
	);

	-- signals
	signal cnt: integer range 0 to 25000000;
	signal clk1Hz : std_logic;
	
	signal currentState : states;
	signal nextState    : states;
	
	signal QPW   : std_logic_vector(1 downto 0);
	signal drink : std_logic;
	
	-- constants
	constant zero  : std_logic_vector(6 downto 0) := b"1000000";
	constant one   : std_logic_vector(6 downto 0) := b"1111001";
	constant two   : std_logic_vector(6 downto 0) := b"0100100";
	constant five  : std_logic_vector(6 downto 0) := b"0010010";
	constant seven : std_logic_vector(6 downto 0) := b"1111000";
	
	constant R : std_logic_vector(6 downto 0) := b"0101111";
	constant E : std_logic_vector(6 downto 0) := b"0000110";
	constant S : std_logic_vector(6 downto 0) := b"0010011";
	constant T : std_logic_vector(6 downto 0) := b"0000111";
	constant P : std_logic_vector(6 downto 0) := b"0001100";
	constant I : std_logic_vector(6 downto 0) := b"1111011";
	constant W : std_logic_vector(6 downto 0) := b"0000001";
	constant A : std_logic_vector(6 downto 0) := b"0001000";
	
	constant blank : std_logic_vector(6 downto 0) := b"1111111";
	
	-- attributes
	attribute chip_pin: string;
	
	attribute chip_pin of CLK     : signal is "P11";
	attribute chip_pin of RST     : signal is "B8";
	attribute chip_pin of Quarter : signal is "D12";
	attribute chip_pin of Pepsi   : signal is "C11";
	attribute chip_pin of Water   : signal is "C10";
	attribute chip_pin of VP      : signal is "AB6";
	attribute chip_pin of VW      : signal is "AB5";
	
	attribute chip_pin of HEX4 : signal is "F20,F19,H19,J18,E19,E20,F18";
	attribute chip_pin of HEX3 : signal is "E17,D19,C20,C19,E21,E22,F21";
	attribute chip_pin of HEX2 : signal is "B22,C22,B21,A21,B19,A20,B20";
	attribute chip_pin of HEX1 : signal is "B17,A18,A17,B16,E18,D18,C18";
	attribute chip_pin of HEX0 : signal is "C17,D17,E16,C16,C15,E15,C14";
	
begin

	drink <= Pepsi or Water;
	QPW <= Quarter&drink;

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
		if rising_edge(clk) then
			if RST = '0' then currentState <= reset;
			else currentState <= nextState;
			end if;
		end if;
	end process;
	
	-- nsl
	nextState <= 
		S0     when currentState = reset                  else
		S25    when currentState = S0     and QPW = "10"  else
		S50    when currentState = S25    and QPW = "10"  else
		S75    when currentState = S50    and QPW = "10"  else
		S100   when currentState = S75    and QPW = "10"  else
		S125   when currentState = S100   and QPW = "10"  else
		S150   when currentState = S125   and QPW = "10"  else
		n0     when currentState = S0     and QPW = "01"  else
		n25    when currentState = S25    and QPW = "01"  else
		n50    when currentState = S50    and QPW = "01"  else
		n75    when currentState = S75    and QPW = "01"  else
		n100   when currentState = S100   and QPW = "01"  else
		n125   when currentState = S125   and QPW = "01"  else
		S0     when currentState = n0     and QPW = "00"  else
		S25    when currentState = n25    and QPW = "00"  else
		S50    when currentState = n50    and QPW = "00"  else
		S75    when currentState = n75    and QPW = "00"  else
		S100   when currentState = n100   and QPW = "00"  else
		S125   when currentState = n125   and QPW = "00"  else
		vPepsi when currentState = S150   and Pepsi = '1' else
		vWater when currentState = S150   and Water = '1' else
		S0     when currentState = vPepsi and Pepsi = '0' else
		S0     when currentState = vWater and Water = '0' else
		currentState;
		
	
	-- ol
	with currentState select
		HEX4 <= R 	  when reset,
				  P     when vPepsi,
				  W     when vWater,
				  blank when others;
		
	with currentState select
		HEX3 <= E     when reset|vPepsi,
				  A     when vWater,
				  blank when others;
		
	with currentState select	
		HEX2 <= S     when reset,
				  P     when vPepsi,
				  T     when vWater,
				  zero  when S0|S25|S50|S75,
				  one   when S100|S125|S150|n0|n25|n50|n75|n100|n125,
				  blank when others;
		
	with currentState select	
		HEX1 <= E     when reset|vWater,
				  S     when vPepsi,
				  zero  when S0|S100,
				  two   when S25|S125,
				  five  when S50|S150|n0|n25|n50|n75|n100|n125,
				  seven when S75,
				  blank when others;
		
	with currentState select	
		HEX0 <= T     when reset,
				  I     when vPepsi,
				  R     when vWater,
				  zero  when S0|S50|S100|S150|n0|n25|n50|n75|n100|n125,
				  five  when S25|S75|S125,
				  blank when others;
				  
	with currentState select
		VP <= '1' when vPepsi,
				'0' when others;
				
	with currentState select
		VW <= '1' when vWater,
				'0' when others;

end architecture behav;