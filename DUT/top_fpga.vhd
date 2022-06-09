library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
---------------------------------------------------------
entity test1 is
	constant n : integer := 16;
	constant k : integer := 4;   -- k=log2(n)
	constant m : integer := 8;   -- m=2^(k-1)
	constant IcacheSize : integer := 13-1;
	constant InputSize : integer := IcacheSize*2;
end test1;
------------------------------------------------------------------------------
architecture rtb of test1 is
	type mem is array (0 to IcacheSize) of std_logic_vector(4 downto 0);
	SIGNAL Y,X:  STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	SIGNAL ALUFN :  STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL ALUout:  STD_LOGIC_VECTOR(n-1 downto 0); -- ALUout[n-1:0]&Cflag
	SIGNAL Nflag,Cflag,Zflag:  STD_LOGIC; -- Zflag,Cflag,Nflag
	SIGNAL Icache : mem := ("01000","01001","01010","10000","10001","00000",
							"11000","11001","11010","00011","11011","11100","11101");
begin
	L0 : top generic map (n,k,m) port map(Y,X,ALUFN,ALUout,Nflag,Cflag,Zflag);


end architecture rtb;
