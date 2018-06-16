CC=iverilog
FLAGS=-Wall -Winfloop

all: s_accum

D_ACCUMULATOR = ./tb_accumulator.v ../accumulator.v
N_ACCUMULATOR = s_accum

D_CONFORMING = ./tb_conforming.v ../conforming.v ../differentiator.v ../integrator.v ../mov_aver.v
N_CONFORMING = conforming



$(N_ACCUMULATOR): $(D_ACCUMULATOR)
	$(CC) -o $(N_ACCUMULATOR).sim $(D_ACCUMULATOR)
	./$(N_ACCUMULATOR).sim

$(N_CONFORMING): $(D_CONFORMING)
	$(CC) $(FLAGS) -o $(N_CONFORMING).sim $(D_CONFORMING)
	vvp $(N_CONFORMING).sim


clean:
	rm *.sim *.vcd
