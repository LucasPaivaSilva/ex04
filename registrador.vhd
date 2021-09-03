library IEEE;
use IEEE.Std_Logic_1164.all;

entity registrador is
	port (CLK, RST, EN:  in std_logic;
		D:  in std_logic_vector(3 downto 0);
		Q: out std_logic_vector(3 downto 0));
	end registrador;
	
architecture behv of registrador is
begin
	process(CLK, D, RST, EN)
		 begin
			 if RST = '1' then
				Q <= "0000";
			 elsif (CLK'event and CLK = '1') then
				if EN = '1' then
					Q <= D;
				end if; 
			 end if;
	end process;
end behv;	 
	 
	 
