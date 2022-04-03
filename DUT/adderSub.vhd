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
SIGNAL reg,ySub : std_logic_vector(n-1 DOWNTO 0);
BEGIN

    loop1 : for i in 0 to n-1 generate
        ySub(i) <= y(i) xor sub;
    end generate;

	first : FA port map(
			xi => x(0),
			yi => ySub(0),
			cin => sub,
			res => res(0),
			cout => reg(0)
	);

	rest : for i in 1 to n-1 generate
		chain : FA port map(
			xi => x(i),
			yi => ySub(i),
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
				res: 		OUT STD_LOGIC_VECTOR (n-1 downto 0);
				cout: 	OUT STD_LOGIC);
	end component;

	SIGNAL AdderSub_out, AdderSub_x, high_z, zeros : STD_LOGIC_VECTOR(n-1 downto 0);
	SIGNAL AdderSub_sub, AdderSub_cout  : STD_LOGIC;
	CONSTANT zero_vector : STD_LOGIC_VECTOR(n-1 downto 0) := (others => '0');

BEGIN

	AdderSub_sub <= ALUFN(0) or ALUFN(1);
	high_z <= (others => 'Z');
	zeros <= (others => '0');

	WITH ALUFN SELECT
	AdderSub_x <= 	x when "00",
					x when "01",
					zeros when others;

	res <=	AdderSub_out  when ALUFN /= "11" and x /= high_z else high_z;
	cout <=	AdderSub_cout when ALUFN /= "11" and x /= high_z else 'Z';

	pm: AdderSub port map(
		sub => AdderSub_sub,
		y => y,
		x => AdderSub_x,
		res => AdderSub_out,
		cout => AdderSub_cout
	);

END AdderSub_switch_a;
