LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------
ENTITY AdderSub IS
  GENERIC (n : INTEGER := 4);
  PORT (     sub: IN STD_LOGIC;
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
            cout: OUT STD_LOGIC;
               s: OUT STD_LOGIC_VECTOR(n-1 downto 0));
END AdderSub;
--------------------------------------------------------------
ARCHITECTURE AdderSub_a OF AdderSub IS

component FA is
    PORT (xi, yi, cin: IN std_logic;
              s, cout: OUT std_logic);
end component;
SIGNAL reg,ySub : std_logic_vector(n-1 DOWNTO 0);
BEGIN

    loop1 : for i in 0 to n-1 generate
        ySub(i) <= y(i) xor sub;
    end generate;

	first : FA port map(
			xi => x(0),
			yi => ySub(0),
			cin => sub,
			s => s(0),
			cout => reg(0)
	);

	rest : for i in 1 to n-1 generate
		chain : FA port map(
			xi => x(i),
			yi => ySub(i),
			cin => reg(i-1),
			s => s(i),
			cout => reg(i)
		);
	end generate;

	cout <= reg(n-1);

END AdderSub_a;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------------------------------
ENTITY AdderSub_switch IS
	GENERIC (n : INTEGER := 4);
	PORT (x, y : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	      sel : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			s : OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			cout : OUT std_logic);
END AdderSub_switch;

--------------------------------------
ARCHITECTURE logicUnitArch OF AdderSub_switch IS
	component AdderSub is
		PORT (  sub: 	IN STD_LOGIC;
				x,y: 	IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
				s: 		OUT STD_LOGIC_VECTOR(n-1 downto 0);
				cout: 	OUT STD_LOGIC);
	end component;

	SIGNAL AdderSub_out, AdderSub_x : STD_LOGIC_VECTOR(n-1 downto 0);
	SIGNAL AdderSub_sub : STD_LOGIC;

BEGIN
	AdderSub_sub <= sel(0) or sel(1);

	WITH sel SELECT
	AdderSub_x <= 	x when "000",
					x when "001",
					"0" when "010",
					"0" when others;

	pm: AdderSub port map(
		sub => AdderSub_sub,
		y => y,
		x => AdderSub_x,
		s => AdderSub_out,
		cout => cout
	);

	WITH sel SELECT
	s <= 	AdderSub_out when "000",
			AdderSub_out when "001",
			AdderSub_out when "010",
			x when others;



END logicUnitArch;
