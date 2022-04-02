
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.math_real.all;
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

        signal k : integer := 0;
          

BEGIN
        for l in 0 to n-1 generate
                if x(i) = '1' then
                        k <= k + l ** 2;
        end generate;     

        if dir = '0' then             -- shift left
                for j in 0 to k-1 generate
                        cout <= y(n-1); 
                        for i in n-1 downto 1 generate
                                res(i) <= y(i-1); 
                        end generate;
                        res(0) <= '0';           
                end generate;
        else                        -- dir = 1 -> shift right
                for j in 0 to k-1 generate
                        
                        cout <= y(0);
                        for i in 0 to n-2 generate
                                res(i) <= y(i+1);  
                        end generate;
                        res(n-1) <= '0';
               
                end generate;
		
	end if;
END shifterArch;
