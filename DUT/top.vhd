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
        PORT (  x, y : IN std_logic_vector (n-1 DOWNTO 0);
                ALUFN : IN std_logic_vector(1 downto 0);
                cout : OUT std_logic;
                res : OUT std_logic_vector (n-1 DOWNTO 0)
                );
    end component;


    SIGNAL zeros               : STD_LOGIC_VECTOR(n-1 downto 0);
    SIGNAL AdderSub_x,  AdderSub_y,  AdderSub_res  : STD_LOGIC_VECTOR(n-1 downto 0);
    SIGNAL logic_x,     logic_y,     logic_res     : STD_LOGIC_VECTOR(n-1 downto 0);
    SIGNAL shifter_x,   shifter_y,   shifter_res   : STD_LOGIC_VECTOR(n-1 downto 0);
    SIGNAL AdderSub_cout,   shifter_cout           : STD_LOGIC;
    SIGNAL type_logic, type_shifter, type_addersub: STD_LOGIC;

    CONSTANT zero_vector : STD_LOGIC_VECTOR(n-1 downto 0) := (others => '0');

    BEGIN

    AdderSub_switch_pm: AdderSub_switch port map(
        ALUFN => ALUFN(1 downto 0),
        y => AdderSub_y,
        x => AdderSub_x,
        res => AdderSub_res,
        cout => AdderSub_cout
    );
    logic_pm: logic port map(
        ALUFN => ALUFN(2 downto 0),
        y => logic_y,
        x => logic_x,
        res => logic_res
    );
    shifter_pm: shifter port map(
        ALUFN => ALUFN(1 downto 0),
        y => shifter_y,
        x => shifter_x,
        res => shifter_res,
        cout => shifter_cout
    );


	type_addersub   <= 	'1' when ALUFN(4 downto 3)="01" and ( ALUFN(2 downto 0)="000" or ALUFN(2 downto 0)="001" or ALUFN(2 downto 0)="010" ) else '0';
	type_shifter      <= 	'1' when ALUFN(4 downto 3)="10" and ( ALUFN(2 downto 0)="000" or ALUFN(2 downto 0)="001") else '0';
	type_logic      <= 	'1' when ALUFN(4 downto 3)="11" and ( ALUFN(2 downto 0)="000" or ALUFN(2 downto 0)="001" or ALUFN(2 downto 0)="010" or ALUFN(2 downto 0)="011" or ALUFN(2 downto 0)="100" or ALUFN(2 downto 0)="101" ) else '0';


	AdderSub_x <= x         when type_addersub='1' else UNAFFECTED;
	AdderSub_y <= y         when type_addersub='1' else UNAFFECTED;

	shifter_x <= x         when type_shifter='1' else UNAFFECTED;
	shifter_y <= y         when type_shifter='1' else UNAFFECTED;

	logic_x <= x         when type_logic='1' else UNAFFECTED;
	logic_y <= y         when type_logic='1' else UNAFFECTED;



	WITH ALUFN(4 downto 3) SELECT
        ALUout <=   AdderSub_res when "01",
                    logic_res when "11",
                    shifter_res when "10",
                    UNAFFECTED when others ;

	WITH ALUFN(4 downto 3) SELECT
        Cflag <=    AdderSub_cout when "01",
                    shifter_cout when "10",
                    '0' when "11",
                    UNAFFECTED when others ;

    Nflag <= ALUFN(n-1);
    Zflag <= '1' when ALUFN=zero_vector else '0';


END struct;




