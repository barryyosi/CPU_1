LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.math_real.all;
--------------------------------------
ENTITY shifter IS
	GENERIC (n : INTEGER := 8;
	         k : INTEGER := 3); -- k = log2(n)
	PORT (x, y : IN std_logic_vector (n-1 DOWNTO 0);
	        ALUFN : IN std_logic_vector (1 DOWNTO 0);
	        cout : OUT std_logic;
                res : OUT std_logic_vector (n-1 DOWNTO 0)
	        );
END shifter;
--------------------------------------
ARCHITECTURE shifterArch OF shifter IS

------------- signals declare --------------

        type vectorArr is array (0 to k - 1) of std_logic_vector ( n - 1 downto 0);
        constant zeros : std_logic_vector (n-1 DOWNTO 0 ) := (others => '0');
        signal resMat: vectorArr;     -- log(n)Xn matrix
        signal carryVec : std_logic_vector (0 to k - 1);

BEGIN

------------- init for the first iteration --------------
        resMat(0) <= y(n - 2 downto 0) & zeros(0) when (x(0)= '1' and ALUFN ="00") else
                                zeros(0) & y(n - 1 downto 1)  when (x(0)= '1' and ALUFN = "01") else
                                y;

        carryVec(0) <= y( n - 1 )  when (x(0)= '1' and ALUFN ="00") else
                                y(0) when (x(0)= '1' and ALUFN = "01") else
                                '0';

------------- save each resulte in the matching vector in the metrix --------------
        loop0: for i in 1 to k - 1 generate
                carryVec(i) <=  resMat(i-1)( n - 2**i )  when (x(i)= '1' and ALUFN ="00") else
                                resMat(i-1)( 2**i - 1) when (x(i)= '1' and ALUFN = "01") else
                                carryVec(i-1);

                resMat(i) <= resMat(i-1)(n - 2**i - 1 downto 0) & zeros( 2**i - 1 downto 0  ) when (x(i)= '1' and ALUFN ="00") else
                                        zeros( 2**i - 1 downto 0 ) & resMat(i-1)( n - 1 downto 2**i)  when (x(i)= '1' and ALUFN = "01") else
                                        resMat(i-1);

        end generate;

------------- wire up output --------------
        res <= resMat(k - 1);
        cout <= carryVec(k - 1);

END shifterArch;
