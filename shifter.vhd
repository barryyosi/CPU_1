
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------
ENTITY shifter IS
	GENERIC (n : INTEGER := 4);
	PORT (x, y : IN std_logic_vector (n-1 DOWNTO 0);
	       dir : IN std_logic;
		  cout : OUT std_logic;
          res : OUT std_logic_vector (n-1 DOWNTO 0) 
			);
END shifter;
--------------------------------------
ARCHITECTURE shifterArch OF shifter IS
BEGIN
	if dir = 0 then             -- shift left
        for j in 0 to k-1 generate
            y(0) <= '0';
            cout <= y(n-1);
            for i in 1 to n-1 generate
              y(i) <= y(i-1);
  else                        -- dir = 1 -> shift right
        y

END shifterArch;
