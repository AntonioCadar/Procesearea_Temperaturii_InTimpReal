## Ceasul sistemului (100 MHz)
set_property PACKAGE_PIN W5 [get_ports clk]							
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## UART (Recep?ie serial?)
# Pinul B18 este conectat la controllerul USB-UART de pe Basys 3
set_property PACKAGE_PIN B18 [get_ports rx_serial]						
set_property IOSTANDARD LVCMOS33 [get_ports rx_serial]

## Switch-uri pentru selec?ie (sw[0] ?i sw[1])
# sw[0] - selecteaz? între Actual/Min/Max/Avg
set_property PACKAGE_PIN V17 [get_ports {sw[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
# sw[1]
set_property PACKAGE_PIN V16 [get_ports {sw[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]

## Buton pentru Reset (reset_n)
# Folosim butonul central pentru a reseta statisticile
set_property PACKAGE_PIN U18 [get_ports reset_n]						
set_property IOSTANDARD LVCMOS33 [get_ports reset_n]

## LED-uri (Monitorizare UART binar?)
set_property PACKAGE_PIN U16 [get_ports {led[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property PACKAGE_PIN E19 [get_ports {led[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property PACKAGE_PIN U19 [get_ports {led[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property PACKAGE_PIN V19 [get_ports {led[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property PACKAGE_PIN W18 [get_ports {led[4]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
set_property PACKAGE_PIN U15 [get_ports {led[5]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
set_property PACKAGE_PIN U14 [get_ports {led[6]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
set_property PACKAGE_PIN V14 [get_ports {led[7]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]

## Display 7 Segmente - Segmentele (a-g)
set_property PACKAGE_PIN W7 [get_ports {seg_out[6]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[6]}]
set_property PACKAGE_PIN W6 [get_ports {seg_out[5]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[5]}]
set_property PACKAGE_PIN U8 [get_ports {seg_out[4]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[4]}]
set_property PACKAGE_PIN V8 [get_ports {seg_out[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[3]}]
set_property PACKAGE_PIN U5 [get_ports {seg_out[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[2]}]
set_property PACKAGE_PIN V5 [get_ports {seg_out[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[1]}]
set_property PACKAGE_PIN U7 [get_ports {seg_out[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {seg_out[0]}]

## Display 7 Segmente - Anozi (Selectie cifr?)
set_property PACKAGE_PIN U2 [get_ports {an_out[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an_out[0]}]
set_property PACKAGE_PIN U4 [get_ports {an_out[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an_out[1]}]
set_property PACKAGE_PIN V4 [get_ports {an_out[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an_out[2]}]
set_property PACKAGE_PIN W4 [get_ports {an_out[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an_out[3]}]