library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
---------------------------------------------------------
entity PREF_TOP is

	port( clk: IN STD_LOGIC );


	PORT (  regY, regX: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		regALUFN : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		ALUout: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Nflag,Cflag,Zflag: OUT STD_LOGIC;
		clk: IN STD_LOGIC
	); -- Zflag,Cflag,Nflag

end PREF_TOP;
------------------------------------------------------------------------------
architecture top_arch of PREF_TOP is

	constant n : integer := 8;
	constant k : integer := 3;   -- k=log2(n)
	constant m : integer := 4;   -- m=2^(k-1).


begin

	L0 : top generic map (n,k,m) port map(regY_reg,regX_reg,regALUFN_reg,ALUout_reg,Nflag_reg,Cflag_reg,Zflag_reg);

	--L0 : top generic map (n,k,m) port map(regY,regX,regALUFN,ALUout,Nflag,Cflag,Zflag);

	PROC : process(clk)
	begin
		if(rising_edge(clk)) then
			regY_reg		<=  regY		;
			regX_reg		<=  regX		;
			regALUFN_reg	<=  regALUFN	;
			ALUout_reg		<=  ALUout		;
			Nflag_reg		<=  Nflag		;
			Cflag_reg		<=  Cflag		;
			Zflag_reg		<=  Zflag		;
		end if;


	end process;

end architecture top_arch;
