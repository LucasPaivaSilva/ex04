library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;-- necessário para o +

entity relogio is
port (CLK, RESET: in std_logic;
		QUERO_DIGITAR: in std_logic;
		DEZENA,UNIDADE: in std_logic_vector(3 downto 0);
		DISPLAY_UNI_SEG: out std_logic_vector(6 downto 0);
		DISPLAY_DEZ_SEG: out std_logic_vector(6 downto 0);
		LED: out std_logic_vector(3 downto 0)
		);
end relogio;


architecture sub_arch of relogio is
	signal DEZ_SEG, UNI_SEG: std_logic_vector(3 downto 0);
	signal DEZ_SOMA, UNI_SOMA: std_logic_vector(3 downto 0);
	signal DEZ_RESET, UNI_RESET: std_logic;
	signal DEZ_ENABLE: std_logic;
	signal DEZ_TM, UNI_TM: std_logic;
	signal UNI_TW_TC, DEZ_TW_TC: std_logic_vector(1 downto 0);
	signal ENABLE_RELOGIO, INDICA_MUDANCA: std_logic;
	
	component maquina is
		port (rst,clk:	in std_logic;
			tm,tm_anterior,quero_digitar: 	in std_logic;
			y:	out std_logic_vector(1 downto 0)
		);
	end component;
	
	component registrador is
	port (CLK, RST, EN:  in std_logic;
		D:  in std_logic_vector(3 downto 0);
		Q: out std_logic_vector(3 downto 0));
	end component;
	
	component decod7seg is
		port (C:  in std_logic_vector(3 downto 0);
				DISPLAY: out std_logic_vector(6 downto 0)
		);
	end component;
	
	component comparador is
		port (A: in std_logic_vector(3 downto 0);
				B: in std_logic_vector(3 downto 0);
				S: out std_logic
		);
	end component;
	
	component human_view is
	port (	rst,clk: in std_logic;
		en1s: out std_logic
	);
end component;
	 
begin
	--human view
	H1: human_view port map(RESET,CLK,ENABLE_RELOGIO);
	LED(2) <= ENABLE_RELOGIO;

	--segundos, unidades
	SU2: maquina port map(RESET, CLK, UNI_TM, ENABLE_RELOGIO, QUERO_DIGITAR, UNI_TW_TC);
	
	UNI_SOMA <= UNI_SEG + "0001" when QUERO_DIGITAR='0' else UNIDADE;
		
	SU3: registrador port map(CLK, UNI_TW_TC(0), UNI_TW_TC(1), UNI_SOMA, UNI_SEG);
	SU4: decod7seg port map(UNI_SEG, DISPLAY_UNI_SEG);
	
	SU1: comparador port map(UNI_SEG, "0111", UNI_TM);
	
	-- segundos, dezenas
	SD1: comparador port map(DEZ_SEG, "0110", DEZ_TM);
	SD2: maquina port map(RESET, CLK, DEZ_TM, UNI_TM, QUERO_DIGITAR, DEZ_TW_TC);
	
	DEZ_SOMA <= DEZ_SEG + "0001" when QUERO_DIGITAR='0' else DEZENA;
	
	SD3: registrador port map(CLK, DEZ_TW_TC(0), DEZ_TW_TC(1), DEZ_SOMA, DEZ_SEG);
	SD4: decod7seg port map(DEZ_SEG, DISPLAY_DEZ_SEG);
	
	
end sub_arch;
