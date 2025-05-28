.PHONY: all sim synth clean

SHELL := /bin/bash -o pipefail

DUT ?= main.v
IVERILOG ?= /usr/bin/iverilog

all: sim 

sim: main-sim
	./$< +VCDFILE=sim.vcd +VCDLEVEL=5 | tee sim.log

main-sim: mainTB.v ${DUT} | 
	${IVERILOG} -g2005-sv -s mainTB  -o $@ $^

clean:
	$(RM) main-sim sim.log sim.vcd
