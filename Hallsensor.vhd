-- Filename:     
-- Filetype:     
-- Date:         
-- Update:       
-- Description:  
-- Author:       
-- State:        
-- Error:        
-- Version:      1.0
-- Copyright:    (c)2012, De Haagse Hogeschool

-- Pulse teller
-- Timer
-- Omrekeneenheid
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Hallsensor is
    port (	clk	: in std_logic;
				arst	: in std_logic;
				hsen	: in std_logic;
				rpm	: out unsigned(9 downto 0)
         );
end entity Hallsensor;

architecture Werking of Hallsensor is

signal calc : std_logic;
signal count_counter_int : unsigned(9 downto 0);
signal count_Pulses : unsigned(9 downto 0);
signal count_calc : unsigned(4 downto 0);
signal rpm_int : unsigned(9 downto 0);
begin
	Timer: process (clk, arst)
	variable count_timer_int : integer range 0 to 32767;
		begin
			if(arst = '1') then
				count_timer_int := 0;
				calc <= '0';
			elsif (rising_edge(clk)) then
					if(count_timer_int = 1) then
						calc <= '0';
					end if;
					if(not(count_timer_int = 30000)) then
						count_timer_int := count_timer_int + 1;
					elsif(count_timer_int = 30000) then
						count_timer_int := 0;
						calc <= '1';
					end if;
			end if;
	end process;
	
	Pulse_Teller: process(clk, arst)
		begin
			if(arst = '1') then
				count_counter_int <= "0000000000";
				count_Pulses <= "0000000000";
			elsif (rising_edge(clk)) then
				if(calc = '0') then
					count_counter_int <= count_counter_int + 1;
				elsif (calc = '1') then
					count_Pulses <= count_counter_int;
					count_counter_int <= "0000000000";
				end if;
			end if;
	end process;
	
	Omrekeneenheid: process(clk, arst)
		begin
			if(arst = '1') then
				count_calc <= "10100";
				rpm_int <= "0000000000";
				rpm <= "0000000000";
			elsif(rising_edge(clk)) then
				if(count_calc > "00000") then
					count_calc <= count_calc - 1;
					rpm_int <= rpm_int + count_Pulses;
				elsif(count_calc = "00000") then
					count_calc <= "10100";
					rpm <= rpm_int;
					rpm_int <= "0000000000";
				end if;
			end if;
	end process;
end architecture Werking;				
