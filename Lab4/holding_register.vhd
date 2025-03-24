library ieee;
use ieee.std_logic_1164.all;


entity holding_register is port (

			clk					: in std_logic;
			reset				: in std_logic;
			register_clr		: in std_logic;
			din					: in std_logic;
			dout				: out std_logic
  );
 end holding_register;
 
 architecture circuit of holding_register is

	Signal sreg				: std_logic;
	signal a, b, c, q		: std_logic;


BEGIN

	a <= din or q;
	b <= register_clr nor reset;
	c <= a and b;
	
	process (clk) is
		begin 
			if (rising_edge(clk)) then
				if(reset = '1') then
					q <= '0';
				else
					q <= c;
				end if;
			end if;
			
			dout <= q;
		end process;

end;