library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
---------------------------------------------------------
entity tb is
	constant n : integer := 8;
	constant k : integer := 3;   -- k=log2(n)
	constant m : integer := 4;   -- m=2^(k-1)
end tb;
------------------------------------------------------------------------------
architecture rtb of tb is
	SIGNAL Y,X:  STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	SIGNAL ALUFN :  STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL ALUout:  STD_LOGIC_VECTOR(n-1 downto 0); -- ALUout[n-1:0]&Cflag
	SIGNAL Nflag,Cflag,Zflag:  STD_LOGIC; -- Zflag,Cflag,Nflag
begin
	L0 : top generic map (n,k,m) port map(Y,X,ALUFN,ALUout,Nflag,Cflag,Zflag);

	--------- start of stimulus section ---------------------------------------
        tb_x_y : process
        begin
          y <= (others => '0');
		  x <= (others => '0');
		  wait for 1 ns;
		  for i in 1 to 12 loop
			x <= x-2;
			y <= 4+y;
			wait for 1 ns;
		  end loop;
		  wait;
        end process;


		tb_ALUFN : process
        begin
		  ALUFN <= "01000";
          wait for 1 ns;
		  for i in 1 to 3 loop
            for j in 1 to 4 loop
			    ALUFN <= ALUFN + 1;
                wait for 1 ns;
		    end loop;
			ALUFN <= ALUFN + 2**3;      -- switch function type
			ALUFN <= ALUFN and "11000"; -- reset 3 LSB bits
			wait for 1 ns;
		  end loop;
		  wait;
        end process;

end architecture rtb;
