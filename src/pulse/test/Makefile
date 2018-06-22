CC=iverilog
FLAGS=-Wall -Winfloop


D_TRAPCTRL = ./tb_trapCtrl.v ../mathFilters.v  ../trapezoid.v  ../hpd.v  ../delaySubstract.v ../delayK.v ../trapCtrl.v
N_TRAPCTRL = trapCtrl

D_TRAP = ./tb_trap.v ../trapezoide.v
N_TRAP = trap

D_ZERO = ./tb_zero.v ../cfd.v
N_ZERO = zero



all: N_TRAPCTRL N_TRAP


$(N_TRAPCTRL): $(D_TRAPCTRL)
	iverilog -o $(N_TRAPCTRL).sim $(D_TRAPCTRL)
	./$(N_TRAPCTRL).sim

$(N_TRAP): $(D_TRAP)
	iverilog -o $(N_TRAP).sim $(D_TRAP)
	./$(N_TRAP).sim

$(N_ZERO): $(D_ZERO)
	iverilog -o $(N_ZERO).sim $(D_ZERO)
	./$(N_ZERO).sim



clean:
	rm *.sim *.vcd
