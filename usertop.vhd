library IEEE;
use IEEE.Std_Logic_1164.all;


entity usertop is
port(
	CLOCK_50:	in std_logic;
	CLK_500Hz:	in std_logic;
	RKEY:		in std_logic_vector(3 downto 0);
	KEY:		in std_logic_vector(3 downto 0);
	RSW:		in std_logic_vector(17 downto 0);
	SW:		in std_logic_vector(17 downto 0);
	LEDR:		out std_logic_vector(17 downto 0);
	HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7	: out std_logic_vector(6 downto 0)
	);
end usertop;


architecture arc_soma_sub of usertop is
	signal RESET,CLOCK,DIGIT: std_logic;
	component relogio is
	port (CLK, RESET: in std_logic;
		QUERO_DIGITAR: in std_logic;
		DEZENA,UNIDADE: in std_logic_vector(3 downto 0);
		DISPLAY_UNI_SEG: out std_logic_vector(6 downto 0);
		DISPLAY_DEZ_SEG: out std_logic_vector(6 downto 0);
		LED: out std_logic_vector(3 downto 0)
		);
	end component;

begin

RESET <= not(KEY(1));
DIGIT <= sw(17);
R: relogio port map (CLK_500Hz, RESET, DIGIT, SW(7 downto 4), SW(3 downto 0), HEX0, HEX1, LEDR(3 downto 0));

end arc_soma_sub;
