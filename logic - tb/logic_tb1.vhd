-- Logic unit Test Bench
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY logic_tb1 IS
END logic_tb1;

ARCHITECTURE logic_tb1_arch OF logic_tb1 IS

COMPONENT logic
    PORT (x, y : IN std_logic;
	           sel: IN std_logic_vector (2 DOWNTO 0); 
			         s: OUT std_logic
			         );
END COMPONENT;

signal x, y, s : std_logic; 
signal sel : std_logic_vector (2 DOWNTO 0);

begin
      tester : logic port map(
                      x=>x, y=>y, sel=>sel, s=>s);
                      
      testbench : process
      begin
         --------- start of stimulus section - ver1 ------------------
        sel <= "000", "001" after 100 ps, "010" after 200 ps, "011" after 300 ps, "100" after 400 ps, "101" after 500 ps,
               "000" after 600 ps, "001" after 700 ps, "010" after 800 ps, "011" after 900 ps, "100" after 1000 ps, "101" after 1100 ps,
               "000" after 1200 ps, "001" after 1300 ps, "010" after 1400 ps, "011" after 1500 ps, "100" after 1600 ps, "101" after 1700 ps,
               "000" after 1800 ps, "001" after 1900 ps, "010" after 2000 ps, "011" after 2100 ps, "100" after 2200 ps, "101" after 2300 ps;
               
        y <= '0', '1' after 600 ps, '0' after 1200 ps, '1' after 1800 ps;
        
        x <= '0', '1' after 1200 ps;
        
        ---------- end of stimulus section----------------------------
          
            wait;
    end process testbench;
    
end logic_tb1_arch;
    
    
      
     
	
