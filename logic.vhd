LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------
ENTITY logic IS
	PORT (x, y, : IN std_logic;
	      sel: IN std_logic_vector (2 DOWNTO 0); 
			s: OUT std_logic);
END FA;
--------------------------------------
ARCHITECTURE logicUnitArch OF logic IS
BEGIN
	WITH sel SELECT
	   s = not(y) when "000",
	       x or y when "001",
	       x and y when "010",
	       x xor y when "011",
	       x nor y when "100",
	       x nand y when "101;
	       
END logicUnitArch;
