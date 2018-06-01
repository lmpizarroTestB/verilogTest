#-- Sintesis
yosys -p "synth_ice40 -blif co.blif" counter_y16.v
#-- Place & route
arachne-pnr -d 1k -p counter_y16.pcf co.blif -o co.txt
#-- Generar binario final, listo para descargar en fgpa
icepack co.txt co.bin
