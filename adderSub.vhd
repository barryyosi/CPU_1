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

