library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity data_processor is
    port (
        clk             : in  std_logic;
        -- Interfata de la UART
        rx_done         : in  std_logic;
        rx_data         : in  std_logic_vector(7 downto 0);
        
        -- Interfata Master AXI4-Stream catre Modulul Statistica
        m_axis_tdata    : out std_logic_vector(15 downto 0);
        m_axis_tvalid   : out std_logic;
        m_axis_tready   : in  std_logic
    );
end data_processor;

architecture Behavioral of data_processor is
    signal temp_accumulator : integer range 0 to 999 := 0;
    signal vld_out          : std_logic := '0';
    signal data_out         : std_logic_vector(15 downto 0) := (others => '0');
begin

    process(clk)
    begin
        if rising_edge(clk) then
           
            if vld_out = '1' and m_axis_tready = '1' then
                vld_out <= '0';
            end if;

            if rx_done = '1' then
              
                if rx_data >= x"30" and rx_data <= x"39" then
                    temp_accumulator <= (temp_accumulator * 10) + (to_integer(unsigned(rx_data)) - 48);
                
                elsif rx_data = x"0A" or rx_data = x"0D" then
                    data_out <= std_logic_vector(to_unsigned(temp_accumulator, 16));
                    vld_out <= '1'; 
                    temp_accumulator <= 0; 
                end if;
            end if;
        end if;
    end process;

    m_axis_tdata  <= data_out;
    m_axis_tvalid <= vld_out;

end Behavioral;