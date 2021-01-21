-- Decodificador BCD a 7 segmentos
-- Los exhibidores tienen logica negativo
-- Representar con bits los guarismos del sistema decimal 

library IEEE;
use IEEE.std_logic_1164.all;

entity bcd_to_7seg3b is
	port(
	B : in std_logic_vector(2 downto 0);
	S : out std_logic_vector(1 to 7)
	);
end bcd_to_7seg3b;

architecture tabla of bcd_to_7seg3b is
begin
	process(B)
	begin
		case B is
			when "000" => S <= "0000001";
			when "001" => S <= "1001111";
			when "010" => S <= "0010010";
			when "011" => S <= "0000110";
			when "100" => S <= "1001100";
			when "101" => S <= "0100100";
			when "110" => S <= "0100000";
			when others => S <= "0001101";			
		end case;
	end process;
end tabla;