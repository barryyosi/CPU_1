library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb is
	constant m : integer := 8;
end tb;

architecture rtb of tb is
  component AdderSub_switch is
	GENERIC (n : INTEGER := 8);
	PORT (x, y : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			res : OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			cout : OUT std_logic);
  end component;
	SIGNAL x,y,res : STD_LOGIC_VECTOR (m-1 DOWNTO 0);
	SIGNAL ALUFN : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL cout : STD_LOGIC;
begin
	L0 : AdderSub_switch generic map (m)
		port map(x,y,ALUFN,res,cout);

	--------- start of stimulus section ------------------
        tb : process
        begin

			x <= (others => '0');
			y <= (others => '0');
			ALUFN <= (others => '0');
			wait for 1 ns;
			for i in 1 to 4 loop
				for i in 1 to 8 loop
					for i in 1 to 8 loop
						y <= y+1;
						wait for 1 ns;
					end loop;
					x <= x+1;
					wait for 1 ns;
				end loop;
				ALUFN <= ALUFN+1;
				wait for 1 ns;
			end loop;
			wait;

			end process tb;

end architecture rtb;
