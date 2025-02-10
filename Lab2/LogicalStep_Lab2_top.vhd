--Team 3, Erin Hu & Eva Jin
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb_n				: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
---
---------------------------------------------------------------- 
   --seven segment takes 4-bit input data and outputs 7-bit output into a 7-segment hexadecimal display
	component SevenSegment port (
		hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
		sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component segment7_mux port(
		clk		: in std_logic := '0';
		DIN2		: in std_logic_vector(6 downto 0);
		DIN1		: in std_logic_vector(6 downto 0);
		DOUT		: out std_logic_vector(6 downto 0);
		DIG2		: out std_logic;
		DIG1		: out std_logic
	);
	end component;
	
	--inverts the pb from active low to active high
	component PB_Inverters port (
		pb_n 	: in std_logic_vector(3 downto 0);
		pb 	: out std_logic_vector(3 downto 0)
	);
	end component;
	
	--based on the inputs, and select, outputs AND/OR/XOR/XNOR
	component logic_processor_mux port (
		logic_in0 		: in std_logic_vector(3 downto 0);
		logic_in1 		: in std_logic_vector(3 downto 0);
		logic_select	: in std_logic_vector(1 downto 0);
		logic_output	: out std_logic_vector(3 downto 0) 
	);
	end component;
	
	--adds bits of 2 4-bit inputs
	component full_adder_4bit port (
		input_A 	: in std_logic_vector (3 downto 0);
		input_B 	: in std_logic_vector (3 downto 0);
		Carry_In 			: in std_logic;
		Carry_Out3 			: out std_logic; 
		SUM 					: out std_logic_vector (3 downto 0)
	); 
	end component;
	
	-- 2 to 1 mux
	component mux_2_to_1 port (
		logic_in0 		: in std_logic_vector(3 downto 0);
		logic_in1 		: in std_logic_vector(3 downto 0);
		logic_select			: in std_logic;
		logic_output			: out std_logic_vector(3 downto 0) 
	);
	end component;

	
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal seg7_B		: std_logic_vector(6 downto 0);
	signal hex_A		: std_logic_vector(3 downto 0);
	signal hex_B 		: std_logic_vector(3 downto 0);
	signal pb 			: std_logic_vector(3 downto 0);
	signal full_adder_4bit_carry_out 	: std_logic;
	signal carry_out 	: std_logic_vector (3 downto 0);
	signal full_adder_4bit_hex_sum 		: std_logic_vector (3 downto 0);
	signal Operand_A  : std_logic_vector(3 downto 0);
	signal Operand_B  : std_logic_vector(3 downto 0);
	
	
-- Here the circuit begins

begin

	hex_A <= sw(3 downto 0);
	hex_B <= sw(7 downto 4);
	carry_out <= "000" & full_adder_4bit_carry_out;
	
	-- inverting the pb to active high
	INST1: PB_Inverters port map(pb_n, pb);
	-- logic processor instance 
	INST2: logic_processor_mux port map(hex_B, hex_A, pb(1 downto 0), leds(3 downto 0));
	-- 4 bit adder  
	INST3: full_adder_4bit port map(hex_A, hex_B, '0', full_adder_4bit_carry_out, full_adder_4bit_hex_sum);
	-- 2 to 1 mux for carry out and sum 
	INST4: mux_2_to_1 port map(hex_B, carry_out, pb(2), Operand_B);
	INST5: mux_2_to_1 port map(hex_A, full_adder_4bit_hex_sum, pb(2), Operand_A);
	-- seven segment displays 
	INST6: SevenSegment port map(Operand_A, seg7_A);
	INST7: SevenSegment port map(Operand_B, seg7_B);
	INST8: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1);

 
end SimpleCircuit;

