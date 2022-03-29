LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------
ENTITY logic IS
	PORT (x, y : IN std_logic;
	      sel : IN std_logic_vector (2 DOWNTO 0); 
			s : OUT std_logic 
			);
END logic;
--------------------------------------
ARCHITECTURE logicUnitArch OF logic IS
BEGIN
	WITH sel SELECT
	   s <= not(y) when "000",
	       x or y when "001",
	       x and y when "010",
	       x xor y when "011",
	       x norLIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------
ENTITY logic IS
	GENERIC (n : INTEGER := 4);
	PORT (x, y : IN std_logic_vector (n-1 DOWNTO 0);
	      sel : IN std_logic_vector (2 DOWNTO 0); 
			s : OUT std_logic_vector (n-1 DOWNTO 0) 
			);
END logic;
--------------------------------------
ARCHITECTURE logicUnitArch OF logic IS
BEGIN
	
	   loop1: for i in 0 to n-1 generate
	   				WITH sel SELECT
					s(i) <=  not(y(i)) when "000",
						x(i) or y(i) when "001",
						x(i) and y(i) when "010",
						x(i) xor y(i) when "011",
						x(i) nor y(i) when "100",
						x(i) nand y(i) when "101",
						x(i) when OTHERS;
		   
	       		end generate;
END logicUnitArch;
 y when "100",
	       x nand y when "101",
	       x when OTHERS;
	       
END logicUnitArch;

