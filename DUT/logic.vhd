LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------
ENTITY logic IS
	GENERIC (n : INTEGER := 8);
	PORT (x, y : IN std_logic_vector (n-1 DOWNTO 0);
	      ALUFN : IN std_logic_vector (2 DOWNTO 0);
			res : OUT std_logic_vector (n-1 DOWNTO 0)
			);
END logic;
--------------------------------------
ARCHITECTURE logicUnitArch OF logic IS
BEGIN

	   loop1: for i in 0 to n-1 generate
	   				WITH ALUFN SELECT
					res(i) <=  not(y(i)) when "000",
						x(i) or y(i) when "001",
						x(i) and y(i) when "010",
						x(i) xor y(i) when "011",
						x(i) nor y(i) when "100",
						x(i) nand y(i) when "101",
						'0' when OTHERS;

	       		end generate;
END logicUnitArch;


