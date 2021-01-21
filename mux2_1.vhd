library IEEE;
use IEEE.std_logic_1164.all;

entity mux2_1 is
	generic(
		n : integer := 4
	);
	port(
		X0: in std_logic_vector(n-1 downto 0);
		X1: in std_logic_vector(n-1 downto 0);
		S : in std_logic;
		Y : out std_logic_vector(n-1 downto 0)
	);
end mux2_1;

architecture secuencial of mux2_1 is
begin			
	process(X0,X1,S)
	begin
		if (S = '0') then
			Y <= X0;
		else
			Y <= X1;
		end if; 
	end process;
end secuencial;