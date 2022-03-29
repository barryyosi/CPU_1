-- Logic unit Test Bench
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY logic_tb1 IS
END logic_tb1;

ARCHITECTURE logic_tb1_arch OF logic _tb1 IS

COMPONENT logic
    PORT (x, y, : IN std_logic;
	           sel: IN std_logic_vector (2 DOWNTO 0); 
			         s: OUT std_logic);
END COMPONENT;

--signal x, y, s : std_logic; 
--         sel : std_logic_vector;

begin
      tester : logic port map(
                      x=>x, y=>y, sel=>sel, s=>s);
                      
      testbench : process
      begin
         --------- start of stimulus section - ver1 ------------------
        sel <= "000", "001" after 100 ns, "010" after 200 ns, "011" after 300ns, "100" after 400 ns, "101" after 500 ns;
        
        x <= '0', '1' after 500ns, '0' after 1000ns, '1' after 1500ns;
        y <= '0', '1' after 1000ns;
        
        ---------- end of stimulus section----------------------------
          
            wait;
    end process testbench;
    
end logic_tb1_arch;
    
    
      
     
	