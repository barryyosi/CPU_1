library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
---------------------------------------------------------
entity FPGA_TOP is
	constant n : integer := 8;
	constant k : integer := 3;   -- k=log2(n)
	constant m : integer := 4;   -- m=2^(k-1)
	
	PORT( SW0_7: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		  KEY0,KEY1,KEY2: IN STD_LOGIC; 
		  ALUout: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		  Nflag,Cflag,Zflag: OUT STD_LOGIC );
		  
		  
end FPGA_TOP;
------------------------------------------------------------------------------
architecture top_arch of FPGA_TOP is

	SIGNAL regY, regX: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL regALUFN: STD_LOGIC_VECTOR (4 DOWNTO 0);
	
	
begin
	
	if (KEY0 = '1') then
		regY <= SW0_7;
	end if;
	if (KEY1 = '1') then
		ALUFN <= SW0_7(4 downto 0);
	end if;
	if (KEY2 = '1') then
		regX <= SW0_7;
	end if;
			
	HEX2: HexDecoder port map ( BinaryIn => , HexOut => );
	HEX3: HexDecoder port map ( BinaryIn => , HexOut => );
	
	HEXDECODE: HexDecoder port map ( BinaryIn => , HexOut => );
	HEXDECODE: HexDecoder port map ( BinaryIn => , HexOut => );
	L0 : top generic map (n,k,m) port map(regY,regX,ALUFN,ALUout,Nflag,Cflag,Zflag);


end architecture top_arch;
