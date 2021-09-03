library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;-- necessário para o +

entity comparador is
port (A: in std_logic_vector(3 downto 0);
		B: in std_logic_vector(3 downto 0);
		S: out std_logic
		);
end comparador;

architecture circuito of comparador is
begin
	S <= '1' when A>B
		else '0';
end circuito;