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
                ALUFN : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                res : OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
                cout : OUT std_logic);
    end component;


    component logic is
        PORT (  x, y : IN std_logic_vector (n-1 DOWNTO 0);
                ALUFN : IN std_logic_vector (2 DOWNTO 0);
                res : OUT std_logic_vector (n-1 DOWNTO 0)
                );
    end component;

    component shifter is
        PORT (x, y : IN std_logic_vector (n-1 DOWNTO 0);
                dir : IN std_logic; -- change to ALUFN
                cout : OUT std_logic; -- change to s
                    res : OUT std_logic_vector (n-1 DOWNTO 0)
                );
    end component;


    SIGNAL ALUFN, zeros               : STD_LOGIC_VECTOR(n-1 downto 0);
    SIGNAL AdderSub_x,  AdderSub_y,  AdderSub_res  : STD_LOGIC_VECTOR(n-1 downto 0);
    SIGNAL logic_x,     logic_y,     logic_res     : STD_LOGIC_VECTOR(n-1 downto 0);
    SIGNAL shifter_x,   shifter_y,   shifter_res   : STD_LOGIC_VECTOR(n-1 downto 0);
    SIGNAL AdderSub_cout,   logic_cout,   shifter_cout   : STD_LOGIC;

    CONSTANT zero_vector : STD_LOGIC_VECTOR(n-1 downto 0) := (others => '0');

    BEGIN

    AdderSub_switch_pm: AdderSub_switch port map(
        ALUFN => ALUFN(1 downto 0),
        y => AdderSub_y,
        x => AdderSub_x,
        res => AdderSub_s,
        cout => AdderSub_cout
    );
    logic_pm: logic port map(
        ALUFN => ALUFN(2 downto 0),
        y => logic_y,
        x => logic_x,
        res => logic_s
    );
    shifter_pm: shifter port map(
        ALUFN => ALUFN(1 downto 0),
        y => shifter_y,
        x => shifter_x,
        res => shifter_s,
        cout => shifter_cout
    );

	WITH ALUFN(4 downto 3) SELECT
	AdderSub_x <= 	x when "01",
                    UNAFFECTED when others;

	WITH ALUFN(4 downto 3) SELECT
	logic_x  <= 	x when "11",
                    UNAFFECTED when others;

	WITH ALUFN(4 downto 3) SELECT
	shifter_x <= 	x when "10",
                    UNAFFECTED when others;


	WITH ALUFN(4 downto 3) SELECT
	AdderSub_y <= 	y when "01",
                    UNAFFECTED when others;

	WITH ALUFN(4 downto 3) SELECT
	logic_y  <= 	y when "11",
                    UNAFFECTED when others;

	WITH ALUFN(4 downto 3) SELECT
	shifter_y <= 	y when "10",
                    UNAFFECTED when others;


	WITH ALUFN(4 downto 3) SELECT
        ALUout <=   AdderSub_s when "01",
                    logic_s when "11",
                    shifter_s when "10",
                    UNAFFECTED;


	WITH ALUFN(4 downto 3) SELECT
        Cflag <=    AdderSub_cout when "01",
                    '0' when "11",
                    shifter_cout when "10",
                    UNAFFECTED;

    Nflag <= s(n-1);
    Zflag <= '1' when s=zero_vector else '0'


END struct;




