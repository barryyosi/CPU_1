LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------------------------
ENTITY MUX IS
	PORT (a, b, s: IN std_logic;
			   cout: OUT std_logic);
END MUX;
--------------------------------------------------------
ARCHITECTURE muxArch OF MUX IS
BEGIN
	cout <= a WHEN s='0' ELSE b;
END muxArch;