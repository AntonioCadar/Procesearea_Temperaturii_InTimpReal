library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_module is
    port (
        clk           : in  std_logic;
        rx_serial     : in  std_logic;
        sw            : in  std_logic_vector(1 downto 0);
        reset_n       : in  std_logic;                    
        led           : out std_logic_vector(7 downto 0); 
        seg_out       : out std_logic_vector(6 downto 0);
        an_out        : out std_logic_vector(3 downto 0)  
    );
end top_module;

architecture Structural of top_module is
   
    signal uart_data     : std_logic_vector(7 downto 0);
    signal uart_ready    : std_logic;

    signal axis_tdata    : std_logic_vector(15 downto 0);
    signal axis_tvalid   : std_logic;
    signal axis_tready   : std_logic;

    signal val_current   : integer range 0 to 999;
    signal val_min       : integer range 0 to 999;
    signal val_max       : integer range 0 to 999;
    signal val_avg       : integer range 0 to 999;
    
    signal display_value : integer range 0 to 999;

begin

    UART_INST : entity work.uart_rx
        port map (
            clk       => clk,
            rx_serial => rx_serial,
            rx_data   => uart_data,
            rx_done   => uart_ready
        );
 
    PROC_INST : entity work.data_processor
        port map (
            clk           => clk,
            rx_done       => uart_ready,
            rx_data       => uart_data,
            m_axis_tdata  => axis_tdata,
            m_axis_tvalid => axis_tvalid,
            m_axis_tready => axis_tready
        );

    STAT_INST : entity work.axis_stat_collector
        port map (
            clk           => clk,
            reset_n       => reset_n,
            s_axis_tdata  => axis_tdata,
            s_axis_tvalid => axis_tvalid,
            s_axis_tready => axis_tready,
            current_val   => val_current,
            current_min   => val_min,
            current_max   => val_max,
            current_avg   => val_avg
        );

    process(sw, val_current, val_min, val_max, val_avg)
    begin
        case sw is
            when "00" => display_value <= val_current;
            when "01" => display_value <= val_min;
            when "10" => display_value <= val_max;
            when "11" => display_value <= val_avg;
            when others => display_value <= val_current;
        end case;
    end process;

    DISP_INST : entity work.seven_seg_drive
        port map (
            clk          => clk,
            temp_value   => display_value,
            segments     => seg_out,
            digit_select => an_out
        );

    led <= uart_data;

end Structural;