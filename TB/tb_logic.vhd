-- Logic unit Test Bench
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY logic_tb1 IS
    constant n : integer := 3;
END logic_tb1;

ARCHITECTURE logic_tb1_arch OF logic_tb1 IS

COMPONENT logic
    GENERIC (n : INTEGER := 3);
    PORT (x, y : IN std_logic_vector (n-1 DOWNTO 0);
	        ALUFN: IN std_logic_vector (2 DOWNTO 0);
			s: OUT std_logic_vector (n-1 DOWNTO 0)
			         );
END COMPONENT;

SIGNAL x, y, s : std_logic_vector (n-1 DOWNTO 0);
SIGNAL ALUFN : std_logic_vector (2 DOWNTO 0);

begin
    tester : logic  generic map (n) port map(x, y, ALUFN, s);

    --------- start of stimulus section  ------------------
    testbench : process
    begin
        x <= (others => '0');
		y <= (others => '0');
        ALUFN <= (others => '0');

        for i in 0 to 5 loop             -- Iterating over all possible operations, ALUFN := { 000, 001, 010, 011, 100, 101}
            for i in 0 to 7 loop         -- Iterating over x values := {000,001, ..., 111} for each operation
                wait for 100 ns;

                for i in 0 to 7 loop     -- Iterating over y values := {000,001, ..., 111} for each x value
                    wait for 50 ns;
                    y <= y+1;
                end loop;

                y <= (others => '0');    -- nullifying y in order to test with next x value
                x <= x+1;

            end loop;
            x <= (others => '0');        -- nullifying x in order to test next operation
            ALUFN <= ALUFN+1;
        end loop;
    end process testbench;
        ---------- end of stimulus section  ---------------------------


end logic_tb1_arch;





