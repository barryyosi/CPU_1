LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------
ENTITY AdderSub IS
  GENERIC (n : INTEGER := 8);
  PORT (     sub: IN STD_LOGIC;
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
            cout: OUT STD_LOGIC;
               res: OUT STD_LOGIC_VECTOR(n-1 downto 0));
END AdderSub;
--------------------------------------------------------------
ARCHITECTURE AdderSub_a OF AdderSub IS

component FA is
    PORT (xi, yi, cin: IN std_logic;
              res, cout: OUT std_logic);
end component;
SIGNAL reg,xSub : std_logic_vector(n-1 DOWNTO 0);
BEGIN

    loop1 : for i in 0 to n-1 generate
		xSub(i) <= x(i) xor sub;
    end generate;

	first : FA port map(
			xi => xSub(0),
			yi => y(0),
			cin => sub,
			res => res(0),
			cout => reg(0)
	);

	rest : for i in 1 to n-1 generate
		chain : FA port map(
			xi => xSub(i),
			yi => y(i),
			cin => reg(i-1),
			res => res(i),
			cout => reg(i)
		);
	end generate;

	cout <= reg(n-1);

END AdderSub_a;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------------------------------
ENTITY AdderSub_switch IS
	GENERIC (n : INTEGER := 8);
	PORT (x, y : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	      ALUFN : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			res : OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			cout : OUT std_logic);
END AdderSub_switch;

--------------------------------------
ARCHITECTURE AdderSub_switch_a OF AdderSub_switch IS
	component AdderSub is
		PORT (  sub: 	IN STD_LOGIC;
				x,y: 	IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
				res: 	OUT STD_LOGIC_VECTOR (n-1 downto 0);
				cout: 	OUT STD_LOGIC);
	end component;

	SIGNAL AdderSub_y, zeros : STD_LOGIC_VECTOR(n-1 downto 0);
	SIGNAL AdderSub_sub : STD_LOGIC;

BEGIN

	AdderSub_sub <= ALUFN(0) or ALUFN(1);
	zeros <= (others => '0');

	WITH ALUFN SELECT
	AdderSub_y <= 	y when "00",
					y when "01",
					zeros when "10",
					zeros when others;

	pm: AdderSub port map(
		sub => AdderSub_sub,
		y => AdderSub_y,
		x => x,
		res => res,
		cout => cout
	);

END AdderSub_switch_a;
