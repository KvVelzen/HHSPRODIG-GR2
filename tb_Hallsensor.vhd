entity tb_Hallsensor is
end entity;

architecture test_stuff of tb_Hallsensor is
constant small_delay : time := 1 ns;
-- The module
component Hallsensor is
    port (	clk	: in std_logic;
				arst	: in std_logic;
				hsen	: in std_logic;
				rpm	: out unsigned(9 downto 0)
         );
end component Hallsensor;

signal clk : std_logic;
signal arst : std_logic;
signal hsen : std_logic;
signal rpm : unsigned(9 downto 0);

begin

	dut: hall_sensor_sim
	port map (clk => clk, arst => arst, hsen => hsen, rpm => rpm);

	clockgen: process is
	begin
		-- give time for reset
		clk <= '0';
		arst <= '1';
		wait for 15 ns;
		arst <= '0';
		wait for 5 ns;
		-- forever: generate clock cycle for 10000 ns and 50% d.c.
		loop
			clk <= '1';
			wait for 5000 ns;
			clk <= '0';
			wait for 5000 ns;
		end loop;

	end process;
	
	hsengen: process is
	begin
	
		wait until clk = '1';
	
		for 20 loop
			for 750 loop
				wait until clk = '1';
			end loop;
			hsen = '1';
			for 750 loop
				wait until clk = '1';
			end loop;
			hsen = '0';
		end loop;
	
		for 60 loop
			for 250 loop
				wait until clk = '1';
			end loop;
			hsen = '1';
			for 250 loop
				wait until clk = '1';
			end loop;
			hsen = '0';
		end loop;
	
		for 120 loop
			for 125 loop
				wait until clk = '1';
			end loop;
			hsen = '1';
			for 125 loop
				wait until clk = '1';
			end loop;
			hsen = '0';
		end loop;
	
		for 200 loop
			for 75 loop
				wait until clk = '1';
			end loop;
			hsen = '1';
			for 75 loop
				wait until clk = '1';
			end loop;
			hsen = '0';
		end loop;
	end process;
end architecture;