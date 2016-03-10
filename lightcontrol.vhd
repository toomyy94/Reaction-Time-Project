library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity lighcontrol is
	port(runtime	: in std_logic_vector(13 downto 0);
		  out_0		: out std_logic_vector(3 downto 0);
		  out_1		: out std_logic_vector(3 downto 0);
		  out_2		: out std_logic_vector(3 downto 0);
		  out_3		: out std_logic_vector(3 downto 0));
end lighcontrol;

architecture Behavioral of lighcontrol is
	signal res0, res1, res2 : std_logic_vector(13 downto 0);
begin
	process(runtime)
	begin
		
		res0 <= std_logic_vector(unsigned(runtime) / "00000000001010");
		out_0 <= std_logic_vector(unsigned(runtime) rem "1010"); 
		
		res1 <= std_logic_vector(unsigned(res0) / "00000000001010");
		out_1 <= std_logic_vector(unsigned(res0) rem "1010");
		
	   res2 <= std_logic_vector(unsigned(res1) / "00000000001010");
		out_2 <= std_logic_vector(unsigned(res1) rem "1010");
		
		out_3 <= std_logic_vector(unsigned(res2) rem "1010");
	
	end process;
	
end Behavioral;