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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seg_decoder is
    port (data   : in unsigned(3 downto 0);
          leds   : out std_logic_vector(6 downto 0)
         );
end entity seg_decoder;

architecture behav of seg_decoder is
begin
with data select
		 -- 6543210
leds <=  "1000000" when "0000", --0
			"1111001" when "0001", --1
			"0100100" when "0010", --2
			"0110000" when "0011", --3
			"0011001" when "0100", --4
			"0010010" when "0101", --5
			"0000010" when "0110", --6
			"1111000" when "0111", --7
			"0000000" when "1000", --8
			"0010000" when "1001", --9
			"0001000" when "1010", --a
			"0000011" when "1011", --b
			"0100111" when "1100", --c
			"0100001" when "1101", --d
			"0000110" when "1110", --e
			"0001110" when "1111", --f
			"-------" when others;
end behav;
