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

clean:
	rm *.sim *.vcd
