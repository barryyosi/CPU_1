
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

        signal zeros : std_logic_vector (n-1 DOWNTO 0 ) <= (others => '0');
        

BEGIN
        if dir = '0' then                       -- shift left
                for i in 0 to n-1 generate
                        if x(i) = '1' generate
                                res <= y( n - 2**i - 1 downto 0) & zeros( 0 to 2**i );         
                        end generate;
                end generate;
        
        else                                    -- dir = '1' -> shift right
                for i in 0 to n-1 generate
                        if x(i) = '1' generate
                                res <= zeros( 0 to 2**i ) & y( n - 1 downto 2**i) ;         
                        end generate;
                end generate;

        end if;
END shifterArch;





