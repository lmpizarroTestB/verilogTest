CC=iverilog
FLAGS=-Wall -Winfloop

all: s_accum

D_ACCUMULATOR = ./tb_accumulator.v ../accumulator.v
N_ACCUMULATOR = s_accum

D_CONFORMING = ./tb_conforming.v ../conforming.v ../differentiator.v ../integrator.v ../mov_aver.v
N_CONFORMING = conforming

D_DELAYK = ./tb_delayK.v ../delayK.v
N_DELAYK = delayK


D_DELAYSUBS = ./tb_delaySubtract.v ../delaySubstract.v ../delayK.v
N_DELAYSUBS = delaySubstract

D_HPD = ./tb_hpd.v ../hpd.v ../mathFilters.v
N_HPD = hpd

D_ADDS = ./tb_addS.v ../mathFilters.v
N_ADDS = addS

D_ACCUMS = ./tb_accumS.v ../mathFilters.v
N_ACCUMS = accumS

D_TRAPEZ = ./tb_trapezoide.v ../mathFilters.v  ../trapezoid.v  ../hpd.v  ../delaySubstract.v ../delayK.v
N_TRAPEZ = trapezoide

D_TRAPCTRL = ./tb_trapCtrl.v ../mathFilters.v  ../trapezoid.v  ../hpd.v  ../delaySubstract.v ../delayK.v ../trapCtrl.v
N_TRAPCTRL = trapCtrl

D_TRAP = ./tb_trap.v ../mathFilters.v 
N_TRAP = trap



$(N_ACCUMULATOR): $(D_ACCUMULATOR)
	$(CC) -o $(N_ACCUMULATOR).sim $(D_ACCUMULATOR)
	./$(N_ACCUMULATOR).sim

$(N_CONFORMING): $(D_CONFORMING)
	$(CC) $(FLAGS) -o $(N_CONFORMING).sim $(D_CONFORMING)
	vvp $(N_CONFORMING).sim

$(N_DELAYK): $(D_DELAYK)
	$(CC) $(FLAGS) -o $(N_DELAYK).sim $(D_DELAYK)
	vvp $(N_DELAYK).sim

$(N_DELAYSUBS): $(D_DELAYSUBS)
	$(CC) $(FLAGS) -o $(N_DELAYSUBS).sim $(D_DELAYSUBS)
	vvp $(N_DELAYSUBS).sim

$(N_HPD): $(D_HPD)
	$(CC) $(FLAGS) -o $(N_HPD).sim $(D_HPD)
	vvp $(N_HPD).sim

$(N_ADDS): $(D_ADDS)
	iverilog -o $(N_ADDS).sim $(D_ADDS)
	./$(N_ADDS).sim

$(N_ACCUMS): $(D_ACCUMS)
	iverilog -o $(N_ACCUMS).sim $(D_ACCUMS)
	./$(N_ACCUMS).sim


$(N_TRAPEZ): $(D_TRAPEZ)
	iverilog -o $(N_TRAPEZ).sim $(D_TRAPEZ)
	./$(N_TRAPEZ).sim

$(N_TRAPCTRL): $(D_TRAPCTRL)
	iverilog -o $(N_TRAPCTRL).sim $(D_TRAPCTRL)
	./$(N_TRAPCTRL).sim

$(N_TRAP): $(D_TRAP)
	iverilog -o $(N_TRAP).sim $(D_TRAP)
	./$(N_TRAP).sim


clean:
	rm *.sim *.vcd
