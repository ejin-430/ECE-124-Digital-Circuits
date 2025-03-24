library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity synchronizer is port(
		clk					: in std_logic;
		reset					: in std_logic;
		din					: in std_logic;
		dout					: out std_logic
);
end entity;
	
	ARCHITECTURE Sync_Logic OF synchronizer IS
	
	Signal Q1, Q2 	: std_logic;
	
BEGIN

process (clk) is
begin 
	if (rising_edge(clk)) then
		if(reset = '1') then
			Q1 <= '0';
			Q2 <= '0';
		else
			Q1 <= din;
			Q2 <= Q1;
		end if;
	end if;
	
	dout <= Q2;
end process;

END Sync_Logic;