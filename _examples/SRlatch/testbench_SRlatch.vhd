LIBRARY ieee;
USE ieee.std_logic_1164.all; 

entity testbench_SRlatch is
end;

architecture df of testbench_SRlatch is

signal S, R: std_logic;
signal Q, QBAR: std_logic;

component SRlatch IS 
	PORT
	(
		R :  IN  STD_LOGIC;
		S :  IN  STD_LOGIC;
		Q :  OUT  STD_LOGIC;
		QBAR :  OUT  STD_LOGIC
	);
END component SRlatch;

begin

uut: SRlatch port map(R=>R, S=>S, Q=>Q, QBAR=>QBAR);

test:process

begin

r<='0'; S<='0'; wait for 1.0us;
r<='0'; S<='1'; wait for 0.5us;
r<='0'; S<='0'; wait for 0.5us;
r<='1'; S<='0'; wait for 0.5us;
r<='0'; S<='0'; wait for 0.5us;

end process test;
end architecture;