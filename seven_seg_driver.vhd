library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seven_seg_drive is
    port (
        clk          : in  std_logic;
        temp_value   : in  integer range 0 to 999;
        segments     : out std_logic_vector(6 downto 0); -- a to g
        digit_select : out std_logic_vector(3 downto 0)  -- anozii pentru cele 4 cifre
    );
end seven_seg_drive;

architecture Behavioral of seven_seg_drive is
    signal refresh_counter : unsigned(19 downto 0) := (others => '0');
    signal active_digit    : integer range 0 to 3 := 0;
    signal current_digit_val : integer range 0 to 9 := 0;
begin

    process(clk)
    begin
        if rising_edge(clk) then
            refresh_counter <= refresh_counter + 1;
        end if;
    end process;

    active_digit <= to_integer(refresh_counter(19 downto 18)); 

    process(active_digit, temp_value)
    begin
        case active_digit is
            when 0 => 
                digit_select <= "1110"; 
                current_digit_val <= temp_value rem 10;
            when 1 => 
                digit_select <= "1101";
                current_digit_val <= (temp_value / 10) rem 10;
            when 2 => 
                digit_select <= "1011";
                current_digit_val <= (temp_value / 100) rem 10;
            when others => 
                digit_select <= "0111";
                current_digit_val <= 0;
        end case;
    end process;

  process(current_digit_val)
    begin
        case current_digit_val is
           
            when 0 => segments <= "0000001"; -- a,b,c,d,e,f aprinse
            when 1 => segments <= "1001111"; -- b,c aprinse
            when 2 => segments <= "0010010"; -- a,b,g,e,d aprinse
            when 3 => segments <= "0000110"; -- a,b,g,c,d aprinse
            when 4 => segments <= "1001100"; -- f,g,b,c aprinse
            when 5 => segments <= "0100100"; -- a,f,g,c,d aprinse
            when 6 => segments <= "0100000"; -- a,f,g,c,d,e aprinse
            when 7 => segments <= "0001111"; -- a,b,c aprinse
            when 8 => segments <= "0000000"; -- toate aprinse
            when 9 => segments <= "0000100"; -- toate in afara de e
            when others => segments <= "0111111"; -- doar segmentul a aprins (eroare)
        end case;
    end process;

end Behavioral;