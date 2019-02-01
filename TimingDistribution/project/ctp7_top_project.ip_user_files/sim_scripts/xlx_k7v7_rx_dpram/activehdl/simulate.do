onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+xlx_k7v7_rx_dpram -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.xlx_k7v7_rx_dpram xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {xlx_k7v7_rx_dpram.udo}

run -all

endsim

quit -force
