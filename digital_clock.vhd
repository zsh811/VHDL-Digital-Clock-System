--Declare the libraries 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL; --we need this one because we are using "unsigned" data type.

entity digital_clock is
    --frequency of the clock passed as a generic parameter.
    generic( CLOCK_FREQ : integer := 50000000 ); 
    port(
        Clock : in std_logic; --system clock 
        reset : in std_logic; --resets the time
        inc_secs : in std_logic; --set a pulse here to increment the seconds by 1. 
        inc_mins : in std_logic; --set a pulse here to increment the minutes by 1. 
        inc_hrs : in std_logic; --set a pulse here to increment the hours by 1. 
        seconds : out unsigned(5 downto 0); --seconds output 
        minutes : out unsigned(5 downto 0); --minutes output 
        hours : out unsigned(4 downto 0) --hours output
    );
end digital_clock; 

architecture Behavioral of digital_clock is
    --temporary signals as we can't directly perform arithmetic operations on outputs 
    signal secs, mins, hrs : integer := 0;
    --counter used for getting the 1 sec duration from the system Clock. 
    signal counter : integer := 0; 
begin
    process(Clock, reset) 
    begin 
        if(reset = '1') then --reset the time.
            secs <= 0; 
            mins <= 0; 
            hrs <= 0; 
            counter <= 0;
        elsif(rising_edge(Clock)) then
            --increment the seconds. also increment mins and hours if needed.
            if(inc_secs = '1') then 
                if(secs = 59) then 
                    secs <= 0; 
                    if(mins = 59) then 
                        mins <= 0; 
                        if(hrs = 23) then 
                            hrs <= 0;
                        else 
                            hrs <= hrs+1;
                        end if;
                    else 
                        mins <= mins+1;
                    end if;
                else
                    secs <= secs + 1;
                end if;
            --increment the minutes. also increment hours if needed.
            elsif(inc_mins = '1') then 
                if(mins = 59) then 
                    mins <= 0; 
                    if(hrs = 23) then 
                        hrs <= 0;
                    else 
                        hrs <= hrs+1;
                    end if;
                else 
                    mins <= mins+1;
                end if; 
            --increment the hours.
            elsif(inc_hrs = '1') then 
                if(hrs = 23) then 
                    hrs <= 0;
                else 
                    hrs <= hrs+1;
                end if;
            end if;
            --regular operation of the clock
            if(counter = CLOCK_FREQ-1) then --counting CLOCK_FREQ times takes 1 second. 
                counter <= 0;
                --check and change values of secs, mins and hours 
                if(secs = 59) then 
                    secs <= 0; 
                    if(mins = 59) then 
                        mins <= 0; 
                        if(hrs = 23) then 
                            hrs <= 0;
                        else 
                            hrs <= hrs+1;
                        end if;
                    else 
                        mins <= mins+1;
                    end if;
                else
                    secs <= secs + 1;
                end if;
            else 
                counter <= counter+1;
            end if;
        end if; 
    end process;
    --The internal integer signals are converted into unsigned format.
    --The size of the output unsigned signal is assigned via the 2nd parameter(5 or 6 bits) 
    seconds <= to_unsigned(secs, 6); 
    minutes <= to_unsigned(mins, 6); 
    hours <= to_unsigned(hrs, 5); 
end Behavioral;
