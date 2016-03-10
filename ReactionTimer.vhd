library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity ReactionTimer is
	port(SW 			: in std_logic_vector(1 downto 0);
			CLOCK_50 : in std_logic;
			KEY		: in  std_logic_vector(0 downto 0);
			LEDG : out std_logic_vector(7 downto 0);
			HEX0: out std_logic_vector(6 downto 0);
			HEX1: out std_logic_vector(6 downto 0);
			HEX2: out std_logic_vector(6 downto 0);
			HEX3: out std_logic_vector(6 downto 0));
end ReactionTimer;

architecture Shell of ReactionTimer is
	signal tempo  : std_logic_vector(13 downto 0);
	signal waittime : std_logic_vector(4 downto 0);
	signal counter : std_logic_vector(4 downto 0);
	signal s_clk : std_logic;
	signal s_clk_1k : std_logic;
	signal ligth : std_logic := '0';
	signal temp0, temp1, temp2, temp3 : std_logic_vector(3 downto 0);
begin
	
	clk_div		:  entity work.DivFreq(RTL)  
						generic map(divFactor => 25000000)
						port map(clkIn  => CLOCK_50,
									clkOut => s_clk);
									
	clk_div_1k	:  entity work.DivFreq(RTL)  
						generic map(divFactor => 50000)
						port map(clkIn  => CLOCK_50,
									clkOut => s_clk_1k);
	
	gen 			:	entity work.aleatorio(Behavioral)
						port map(enable	=> key(0),
									timer		=> waittime,
									clk		=> CLOCK_50);
										
	process(s_clk, s_clk_1k)
	begin
		if(counter >= waittime)then
				LEDG <= "11111111";
				ligth <= '1';
				if(rising_edge(s_clk_1k))then
					if(key(0)='0' and ligth = '1')then
						--Imprimir
						LEDG <= "00000000";
						ligth <= '0';
						counter <= "00000";
					elsif(key(0)='1' and ligth = '1')then
						tempo <= std_logic_vector(to_unsigned(to_integer(unsigned(tempo) + 1), tempo'length));
					end if;
				end if;
		else	
			if(rising_edge(s_clk))then
				counter <= std_logic_vector(to_unsigned(to_integer(unsigned(counter) + 1), counter'length));
				tempo <= "00000000000000";
			end if;
		end if;
	end process;
	
	conversor	:	entity work.lighcontrol(Behavioral)
						port map(runtime	=> tempo,
									out_0		=> temp0,
									out_1		=> temp1,
									out_2		=> temp2,
									out_3		=> temp3);
	
	dhex0 :	entity work.Bin7SegDecoder(Behavioral)
				port map(binInput => temp0,
							decOut_n => HEX0); 
							
	dhex1 :	entity work.Bin7SegDecoder(Behavioral)
				port map(binInput => temp1, 
							decOut_n => HEX1); 
							
	dhex2 :	entity work.Bin7SegDecoder(Behavioral)
				port map(binInput => temp2, 
							decOut_n => HEX2); 
							
	dhex3 :	entity work.Bin7SegDecoder(Behavioral)
				port map(binInput => temp3,
							decOut_n => HEX3); 
							
end Shell;