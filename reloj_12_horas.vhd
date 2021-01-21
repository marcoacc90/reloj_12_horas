-- Reloj de 12 horas con exhibidores de 7 segmentos
-- Las horas-minutos o segundos son seleccionados con un multiplexor 
library IEEE;
use IEEE.std_logic_1164.all;

entity reloj_12_horas is					  
	port(
	RST : in std_logic;
	CLK : in std_logic;
	S   : in std_logic;	-- Selector
	Se  : in std_logic;	--selector de base
	Y0  : out std_logic_vector(1 to 7);     -- Resultado del exhibidor 1
	Y1  : out std_logic_vector(1 to 7);     -- Resultado del exhibidor 2
	Y2  : out std_logic_vector(1 to 7);     -- Resultado del exhibidor 3
	Y3  : out std_logic_vector(1 to 7)      -- Resultado del exhibidor 4 
	);
end reloj_12_horas;
												  									  
architecture Completa of reloj_12_horas is
component contador_10
	port(
	RST : in std_logic;
	CLK : in std_logic;
	Ei  : in std_logic;				
	Q   : out std_logic_vector(3 downto 0);
	Eo  : out std_logic 				 
	);
end component;
component contador_6
	port(
	RST : in std_logic;
	CLK : in std_logic;
	Ei  : in std_logic;						
	Q   : out std_logic_vector(2 downto 0);
	Eo  : out std_logic 						
	);
end component;

component secuenciador_12h
	port(
	RST : in std_logic;
	CLK : in std_logic;
	Ei  : in std_logic;
	Q   : out std_logic_vector(4 downto 0)
	);
end component;

component base_tiempo
	generic(
		n : integer := 4
	);
	port(
	RST : in std_logic;
	CLK : in std_logic;
	B   : in std_logic_vector(n-1 downto 0);
	T0  : out std_logic
	);
end component;	

component mux2_1
	generic(
		n : integer := 4
	);
	port(
	X0 : in std_logic_vector(n-1 downto 0);
	X1 : in std_logic_vector(n-1 downto 0);
	S  : in std_logic;
	Y  : out std_logic_vector(n-1 downto 0) 
	);
end component;

component bcd_to_7seg
	port(
	B : in std_logic_vector(3 downto 0);
	S : out std_logic_vector(1 to 7)
	);
end component;	

component bcd_to_7seg2
	port(
	B  : in std_logic_vector(4 downto 0);
	S1 : out std_logic_vector(1 to 7);
	S2 : out std_logic_vector(1 to 7)
	);
end component;	   

component bcd_to_7seg3b
	port(
	B : in std_logic_vector(2 downto 0);
	S : out std_logic_vector(1 to 7)
	);
end component;

signal T0,Eos,Eom  : std_logic;                    -- Habilitaciones: base,segundos,minutos
signal Eos2,Eom2   : std_logic;                    -- Habilitaciones: base,segundos,minutos
signal u_s,u_m     : std_logic_vector(3 downto 0); -- unidades de segundo y unidades de minuto
signal d_s,d_m     : std_logic_vector(2 downto 0); -- decenas de segundo y decenas de minuto
signal Q           : std_logic_vector(4 downto 0); -- horas	
signal Exhibidor0 : std_logic_vector(3 downto 0);  -- Tiempo seleccionado para ser exhibido
signal Exhibidor1 : std_logic_vector(2 downto 0);
signal Exhibidor23: std_logic_vector(4 downto 0);
signal B 		   : std_logic_vector(25 downto 0);

begin
	DUT01 : contador_10 port map(RST,CLK,T0,u_s,Eos);				-- Segundos
	DUT02 : contador_6  port map(RST,CLK,Eos,d_s,Eos2);
	DUT03 : contador_10 port map(RST,CLK,Eos2,u_m,Eom);				-- Minutos
	DUT04 : contador_6  port map(RST,CLK,Eom,d_m,Eom2);		
	DUT05 : secuenciador_12h port map(RST,CLK,Eom2,Q);				-- Horas
	DUT   : mux2_1 generic map(26) port map("10111110101111000001111111","00000000001100001101010000",Se,B);
	DUT06 : base_tiempo generic map(26) port map(RST,CLK,B,T0);  					-- Base de tiempo de segundo						  
	DUT07 : mux2_1 generic map(4) port map(u_m,u_s,S,Exhibidor0);	-- Seleccionar entre minutos o segundos
	DUT08 : mux2_1 generic map(3) port map(d_m,d_s,S,Exhibidor1);
	DUT09 : mux2_1 generic map(5) port map(Q,"01111",S,Exhibidor23); -- Seleccionar entre visualizar horas o no
	DUT10 : bcd_to_7seg   port map(Exhibidor0,Y0);					 -- Decodificar la hora a 7 segmentos
	DUT11 : bcd_to_7seg3b port map(Exhibidor1,Y1);
	DUT12 : bcd_to_7seg2  port map(Exhibidor23,Y2,Y3);
end Completa;		   
