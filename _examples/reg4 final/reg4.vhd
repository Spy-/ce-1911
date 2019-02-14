-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 18.0.0 Build 614 04/24/2018 SJ Lite Edition"
-- CREATED		"Wed Dec 05 08:05:17 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY reg4 IS 
	PORT
	(
		CLR :  IN  STD_LOGIC;
		LD :  IN  STD_LOGIC;
		CLK :  IN  STD_LOGIC;
		D :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		Q :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END reg4;

ARCHITECTURE bdf_type OF reg4 IS 

COMPONENT dff1911
	PORT(CLK : IN STD_LOGIC;
		 D : IN STD_LOGIC;
		 LD : IN STD_LOGIC;
		 CLR : IN STD_LOGIC;
		 Q : OUT STD_LOGIC;
		 QBAR : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	Q_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(3 DOWNTO 0);


BEGIN 



b2v_inst : dff1911
PORT MAP(CLK => CLK,
		 D => D(0),
		 LD => LD,
		 CLR => CLR,
		 Q => Q_ALTERA_SYNTHESIZED(0));


b2v_inst1 : dff1911
PORT MAP(CLK => CLK,
		 D => D(1),
		 LD => LD,
		 CLR => CLR,
		 Q => Q_ALTERA_SYNTHESIZED(1));


b2v_inst2 : dff1911
PORT MAP(CLK => CLK,
		 D => D(2),
		 LD => LD,
		 CLR => CLR,
		 Q => Q_ALTERA_SYNTHESIZED(2));


b2v_inst3 : dff1911
PORT MAP(CLK => CLK,
		 D => D(3),
		 LD => LD,
		 CLR => CLR,
		 Q => Q_ALTERA_SYNTHESIZED(3));

Q <= Q_ALTERA_SYNTHESIZED;

END bdf_type;