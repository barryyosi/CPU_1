-- Test Bench for Counter.
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity tb_ver3 is
end tb_ver3;

architecture rtl of tb_ver3 is  

component FA
	PORT (a, b, cin: IN std_logic;
			s, cout: OUT std_logic);
end component;
signal  a, b, cin, s, cout : std_logic;
begin
        tester : FA port map(
			a=>a,b=>b,cin=>cin,s=>s,cout=>cout
		);
        --------- start of stimulus section - ver3 ------------------	
        tb_b : process
        begin
		  b <= '0';
		  wait for 50 ns;
		  b <= not b; 
		  wait for 50 ns;
        end process tb_b;
		
		tb_a : process
        begin
		  a <= '0';
		  wait for 100 ns;
		  a <= not a; 
		  wait for 100 ns;
        end process tb_a;
		  
		tb_cin : process
        begin
		  cin <='0','1' after 200 ns;
		  wait;
        end process tb_cin; 
        
end rtl;
