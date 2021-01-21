-- Decodificador BCD a 7 segmentos dos salidas

library IEEE;
use IEEE.std_logic_1164.all;

entity bcd_to_7seg2 is
	port(
	B  : in std_logic_vector(4 downto 0);
	S1 : out std_logic_vector(1 to 7);
	S2 : out std_logic_vector(1 to 7)
	);
end bcd_to_7seg2;

architecture tabla of bcd_to_7seg2 is
begin
	process(B)
	begin
		if(B(4) = '1') then
			S2 <= "1001111"; 
		else
			S2 <= "1111111";
		end if;
		case B(3 downto 0) is
			when "0000" => S1 <= "0000001";
			when "0001" => S1 <= "1001111";
			when "0010" => S1 <= "0010010";
			when "0011" => S1 <= "0000110";
			when "0100" => S1 <= "1001100";
			when "0101" => S1 <= "0100100";
			when "0110" => S1 <= "0100000";
			when "0111" => S1 <= "0001101";
			when "1000" => S1 <= "0000000";
			when "1001" => S1 <= "0000100";
			when others => S1 <= (others => '1');			
		end case;
	end process;
end tabla;