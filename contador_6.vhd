-- Contadador ascendente modulo 6

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity contador_6 is
	port(
	RST : in std_logic;
	CLK : in std_logic;
	Ei  : in std_logic;						-- habilatacion de entrada
	Q   : out std_logic_vector(2 downto 0);
	Eo  : out std_logic 						-- habilatacion de salida 
	);
end contador_6;

architecture Moore of contador_6 is 
signal Qn,Qp: std_logic_vector(2 downto 0);
begin
secuencial : process(RST,CLK)
	begin  
		if(RST = '0') then
			Qp <= (others => '0');
		elsif (CLK'event and CLK = '1') then  
			Qp <= Qn;
		end if;
	end process secuencial;	
	
	combinacional : process(Ei,Qp)
	begin
		if (Ei = '0') then 
			Qn <= Qp;					--  va o no va Eo <= '0';
			Eo <= '0';
		elsif(Qp = "101") then
			Qn <= "000";	   
			Eo <= '1';
		else
			Qn <= Qp + 1;
			Eo <= '0';
		end if;
		Q <= Qp;
	end process combinacional;						
end Moore;