-- Test Bench for Counter.
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity tb_ver1 is
end tb_ver1;

architecture rtl of tb_ver1 is  

component FA
	PORT (a, b, cin: IN std_logic;
			s, cout: OUT std_logic);
end component;
signal  a, b, cin, s, cout : std_logic;
begin
        tester : FA port map(
			a=>a,b=>b,cin=>cin,s=>s,cout=>cout
		);
        
        testbench : process
        begin
          --------- start of stimulus section - ver1 ------------------
          b <='0','1' after 50 ns,'0' after 100 ns,'1' after 150 ns,'0' after 200 ns,'1' after 250 ns,'0' after 300 ns,'1' after 350 ns;
		  a <='0','1' after 100 ns,'0' after 200 ns,'1' after 300 ns,'0' after 400 ns;
		  cin <='0', '1' after 200 ns;
          --------- end of stimulus section----------------------------
		  wait;
        end process testbench;
        
end rtl;
