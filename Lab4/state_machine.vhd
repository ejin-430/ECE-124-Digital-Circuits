library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity state_machine IS Port
(
 clk_input, reset, NS_ped, EW_ped, sm_clken, blink_sig, offline			: IN std_logic; 
 red_NS, amber_NS, green_NS, NS_CROSSING_DISPLAY 			: OUT std_logic;
 red_EW, amber_EW, green_EW, EW_CROSSING_DISPLAY 			: OUT std_logic;
 reg_clear_NS, reg_clear_EW										: OUT std_logic;
 state_num																: OUT std_logic_vector(3 downto 0)
 );
END ENTITY;
 

 Architecture SM of state_machine is
 
 

 
 TYPE STATE_NAMES IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15);   -- list all the STATE_NAMES values

 
 SIGNAL current_state, next_state	:  STATE_NAMES;     	-- signals of type STATE_NAMES


 BEGIN
 

 -------------------------------------------------------------------------------
 --State Machine:
 -------------------------------------------------------------------------------

 -- REGISTER_LOGIC PROCESS EXAMPLE
 
Register_Section: PROCESS (clk_input)  -- this process updates with a clock
BEGIN
	IF(rising_edge(clk_input)) THEN
		IF (reset = '1') THEN
			current_state <= S0;
		ELSIF (sm_clken = '1') THEN
			current_state <= next_State;
		END IF;
	END IF;
END PROCESS;	



-- TRANSITION LOGIC PROCESS EXAMPLE

Transition_Section: PROCESS (NS_ped, EW_ped, current_state) 

BEGIN
  CASE current_state IS
         WHEN S0 =>		
				IF(EW_ped = '1' and NS_ped = '0') THEN
					next_state <= S6;
				ELSE 
					next_state <= S1;
				END IF;
				
         WHEN S1 =>	
				IF(EW_ped = '1' and NS_ped = '0') THEN
					next_state <= S6;
				ELSE 
					next_state <= S2;
				END IF;
				
         WHEN S2 =>		
					next_state <= S3;
				
         WHEN S3 =>		
					next_state <= S4;

         WHEN S4 =>		
					next_state <= S5;

         WHEN S5 =>		
					next_state <= S6;
				
         WHEN S6 =>		
					next_state <= S7;
				
         WHEN S7 =>		
					next_state <= S8;
					
			WHEN S8 =>	
				IF(NS_ped = '1' and EW_ped = '0') THEN
					next_state <= S14;
				ELSE 
					next_state <= S9;
				END IF;
								
         WHEN S9 =>		
				IF(NS_ped = '1' and EW_ped = '0') THEN
					next_state <= S14;
				ELSE 
					next_state <= S10;
				END IF;

         WHEN S10 =>		
					next_state <= S11;
				
         WHEN S11 =>		
					next_state <= S12;

         WHEN S12 =>		
					next_state <= S13;

         WHEN S13 =>		
					next_state <= S14;
				
         WHEN S14 =>		
					next_state <= S15;
				
         WHEN S15 =>		
				IF(offline = '1') THEN
					next_state <= S15;
				ELSE 
					next_state <= S0;
				END IF;

	  END CASE;
 END PROCESS;
 

-- DECODER SECTION PROCESS EXAMPLE (MOORE FORM SHOWN)

Decoder_Section: PROCESS (current_state) 

