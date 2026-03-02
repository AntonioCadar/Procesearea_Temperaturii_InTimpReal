import serial
import time

# Configurare porturi
port_arduino = 'COM5'
port_fpga = 'COM4'
baud_rate = 9600

try:
    # Deschidem conexiunea cu Arduino
    ser_in = serial.Serial(port_arduino, baud_rate, timeout=1)
    # Deschidem conexiunea cu FPGA
    ser_out = serial.Serial(port_fpga, baud_rate, timeout=1)

    print(f"Bridge activ: {port_arduino} -> {port_fpga}")
    time.sleep(2)

    while True:
        if ser_in.in_waiting > 0:
            # Citim linia de la Arduino
            data = ser_in.readline()

            # Trimitem datele către FPGA
            ser_out.write(data)

            # Afișăm în consolă pentru monitorizare
            print(f"Transferat: {data.decode('utf-8').strip()}")

except serial.SerialException as e:
    print(f"Eroare la portul serial: {e}")
except KeyboardInterrupt:
    print("\nOprire bridge serial.")
finally:
    if 'ser_in' in locals() and ser_in.is_open:
        ser_in.close()
    if 'ser_out' in locals() and ser_out.is_open:
        ser_out.close()