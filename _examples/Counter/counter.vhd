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
-- CREATED		"Wed Dec 12 10:39:19 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY counter IS 
	PORT
	(
		U :  IN  STD_LOGIC;
		CLR :  IN  STD_LOGIC;
		LD :  IN  STD_LOGIC;
		CLK :  IN  STD_LOGIC;
		Q :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		SEGMENT :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END counter;

ARCHITECTURE bdf_type OF counter IS 

COMPONENT seg7
	PORT(A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;

COMPONENT nsl
	PORT(U : IN STD_LOGIC;
		 Q : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 D : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT reg4
	PORT(CLK : IN STD_LOGIC;
		 CLR : IN STD_LOGIC;
		 LD : IN STD_LOGIC;
		 D : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT slowclk
	PORT(RST : IN STD_LOGIC;
		 CLK50MHZ : IN STD_LOGIC;
		 CLK1HZ : INOUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;


BEGIN 
Q <= SYNTHESIZED_WIRE_5;
SYNTHESIZED_WIRE_4 <= '0';



b2v_inst : seg7
PORT MAP(A => SYNTHESIZED_WIRE_5,
		 seg => SEGMENT);


b2v_inst1 : nsl
PORT MAP(U => U,
		 Q => SYNTHESIZED_WIRE_5,
		 D => SYNTHESIZED_WIRE_3);


b2v_inst2 : reg4
PORT MAP(CLK => SYNTHESIZED_WIRE_2,
		 CLR => CLR,
		 LD => LD,
		 D => SYNTHESIZED_WIRE_3,
		 Q => SYNTHESIZED_WIRE_5);


b2v_inst3 : slowclk
PORT MAP(RST => SYNTHESIZED_WIRE_4,
		 CLK50MHZ => CLK,
		 CLK1HZ => SYNTHESIZED_WIRE_2);



END bdf_type;