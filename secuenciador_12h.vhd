-- Secuenciador 12h

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity secuenciador_12h is 
	port(
	RST : in std_logic;
	CLK : in std_logic;
	Ei  : in std_logic;
	Q   : out std_logic_vector(4 downto 0)
	);
end secuenciador_12h;

architecture Moore of secuenciador_12h is
signal Qn, Qp : std_logic_vector(3 downto 0);

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
		case Qp is
			when "0000"	=>
			if Ei = '0' then 
				Qn <= Qp;
			else
				Qn <= "0001";
			end if;
			Q <= "10010";
			
			when "0001"	=>
			if Ei = '0' then 
				Qn <= Qp;
			else
				Qn <= "0010";
			end if;
			Q <= "00001";
			
			when "0010"	=>
			if Ei = '0' then 
				Qn <= Qp;
			else
				Qn <= "0011";
			end if;
			Q <= "00010";
			
			when "0011"	=>
			if Ei = '0' then 
				Qn <= Qp;
			else
				Qn <= "0100";
			end if;
			Q <= "00011";
			
			when "0100" =>
			if Ei = '0' then 
				Qn <= Qp;
			else
				Qn <= "0101";
			end if;
			Q <= "00100";
			
			when "0101" =>
			if Ei = '0' then 
				Qn <= Qp;
			else
				Qn <= "0110";
			end if;
			Q <= "00101";
			
			when "0110" =>
			if Ei = '0' then 
				Qn <= Qp;
			else
				Qn <= "0111";
			end if;
			Q <= "00110";
			
			when "0111" =>
			if Ei = '0' then 
				Qn <= Qp;
			else
				Qn <= "1000";
			end if;
			Q <= "00111";
			
			when "1000" =>
			if Ei = '0' then 
				Qn <= Qp;
			else
				Qn <= "1001";
			end if;
			Q <= "01000";
			
			when "1001" =>
			if Ei = '0' then 
				Qn <= Qp;
			else
				Qn <= "1010";
			end if;
			Q <= "01001";
			
			when "1010" =>
			if Ei = '0' then 
				Qn <= Qp;
			else
				Qn <= "1011";
			end if;
			Q <= "10000";
			
			when "1011" =>
			if Ei = '0' then 
				Qn <= Qp;
			else
				Qn <= "1100";
			end if;
			Q <= "10001";
			
			when others => 
			Qn <= "0000";
			Q <= "10001";
		end case;
	end process combinacional;	
end Moore;