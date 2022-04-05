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

        constant log_n: integer := integer(log2(real(n)));
        type vectorArr is array (0 to log_n - 1) of std_logic_vector ( n - 1 downto 0);
        signal zeros : std_logic_vector (n-1 DOWNTO 0 ) := (others => '0');
        signal resMat: vectorArr;     -- log(n)Xn mat
        signal carryVec : std_logic_vector (0 to log_n - 1);
        signal k : integer := 0;

BEGIN
        for j in 0 to n-1 loop
                if x(i) = '1' then
                        k = k + 2**i;
                end if;
        end loop;

        if k >= n generate
                res <= zeros;
        end generate;
        
        if k = n generate
                cout <= y(0);
        end generate;


                resMat(0) <= y(n - 2 downto 0) & zeros( 0) when (x(0)= '1' and ALUFN ="00") else                

                                    zeros(0) & y(n - 1 downto 1)  when (x(0)= '1' and ALUFN = "01") else                

                                    y;

                carryVec(0) <= y( n - 1 )  when (x(0)= '1' and ALUFN ="00") else
                                     y(0) when (x(0)= '1' and ALUFN = "01") else
                                     '0';
     loop0: for i in 1 to log_n - 1 generate
                        carryVec(i) <= y( n - 2**i )  when (x(i)= '1' and ALUFN ="00") else
                                     y( 2**i - 1) when (x(i)= '1' and ALUFN = "01") else
                                      carryVec(i-1);

                        resMat(i) <= resMat(i-1)(n - 2**i - 1 downto 0) & zeros( 2**i - 1 downto 0  ) when (x(i)= '1' and ALUFN ="00") else

                                            zeros( 2**i - 1 downto 0 ) & resMat(i-1)( n - 1 downto 2**i)  when (x(i)= '1' and ALUFN = "01") else

                                            resMat(i-1);

                end generate;

                res <= resMat(log_n - 1);
                cout <= carryVec(log_n - 1);

END shifterArch;
