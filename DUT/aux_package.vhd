library IEEE;
use ieee.std_logic_1164.all;

package aux_package is
--------------------------------------------------------
	component top is
	GENERIC (n : INTEGER := 8;
		   k : integer := 3;   -- k=log2(n)
		   m : integer := 4	); -- m=2^(k-1)
  PORT (  Y,X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  ALUout: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		  Nflag,Cflag,Zflag: OUT STD_LOGIC ); -- Zflag,Cflag,Nflag
	end component;
---------------------------------------------------------
	component FA is
		PORT (xi, yi, cin: IN std_logic;
			      s, cout: OUT std_logic);
	end component;
---------------------------------------------------------


component HexDecoder is
		PORT (  BinaryIn			:IN STD_LOGIC_VECTOR (3 DOWNTO 0); 	-- n/2
				HexOut			:OUT STD_LOGIC_VECTOR(6 downto 0)
		);
end component;













end aux_package;



