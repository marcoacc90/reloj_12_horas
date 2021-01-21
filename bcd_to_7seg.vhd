-- Decodificador BCD a 7 segmentos
-- Los exhibidores tienen logica negativo
-- Representar con bits los guarismos del sistema decimal 

library IEEE;
use IEEE.std_logic_1164.all;

entity bcd_to_7seg is
	port(
	B : in std_logic_vector(3 downto 0);
	S : out std_logic_vector(1 to 7)
	);
end bcd_to_7seg;

architecture tabla of bcd_to_7seg is
begin
	process(B)
	begin
		case B is
			when "0000" => S <= "0000001";
			when "0001" => S <= "1001111";
			when "0010" => S <= "0010010";
			when "0011" => S <= "0000110";
			when "0100" => S <= "1001100";
			when "0101" => S <= "0100100";
			when "0110" => S <= "0100000";
			when "0111" => S <= "0001101";
			when "1000" => S <= "0000000";
			when "1001" => S <= "0000100";
			when others => S <= (others => '1');			
		end case;
	end process;
end tabla;