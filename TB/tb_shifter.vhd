-- shifter unit Test Bench
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY tb_shifter IS
    constant n : integer := 8;
END tb_shifter;

ARCHITECTURE tb_shifter_arch OF tb_shifter IS

COMPONENT shifter
    GENERIC (n : INTEGER := 8);
    PORT (x, y : IN std_logic_vector (n-1 DOWNTO 0);
	        ALUFN : IN std_logic_vector (1 DOWNTO 0);
	        cout : OUT std_logic;
            res : OUT std_logic_vector (n-1 DOWNTO 0)
			);
END COMPONENT;

SIGNAL x, y : std_logic_vector (n-1 DOWNTO 0);
SIGNAL ALUFN : std_logic_vector (1 DOWNTO 0);
SIGNAL res  : std_logic_vector (n-1 DOWNTO 0);
SIGNAL cout : std_logic;

begin
    tester : shifter generic map (n) port map(x, y, ALUFN, cout, res);

    --------- start of stimulus section  ------------------
    testbench : process
    begin
        x <= (others => '0');
		 y <= (others => '0');


        ALUFN <= "00";                   -- left shift testing
        for i in 0 to 5 loop             -- Iterating over x values from 0 to 10
            for i in 0 to 2**5 loop      -- Iterating over y values for each number of shifts
                wait for 10 ns;
                    y <= y + 1;
            end loop;
            x <= x + 1;
        end loop;

        x <= (others => '0');
		y <= (others => '0');

        ALUFN <= "01";                   -- right shift testing
        for i in 0 to 5 loop             -- Iterating over x values from 0 to 10
            for i in 0 to 2**5 loop      -- Iterating over y values for each number of shifts
                wait for 10 ns;
                    y <= y + 1;
            end loop;
            x <= x + 1;
        end loop;
    end process testbench;
        ---------- end of stimulus section  ---------------------------


end tb_shifter_arch;






