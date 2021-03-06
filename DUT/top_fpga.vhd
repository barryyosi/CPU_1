library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
---------------------------------------------------------
entity FPGA_TOP is

	port( clk: in std_LOGIC;
			SW0_7: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		   KEY0,KEY3,KEY2: IN STD_LOGIC;
		   LEDR : out STD_LOGIC_VECTOR (9 DOWNTO 0);
		   LEDG : out STD_LOGIC_VECTOR (7 DOWNTO 0);
		   HEX0, HEX1, HEX2, HEX3: out STD_LOGIC_VECTOR (6 DOWNTO 0) );


end FPGA_TOP;
------------------------------------------------------------------------------
architecture top_arch of FPGA_TOP is

	constant n : integer := 8;
	constant k : integer := 3;   -- k=log2(n)
	constant m : integer := 4;   -- m=2^(k-1).
	
	
	SIGNAL regY, regX: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL regALUFN : STD_LOGIC_VECTOR (4 DOWNTO 0);

	SIGNAL ALUout: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	SIGNAL Nflag,Cflag,Zflag: STD_LOGIC;

begin

	L0: top generic map (n,k,m) port map (regY,regX,regALUFN,ALUout,Nflag,Cflag,Zflag);
	
	HexDecoder2_PM: HexDecoder port map (regY(3 downto 0),HEX2);
		
	HexDecoder3_PM: HexDecoder port map (regY(7 downto 4),HEX3);
	
	HexDecoder0_PM: HexDecoder port map (regX(3 downto 0),HEX0);
	
	HexDecoder1_PM: HexDecoder port map (regX(7 downto 4),HEX1);
	
	LEDR(9 downto 5) <= regALUFN;
	
	inputRegister: process(clk, KEY0, KEY3, KEY2)
	begin
		if (rising_edge(clk)) then
			if (KEY0='0') then
				regY	<= SW0_7;
			end if;
			if (KEY3='0') then
			regALUFN	<= SW0_7(4 downto 0); 
			end if;
			if (KEY2='0') then
				regX	<= SW0_7;
			end if;
		end if;
	end process;
	
	
	outputRegister: process (clk)
	begin
		if(rising_edge(clk)) then
			
			LEDR(2) <= Zflag;
			LEDR(1) <= Cflag;
			LEDR(0) <= Nflag;
			LEDG <= ALUout;
		end if;
	end process;
	
end architecture top_arch;
