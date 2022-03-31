library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb is
	constant m : integer := 3;
end tb;

architecture rtb of tb is
  component AdderSub is
	GENERIC (n : INTEGER := 3);
	PORT (   sub: IN STD_LOGIC;
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
            cout: OUT STD_LOGIC;
               s: OUT STD_LOGIC_VECTOR(n-1 downto 0));
  end component;
	SIGNAL sub,cout : STD_LOGIC;
	SIGNAL x,y,s : STD_LOGIC_VECTOR (m-1 DOWNTO 0);
begin
	L0 : AdderSub generic map (m) port map(sub,x,y,cout,s);

	--------- start of stimulus section ------------------
        tb : process
        begin
			-- add positive and positive
			x <= "010";
			y <= "000";
			for i in 1 to 10 loop
			  wait for 10 ns;
			  x <= x+1;
			  y <= y+1;
			end loop;

			-- sub negative and positive
			x <= "110";
			y <= (others => '0');
			for i in 1 to 8 loop
			  wait for 10 ns;
			  y <= y + 1;
			end loop;


			-- sub negative and negative
			x <= "001";
			y <= (others => '0');
			for i in 1 to 8 loop
			  wait for 10 ns;
			  y <= y + 1;
			end loop;

		  end process tb;

		tb_sub : process
        begin
		  sub <='0','1' after 100 ns;
		  wait;
        end process tb_sub;

end architecture rtb;
