onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib xlx_k7v7_rx_dpram_opt

do {wave.do}

view wave
view structure
view signals

do {xlx_k7v7_rx_dpram.udo}

run -all

quit -force
