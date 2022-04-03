LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.math_real.all;
--------------------------------------
ENTITY shifter IS
	GENERIC (n : INTEGER := 4);
	PORT (x, y : IN std_logic_vector (n-1 DOWNTO 0);
	        ALUFN : IN std_logic_vector (1 DOWNTO 0);
	        cout : OUT std_logic;
                res : OUT std_logic_vector (n-1 DOWNTO 0) 
			);
END shifter;
--------------------------------------
ARCHITECTURE shifterArch OF shifter IS

        signal zeros : std_logic_vector (n-1 DOWNTO 0 ) := (others => '0');
        constant log_n: integer := integer(ceil(log2(real(n))));

BEGIN
         
     loop0: for i in 0 to log_n - 1 generate
                        cout <= y( n - 2**i )  when (x(i)= '1' and ALUFN ="00") else
                                     y( 2**i - 1) when (x(i)= '1' and ALUFN = "01") else
                                     UNAFFECTED; 
                                      
                        res <= y( n - 2**i - 1 downto 0) & zeros( 2**i - 1 downto 0  ) when (x(i)= '1' and ALUFN ="00") else
                                    zeros( 2**i - 1 downto 0 ) & y( n - 1 downto 2**i)  when (x(i)= '1' and ALUFN = "01") else
                                    UNAFFECTED;   
                
                end generate;
        
END shifterArch;