
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY LogicalStep_Lab4_top IS
   PORT
	(
   clkin_50	   : in	std_logic;							-- The 50 MHz FPGA Clockinput
	 
	rst_n			: in	std_logic;							-- The RESET input (ACTIVE LOW)
	pb_n			: in	std_logic_vector(3 downto 0); -- The push-button inputs (ACTIVE LOW)
 	sw   			: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds			: out std_logic_vector(7 downto 0);	-- for displaying the the lab4 project details
	-------------------------------------------------------------
	-- you can add temporary output ports here if you need to debug your design 
	-- or to add internal signals for your simulations
--	sm_clken_out, blink_sig_out, a_NS, d_NS, g_NS, a_EW, d_EW, g_EW	: out std_logic;
	-------------------------------------------------------------
	
   seg7_data 	: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  : out	std_logic;							-- seg7 digi selectors
	seg7_char2  : out	std_logic							-- seg7 digi selectors
	);
END LogicalStep_Lab4_top;

ARCHITECTURE SimpleCircuit OF LogicalStep_Lab4_top IS
   component segment7_mux port (
          clk        	: in  	std_logic := '0';
			 DIN2 			: in  	std_logic_vector(6 downto 0);	--bits 6 to 0 represent segments G,F,E,D,C,B,A
			 DIN1 			: in  	std_logic_vector(6 downto 0); --bits 6 to 0 represent segments G,F,E,D,C,B,A
			 DOUT			: out	std_logic_vector(6 downto 0);
			 DIG2			: out	std_logic;
			 DIG1			: out	std_logic
   );
   end component;

   component clock_generator port (
			sim_mode			: in boolean;
			reset				: in std_logic;
         clkin      		    : in  std_logic;
			sm_clken			: out	std_logic;
			blink		  		: out std_logic
  );
   end component;

    component pb_filters port (
			clkin				: in std_logic;
			rst_n				: in std_logic;
			rst_n_filtered	    : out std_logic;
			pb_n				: in  std_logic_vector (3 downto 0);
			pb_n_filtered	    : out	std_logic_vector(3 downto 0)							 
 );
   end component;

	component pb_inverters port (
			rst_n				: in  std_logic;
			rst				    : out	std_logic;							 
			pb_n_filtered	    : in  std_logic_vector (3 downto 0);
			pb					: out	std_logic_vector(3 downto 0)							 
  );
   end component;
	
	component synchronizer port(
			clk					: in std_logic;
			reset					: in std_logic;
			din					: in std_logic;
			dout					: out std_logic
  );
  end component; 
  component holding_register port (
			clk					: in std_logic;
			reset					: in std_logic;
			register_clr		: in std_logic;
			din					: in std_logic;
			dout					: out std_logic
  );
  end component;			
  
  component state_machine Port (
			clk_input, reset, NS_ped, EW_ped, sm_clken, blink_sig, offline			: IN std_logic;
			red_NS, amber_NS, green_NS, NS_CROSSING_DISPLAY 			: OUT std_logic;
			red_EW, amber_EW, green_EW, EW_CROSSING_DISPLAY 			: OUT std_logic;
			reg_clear_NS, reg_clear_EW										: OUT std_logic;
			state_num																: OUT std_logic_vector(3 downto 0)
	);
	END component;
	
----------------------------------------------------------------------------------------------------
	CONSTANT	sim_mode								: boolean := FALSE;  -- set to FALSE for LogicalStep board downloads																						-- set to TRUE for SIMULATIONS
	SIGNAL rst, rst_n_filtered, synch_rst			    : std_logic;
	SIGNAL sm_clken, blink_sig							: std_logic; 
	SIGNAL pb_n_filtered, pb							: std_logic_vector(3 downto 0); 
	SIGNAL red_NS, amber_NS, green_NS, red_EW, amber_EW, green_EW 						: std_logic;
	SIGNAL NS_display, EW_display									: std_logic_vector(6 downto 0); 
	SIGNAL reg_clear_NS, reg_clear_EW							: std_logic;
	SIGNAL NS_ped, EW_ped 											: std_logic;
	SIGNAL NS_reg, EW_reg 											: std_logic;
	SIGNAL synch_sw 													: std_logic;
	
	
	
BEGIN
----------------------------------------------------------------------------------------------------
	NS_display <= amber_NS & "00" & green_NS & "00" & red_NS; 
	EW_display <= amber_EW & "00" & green_EW & "00" & red_EW; 
	leds(1) <= NS_reg;
	leds(3) <= EW_reg;
--	sm_clken_out <= sm_clken;
--	blink_sig_out <= blink_sig;
--	a_NS <= red_NS;
--	d_NS <= amber_NS;
--	g_NS <= green_NS;
--	a_EW <= red_EW;
--	d_EW <= amber_EW;
--	g_EW <= green_EW;
	
	

	
INST0: pb_filters			port map (clkin_50, rst_n, rst_n_filtered, pb_n, pb_n_filtered);
INST1: pb_inverters		port map (rst_n_filtered, rst, pb_n_filtered, pb);
INST2: synchronizer     port map (clkin_50,'0', rst, synch_rst);	
INST3: clock_generator 	port map (sim_mode, synch_rst, clkin_50, sm_clken, blink_sig);

INST4: synchronizer 		port map (clkin_50, synch_rst, pb(1), EW_ped);
INST5: synchronizer 		port map (clkin_50, synch_rst, pb(0), NS_ped);
INST6: holding_register port map (clkin_50, synch_rst, reg_clear_EW, EW_ped, EW_reg);
INST7: holding_register port map (clkin_50, synch_rst, reg_clear_NS, NS_ped, NS_reg);

INST8: state_machine 	port map (clkin_50, synch_rst, NS_reg, EW_reg, sm_clken, blink_sig, synch_sw, 
											 red_NS, amber_NS, green_NS, leds(0), red_EW, amber_EW, green_EW, leds(2), reg_clear_NS, reg_clear_EW, leds(7 downto 4));
INST9: segment7_mux 		port map (clkin_50, NS_display, EW_display, seg7_data, seg7_char2, seg7_char1);
INST10: synchronizer 	port map (clkin_50, synch_rst, sw(0), synch_sw);


END SimpleCircuit;
