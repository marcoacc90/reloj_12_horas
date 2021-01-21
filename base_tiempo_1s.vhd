library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity base_tiempo is
	generic (
		n : integer := 4
	);
	port(
	RST : in std_logic;
	CLK : in std_logic;
	B   : in std_logic_vector(n-1 downto 0);
	T0  : out std_logic
	);
end base_tiempo;

architecture Tiempo of base_tiempo is 
signal Qn,Qp: std_logic_vector(n-1 downto 0);
signal C  : std_logic_vector(n-1 downto 0);
begin
secuencial : process(RST,CLK)
	begin  
		if(RST = '0') then
			Qp <= (others => '0');
		elsif (CLK'event and CLK = '1') then --hay transicion de reloj, y es transicion positiva 
			Qp <= Qn;
		end if;
	end process secuencial;
	combinacional : process(Qp,C,B)
	begin	  
		C <= (others => '0');
		if (Qp = C) then 
			Qn <= B;
			T0 <= '1';
		else
			Qn <= Qp - 1;
			T0 <= '0'; 
		end if;
	end process combinacional;
end Tiempo;