library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity maquina is
	port (	rst,clk:	in std_logic;
		tm,tm_anterior,quero_digitar: 	in std_logic;
		y:	out std_logic_vector(1 downto 0)
	);
end maquina;

architecture comportamental of maquina is
		type states is (init_state, wait_state, count_state, digita_state);
		signal EA, PE: states;
		signal entradas: std_logic_vector(2 downto 0);
begin
	P1: process(rst,clk,PE)
		begin
				if rst = '1' then
					EA <= init_state;
				elsif clk'event and clk='1' then
						EA <= PE;
				end if;
		end process;
		
entradas <= tm & tm_anterior & quero_digitar;

	P2: process(EA, entradas)
		begin
			case EA is 
				when init_state => 
					y <= "10";
					PE <= wait_state;
				when wait_state => 
					y <= "01";
					if entradas(0)='1' then
						PE <= digita_state;
					elsif entradas(2)='1' then
						PE <= init_state;
					elsif entradas(2 downto 1) = "01" then
						PE <= count_state;
					else
						PE <= wait_state;
					end if;
				when count_state =>
					y <= "11";
					PE <= wait_state;
				when digita_state =>
					y <= "11";
					PE <= wait_state;
			end case;
		end process;
end comportamental;
			
				
				
				
				
				
				
				
				
