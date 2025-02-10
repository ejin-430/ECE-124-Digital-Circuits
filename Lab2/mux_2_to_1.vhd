--Team 3, Erin Hu & Eva Jin
library ieee;
use ieee.std_logic_1164.all;

entity mux_2_to_1 is
-- connect ports for input 0 (4 bits), input 1 (4 bits), select, and output
port (
	logic_in0 		: in std_logic_vector(3 downto 0);
	logic_in1 		: in std_logic_vector(3 downto 0);
	logic_select			: in std_logic;
	logic_output			: out std_logic_vector(3 downto 0) 
);

end mux_2_to_1;

architecture mux_2_to_1_logic of mux_2_to_1 is

begin 
	-- depending on the pb input, the output would be input0 or input1
	with logic_select select
	logic_output  <= 	logic_in0 when '0',
							logic_in1 when '1';
end mux_2_to_1_logic;