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
-- CREATED		"Wed Dec 05 08:04:46 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY dlatch1911 IS 
	PORT
	(
		D :  IN  STD_LOGIC;
		En :  IN  STD_LOGIC;
		Q :  OUT  STD_LOGIC;
		QBAR :  OUT  STD_LOGIC
	);
END dlatch1911;

ARCHITECTURE bdf_type OF dlatch1911 IS 

COMPONENT sr
	PORT(R : IN STD_LOGIC;
		 S : IN STD_LOGIC;
		 Q : OUT STD_LOGIC;
		 QBAR : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;


BEGIN 



SYNTHESIZED_WIRE_0 <= NOT(D);



SYNTHESIZED_WIRE_1 <= SYNTHESIZED_WIRE_0 AND En;


SYNTHESIZED_WIRE_2 <= D AND En;


b2v_inst3 : sr
PORT MAP(R => SYNTHESIZED_WIRE_1,
		 S => SYNTHESIZED_WIRE_2,
		 Q => Q,
		 QBAR => QBAR);


END bdf_type;