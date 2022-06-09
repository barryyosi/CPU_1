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

	HexOut	<=  "1000000" when BinaryIn = "0000" else
				"1111001" when BinaryIn = "0001" else
				"0100100" when BinaryIn = "0010" else
				"0110000" when BinaryIn = "0011" else
				"0011001" when BinaryIn = "0100" else
				"0010010" when BinaryIn = "0101" else
				"0000010" when BinaryIn = "0110" else
				"1111000" when BinaryIn = "0111" else
				"0000000" when BinaryIn = "1000" else
				"0010000" when BinaryIn = "1001" else
				"0001000" when BinaryIn = "1010" else
				"0000011" when BinaryIn = "1011" else
				"1000110" when BinaryIn = "1100" else
				"0100001" when BinaryIn = "1101" else
				"0000110" when BinaryIn = "1110" else
				"0001110" when BinaryIn = "1111" else
				"1111111";
			
END struct;			