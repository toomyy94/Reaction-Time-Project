library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity aleatorio is
	port(enable	: in std_logic;
		  timer	: out std_logic_vector(4 downto 0);
		  clk		: in std_logic);
end aleatorio;

architecture Behavioral of aleatorio is
	signal rand : std_logic_vector(4 downto 0) := "00101";
begin
	process(clk)
	begin
		rand <= std_logic_vector(to_unsigned(to_integer(unsigned(rand) + 1), rand'length));
		if(rand >= "11111")then
			rand <= "00101";
		end if;
	end process;
	
	process(enable)
	begin
		if(enable = '0')then
			timer <= rand;
		end if;
	end process;
end Behavioral;