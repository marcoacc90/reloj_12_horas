-- Contadador ascendente modulo 10

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity contador_10 is
	port(
	RST : in std_logic;
	CLK : in std_logic;
	Ei   : in std_logic;						-- habilatacion de entrada
	Q   : out std_logic_vector(3 downto 0);
	Eo  : out std_logic 						-- habilatacion de salida 
	);
end contador_10;

architecture Moore of contador_10 is 
signal Qn,Qp: std_logic_vector(3 downto 0);
begin
secuencial : process(RST,CLK)
	begin  
		if(RST = '0') then
			Qp <= (others => '0');
		elsif (CLK'event and CLK = '1') then --hay transicion de reloj, y es transicion positiva 
			Qp <= Qn;
		end if;
	end process secuencial;	
	
	combinacional : process(Ei,Qp)
	begin
		if (Ei = '0') then 
			Qn <= Qp;					
			Eo <= '0';
		elsif(Qp = "1001") then
			Qn <= "0000";	   
			Eo <= '1';
		else
			Qn <= Qp + 1;
			Eo <= '0';
		end if;
		Q <= Qp;
	end process combinacional;						
end Moore;
	