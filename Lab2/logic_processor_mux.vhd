--Team 3, Erin Hu & Eva Jin
library ieee;
use ieee.std_logic_1164.all;

entity logic_processor_mux is port (
-- connect ports for input 0 (4 bits), input 1 (4 bits), select, and output
	logic_in0 		: in std_logic_vector(3 downto 0);
	logic_in1 		: in std_logic_vector(3 downto 0);
	logic_select			: in std_logic_vector(1 downto 0);
	logic_output			: out std_logic_vector(3 downto 0) 
);

end logic_processor_mux;

architecture mux_logic of logic_processor_mux is

begin 
	-- depending on the binary input, the logic output will be AND, OR, XOR, or XNOR
	with logic_select(1 downto 0) select
	logic_output  <= 	(logic_in0 AND logic_in1) when "00",
							(logic_in0 OR logic_in1) when "01",
							(logic_in0 XOR logic_in1) when "10",
							(logic_in0 XNOR logic_in1) when "11";
end mux_logic;