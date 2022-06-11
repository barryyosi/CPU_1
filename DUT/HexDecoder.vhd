LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
	--------------------------------------------
ENTITY HexDecoder IS
  PORT (  BinaryIn			:IN STD_LOGIC_VECTOR (3 DOWNTO 0); 	-- n/2
		    HexOut			:OUT STD_LOGIC_VECTOR(6 downto 0) 
		);
END HexDecoder;

ARCHITECTURE struct OF HexDecoder IS 
BEGIN	

	HexOut	<=  "1000000" when BinaryIn = "0000" else	-- 0
				"1111001" when BinaryIn = "0001" else	-- 1
				"0100100" when BinaryIn = "0010" else	-- 2
				"0110000" when BinaryIn = "0011" else	-- 3
				"0011001" when BinaryIn = "0100" else	-- 4
				"0010010" when BinaryIn = "0101" else	-- 5
				"0000010" when BinaryIn = "0110" else	-- 6
				"1111000" when BinaryIn = "0111" else	-- 7
				"0000000" when BinaryIn = "1000" else	-- 8
				"0010000" when BinaryIn = "1001" else	-- 9
				"0001000" when BinaryIn = "1010" else	-- A
				"0000011" when BinaryIn = "1011" else	-- B
				"1000110" when BinaryIn = "1100" else	-- C
				"0100001" when BinaryIn = "1101" else	-- D
				"0000110" when BinaryIn = "1110" else	-- E
				"0001110" when BinaryIn = "1111" else	-- F
				"1111111"; -- 
			
END struct;			