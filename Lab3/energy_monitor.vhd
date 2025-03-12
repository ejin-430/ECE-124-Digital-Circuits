library ieee;
use ieee.std_logic_1164.all;

entity energy_monitor is port (
	agtb, aeqb, altb 															: in std_logic;
	vacation_mode, MC_test_mode, window_open, door_open 			: in std_logic;
	furnace, at_temp, AC, blower, window, door, vacation			: out std_logic;
	increase, decrease, run													: out std_logic
);

end energy_monitor;

architecture energy_monitor_logic of energy_monitor is

begin 

	furnace <= agtb;
	at_temp <= aeqb;
	AC <= altb;
	
	window <= window_open;
	door <= door_open;
	blower <= not(aeqb or window_open or door_open) xor MC_test_mode;
	vacation <= vacation_mode;
	increase <= agtb;
	decrease <= altb;
	run <= not(window_open or door_open or MC_test_mode or aeqb);

end energy_monitor_logic;