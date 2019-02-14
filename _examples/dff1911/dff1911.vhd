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
-- CREATED		"Tue Dec 04 21:03:29 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY dff1911 IS 
	PORT
	(
		CLK :  IN  STD_LOGIC;
		D :  IN  STD_LOGIC;
		LD :  IN  STD_LOGIC;
		CLR :  IN  STD_LOGIC;
		Q :  OUT  STD_LOGIC;
		QBAR :  OUT  STD_LOGIC
	);
END dff1911;

ARCHITECTURE bdf_type OF dff1911 IS 

COMPONENT dlatch1911
	PORT(D : IN STD_LOGIC;
		 En : IN STD_LOGIC;
		 Q : OUT STD_LOGIC;
		 QBAR : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;


BEGIN 
Q <= SYNTHESIZED_WIRE_2;



SYNTHESIZED_WIRE_1 <= NOT(LD);



SYNTHESIZED_WIRE_9 <= NOT(CLR);



SYNTHESIZED_WIRE_5 <= SYNTHESIZED_WIRE_9 AND SYNTHESIZED_WIRE_1 AND SYNTHESIZED_WIRE_2;


SYNTHESIZED_WIRE_4 <= SYNTHESIZED_WIRE_9 AND LD AND D;


SYNTHESIZED_WIRE_6 <= SYNTHESIZED_WIRE_4 OR SYNTHESIZED_WIRE_5;


b2v_inst5 : dlatch1911
PORT MAP(D => SYNTHESIZED_WIRE_6,
		 En => SYNTHESIZED_WIRE_7,
		 Q => SYNTHESIZED_WIRE_8);


b2v_inst6 : dlatch1911
PORT MAP(D => SYNTHESIZED_WIRE_8,
		 En => CLK,
		 Q => SYNTHESIZED_WIRE_2,
		 QBAR => QBAR);


SYNTHESIZED_WIRE_7 <= NOT(CLK);



END bdf_type;