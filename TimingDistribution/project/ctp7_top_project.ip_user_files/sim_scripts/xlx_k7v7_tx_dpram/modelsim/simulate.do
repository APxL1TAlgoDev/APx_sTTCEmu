onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.xlx_k7v7_tx_dpram xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {xlx_k7v7_tx_dpram.udo}

run -all

quit -force
