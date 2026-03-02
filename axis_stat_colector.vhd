library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity axis_stat_collector is
    port (
        clk           : in  std_logic;
        reset_n       : in  std_logic;
     
        s_axis_tdata  : in  std_logic_vector(15 downto 0);
        s_axis_tvalid : in  std_logic;
        s_axis_tready : out std_logic;
        
  
        current_val   : out integer range 0 to 999;
        current_min   : out integer range 0 to 999;
        current_max   : out integer range 0 to 999;
        current_avg   : out integer range 0 to 999
    );
end axis_stat_collector;

architecture Behavioral of axis_stat_collector is
    signal min_reg : integer range 0 to 999 := 999;
    signal max_reg : integer range 0 to 999 := 0;
    signal sum_reg : integer := 0;
    signal count   : integer := 0;
    signal cur_reg : integer range 0 to 999 := 0;
begin
   
    s_axis_tready <= '1'; 

    process(clk)
        variable val : integer;
    begin
        if rising_edge(clk) then
            if reset_n = '1' then 
                min_reg <= 999;
                max_reg <= 0;
                sum_reg <= 0;
                count   <= 0;
                cur_reg <= 0;
            elsif s_axis_tvalid = '1' then
                val := to_integer(unsigned(s_axis_tdata));
                cur_reg <= val;
                
                if val > max_reg then 
                    max_reg <= val; 
                end if;
                
                if val < min_reg and val > 0 then 
                    min_reg <= val; 
                end if;
                
                sum_reg <= sum_reg + val;
                count   <= count + 1;
            end if;
        end if;
    end process;

    current_val <= cur_reg;
    current_min <= min_reg;
    current_max <= max_reg;
    current_avg <= sum_reg / count when count > 0 else 0;

end Behavioral;