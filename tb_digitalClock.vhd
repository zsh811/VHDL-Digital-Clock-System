LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

--the below library is used for finishing the simulation after we are done.
--Otherwise it will run continuously. 
--library std; use std.env.finish;

ENTITY tb_digitalClock IS
END tb_digitalClock;

ARCHITECTURE behavior OF tb_digitalClock IS
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT digital_clock	
        generic( CLOCK_FREQ : integer := 50000000 );
        PORT(
            Clock : IN std_logic; 
            reset : IN std_logic; 
            inc_secs : IN std_logic; 
            inc_mins : IN std_logic; 
            inc_hrs : IN std_logic; 
            seconds : OUT unsigned(5 downto 0); 
            minutes : OUT unsigned(5 downto 0);
            hours : OUT unsigned(4 downto 0) 
        );
    END COMPONENT;

    --Inputs
    signal Clock : std_logic := '0'; 
    signal reset : std_logic := '0'; 
    signal inc_secs : std_logic := '0'; 
    signal inc_mins : std_logic := '0'; 
    signal inc_hrs : std_logic := '0';

    --Outputs 
    signal seconds : unsigned(5 downto 0); 
    signal minutes : unsigned(5 downto 0); 
    signal hours : unsigned(4 downto 0);

    -- Clock period definitions 
    constant Clock_period : time := 10 ns;

    --Clock frequency in Hz. Use a smaller value for testbench.
    --When testing on board it need to be set as 50 million, 100 million etc. 
    constant CLOCK_FREQ : integer := 10;

BEGIN
    -- Instantiate the Unit Under Test (UUT) 
    uut: digital_clock
        GENERIC MAP(CLOCK_FREQ => CLOCK_FREQ)
        PORT MAP (
            Clock => Clock, 
            reset => reset, 
            inc_secs => inc_secs, 
            inc_mins => inc_mins, 
            inc_hrs => inc_hrs, 
            seconds => seconds, 
            minutes => minutes, 
            hours => hours
        );

    -- Clock process definitions 
    clock_process: process 
    begin
        Clock <= '0';
        wait for Clock_period/2; 
        Clock <= '1'; 
        wait for Clock_period/2; 
    end process;

    -- Stimulus process 
    stim_proc: process 
    begin 
        reset <= '1'; -- hold reset state for 100 ns.
        wait for 100 ns; 
        reset <= '0';
        wait for Clock_period*CLOCK_FREQ*60*60*25; --run the clock for 25 hours

        --increment seconds
        inc_secs <= '1'; 
        wait for Clock_period; 
        inc_secs <= '0';
        wait for Clock_period*CLOCK_FREQ*5;	--wait for 5 secs after incrementing seconds once.

        --increment seconds 60 times 
        inc_secs <= '1'; 
        wait for Clock_period*60; 
        inc_secs <= '0';
        wait for Clock_period*CLOCK_FREQ*5;	--wait for 5 secs after incrementing seconds.

        --increment minutes
        inc_mins <= '1'; 
        wait for Clock_period; 
        inc_mins <= '0';
        wait for Clock_period*CLOCK_FREQ*5;	--wait for 5 secs after incrementing minutes once.

        --increment minutes 60 times 
        inc_mins <= '1'; 
        wait for Clock_period*60; 
        inc_mins <= '0';
        wait for Clock_period*CLOCK_FREQ*5;	--wait for 5 secs after incrementing minutes.

        --increment hours
        inc_hrs <= '1';	
        wait for Clock_period; 
        inc_hrs <= '0';
        wait for Clock_period*CLOCK_FREQ*5;	--wait for 5 secs after incrementing hours once.

        --increment hours 25 times
        inc_hrs <= '1';	
        wait for Clock_period*25; 
        inc_hrs <= '0';
        wait for Clock_period*CLOCK_FREQ*5;	--wait for 5 secs after incrementing hours.

        --apply reset 
        reset <= '1';

        --wait for 100 Clock cycles and then finish the simulation.
        --with the current settings it will run around 9 ms of simualtion time. 
        wait for Clock_period*100;
        finish; 
    end process;
END;