BEGIN
     CASE current_state IS
	  
		WHEN S0 =>
			red_NS <= '0';
			amber_NS <= '0';
			green_NS <= blink_sig;
			red_EW <= '1';
			amber_EW <= '0';
			green_EW <= '0';
			NS_CROSSING_DISPLAY <= '0';
			EW_CROSSING_DISPLAY <= '0';
			reg_clear_NS <= '0';
			reg_clear_EW <= '0';
			state_num <= "0000";

			
		WHEN S1 =>
			red_NS <= '0';
			amber_NS <= '0';
			green_NS <= blink_sig;
			red_EW <= '1';
			amber_EW <= '0';
			green_EW <= '0';
			NS_CROSSING_DISPLAY <= '0';
			EW_CROSSING_DISPLAY <= '0';
			reg_clear_NS <= '0';
			reg_clear_EW <= '0';
			state_num <= "0001";
		 
		WHEN S2 =>
			red_NS <= '0';
			amber_NS <= '0';
			green_NS <= '1';
			red_EW <= '1';
			amber_EW <= '0';
			green_EW <= '0';
			NS_CROSSING_DISPLAY <= '1';
			EW_CROSSING_DISPLAY <= '0';
			reg_clear_NS <= '0';
			reg_clear_EW <= '0';
			state_num <= "0010";
		 
		WHEN S3 =>
			red_NS <= '0';
			amber_NS <= '0';
			green_NS <= '1';
			red_EW <= '1';
			amber_EW <= '0';
			green_EW <= '0';
			NS_CROSSING_DISPLAY <= '1';
			EW_CROSSING_DISPLAY <= '0';
			reg_clear_NS <= '0';
			reg_clear_EW <= '0';
			state_num <= "0011";
		 
		WHEN S4 =>
			red_NS <= '0';
			amber_NS <= '0';
			green_NS <= '1';
			red_EW <= '1';
			amber_EW <= '0';
			green_EW <= '0';
			NS_CROSSING_DISPLAY <= '1';
			EW_CROSSING_DISPLAY <= '0';
			reg_clear_NS <= '0';
			reg_clear_EW <= '0';
			state_num <= "0100";
			
		WHEN S5 =>
			red_NS <= '0';
			amber_NS <= '0';
			green_NS <= '1';
			red_EW <= '1';
			amber_EW <= '0';
			green_EW <= '0';
			NS_CROSSING_DISPLAY <= '1';
			EW_CROSSING_DISPLAY <= '0';
			reg_clear_NS <= '0';
			reg_clear_EW <= '0';
			state_num <= "0101";
		
		WHEN S6 =>
			red_NS <= '0';
			amber_NS <= '1';
			green_NS <= '0';
			red_EW <= '1';
			amber_EW <= '0';
			green_EW <= '0';
			NS_CROSSING_DISPLAY <= '0';
			EW_CROSSING_DISPLAY <= '0';
			reg_clear_NS <= '1';
			reg_clear_EW <= '0';
			state_num <= "0110";
	
		 
		WHEN S7 =>
			red_NS <= '0';
			amber_NS <= '1';
			green_NS <= '0';
			red_EW <= '1';
			amber_EW <= '0';
			green_EW <= '0';
			NS_CROSSING_DISPLAY <= '0';
			EW_CROSSING_DISPLAY <= '0';
			reg_clear_NS <= '0';
			reg_clear_EW <= '0';
			state_num <= "0111";
			
		WHEN S8 =>
			red_NS <= '1';
			amber_NS <= '0';
			green_NS <= '0';
			red_EW <= '0';
			amber_EW <= '0';
			green_EW <= blink_sig;
			NS_CROSSING_DISPLAY <= '0';
			EW_CROSSING_DISPLAY <= '0';
			reg_clear_NS <= '0';
			reg_clear_EW <= '0';
			state_num <= "1000";
		 
		WHEN S9 =>
			red_NS <= '1';
			amber_NS <= '0';
			green_NS <= '0';
			red_EW <= '0';
			amber_EW <= '0';
			green_EW <= blink_sig;
			NS_CROSSING_DISPLAY <= '0';
			EW_CROSSING_DISPLAY <= '0';
			reg_clear_NS <= '0';
			reg_clear_EW <= '0';
			state_num <= "1001";
			
		WHEN S10 =>
			red_NS <= '1';
			amber_NS <= '0';
			green_NS <= '0';
			red_EW <= '0';
			amber_EW <= '0';
			green_EW <= '1';
			NS_CROSSING_DISPLAY <= '0';
			EW_CROSSING_DISPLAY <= '1';
			reg_clear_NS <= '0';
			reg_clear_EW <= '0';
			state_num <= "1010";
		 
		 
		WHEN S11 =>
			red_NS <= '1';
			amber_NS <= '0';
			green_NS <= '0';
			red_EW <= '0';
			amber_EW <= '0';
			green_EW <= '1';
			NS_CROSSING_DISPLAY <= '0';
			EW_CROSSING_DISPLAY <= '1';
			reg_clear_NS <= '0';
			reg_clear_EW <= '0';
			state_num <= "1011";
		 
		WHEN S12 =>
			red_NS <= '1';
			amber_NS <= '0';
			green_NS <= '0';
			red_EW <= '0';
			amber_EW <= '0';
			green_EW <= '1';
			NS_CROSSING_DISPLAY <= '0';
			EW_CROSSING_DISPLAY <= '1';
			reg_clear_NS <= '0';
			reg_clear_EW <= '0';
			state_num <= "1100";
		 
		WHEN S13 =>
			red_NS <= '1';
			amber_NS <= '0';
			green_NS <= '0';
			red_EW <= '0';
			amber_EW <= '0';
			green_EW <= '1';
			NS_CROSSING_DISPLAY <= '0';
			EW_CROSSING_DISPLAY <= '1';
			reg_clear_NS <= '0';
			reg_clear_EW <= '0';
			state_num <= "1101";
		
		WHEN S14 =>
			red_NS <= '1';
			amber_NS <= '0';
			green_NS <= '0';
			red_EW <= '0';
			amber_EW <= '1';
			green_EW <= '0';
			NS_CROSSING_DISPLAY <= '0';
			EW_CROSSING_DISPLAY <= '0';
			reg_clear_NS <= '0';
			reg_clear_EW <= '1';
			state_num <= "1110";
		 
		WHEN S15 =>
			IF(offline = '1') THEN
				red_NS <= blink_sig;
				amber_EW <= blink_sig;
			ELSE 
				red_NS <= '1';
				amber_EW <= '1';
			END IF;
			amber_NS <= '0';
			green_NS <= '0';
			red_EW <= '0';
			green_EW <= '0';
			NS_CROSSING_DISPLAY <= '0';
			EW_CROSSING_DISPLAY <= '0';
			reg_clear_NS <= '0';
			reg_clear_EW <= '0';
			state_num <= "1111";
		 
	  END CASE;
 END PROCESS;

 END ARCHITECTURE SM;
