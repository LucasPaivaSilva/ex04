library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity human_view is
port (	rst,clk: in std_logic;
	en1s: out std_logic	-- enable ativo uma vez a cada segundo
);
end human_view;

architecture circuito of human_view is
signal contador: std_logic_vector(8 downto 0);
begin

	process(rst,clk,contador)
	begin
		if rst = '1' then
				contador <= "000000000";
				en1s <= '0';
		elsif clk'event and clk= '1' then
			if contador = "111110011" then  --249 em decimal
				contador <= "000000000";
				en1s <= '1';
			else
				contador <= contador+1;
				en1s <= '0';
			end if;
		end if;
	end process;

end circuito;
