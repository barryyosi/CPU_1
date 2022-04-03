LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY top IS
  GENERIC (n : INTEGER := 8;
		   k : integer := 3;   -- k=log2(n)
		   m : integer := 4	); -- m=2^(k-1)
  PORT (  Y,X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  ALUout: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		  Nflag,Cflag,Zflag: OUT STD_LOGIC ); -- Zflag,Cflag,Nflag
END top;
------------- complete the top Architecture code --------------
ARCHITECTURE struct OF top IS


    component AdderSub_switch is
        PORT (  x, y : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
                sel : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                s : OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
                cout : OUT std_logic);
    end component;


    component logic is
        PORT (  x, y : IN std_logic_vector (n-1 DOWNTO 0);
                sel : IN std_logic_vector (2 DOWNTO 0);
                s : OUT std_logic_vector (n-1 DOWNTO 0)
                );
    end component;

    component shifter is
        PORT (x, y : IN std_logic_vector (n-1 DOWNTO 0);
                dir : IN std_logic; -- change to sel
                cout : OUT std_logic; -- change to s
                    S : OUT std_logic_vector (n-1 DOWNTO 0)
                );
    end component;


    SIGNAL sel, zeros               : STD_LOGIC_VECTOR(n-1 downto 0);
    SIGNAL AdderSub_x,  AdderSub_y,  AdderSub_s  : STD_LOGIC_VECTOR(n-1 downto 0);
    SIGNAL logic_x,     logic_y,     logic_s     : STD_LOGIC_VECTOR(n-1 downto 0);
    SIGNAL shifter_x,   shifter_y,   shifter_s   : STD_LOGIC_VECTOR(n-1 downto 0);
    SIGNAL AdderSub_cout,   logic_cout,   shifter_cout   : STD_LOGIC;

    CONSTANT zero_vector : STD_LOGIC_VECTOR(n-1 downto 0) := (others => '0');

    BEGIN

    AdderSub_switch_pm: AdderSub_switch port map(
        sel => sel(1 downto 0),
        y => AdderSub_y,
        x => AdderSub_x,
        s => AdderSub_s,
        cout => AdderSub_cout
    );
    logic_pm: logic port map(
        sel => sel(2 downto 0),
        y => logic_y,
        x => logic_x,
        s => logic_s
    );
    shifter_pm: shifter port map(
        sel => sel(1 downto 0),
        y => shifter_y,
        x => shifter_x,
        s => shifter_s,
        cout => shifter_cout
    );

	WITH sel(4 downto 3) SELECT
	AdderSub_x <= 	x when "01",
                    UNAFFECTED when others;

	WITH sel(4 downto 3) SELECT
	logic_x  <= 	x when "11",
                    UNAFFECTED when others;

	WITH sel(4 downto 3) SELECT
	shifter_x <= 	x when "10",
                    UNAFFECTED when others;


	WITH sel(4 downto 3) SELECT
	AdderSub_y <= 	y when "01",
                    UNAFFECTED when others;

	WITH sel(4 downto 3) SELECT
	logic_y  <= 	y when "11",
                    UNAFFECTED when others;

	WITH sel(4 downto 3) SELECT
	shifter_y <= 	y when "10",
                    UNAFFECTED when others;


	WITH sel(4 downto 3) SELECT
        s <= AdderSub_s when "01",
        s <= logic_s when "11",
        s <= shifter_s when "10",
        s <= UNAFFECTED;


	WITH sel(4 downto 3) SELECT
        Cflag <= AdderSub_cout when "01",
        Cflag <= '0' when "11",
        Cflag <= shifter_cout when "10",
        Cflag <= UNAFFECTED;

    Nflag <= s(n-1);
    Zflag <= '1' when s=zero_vector else '0'


END struct;




