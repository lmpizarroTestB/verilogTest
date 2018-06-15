all: s_accum

D_ACCUMULATOR = ./tb_accumulator.v ../accumulator.v
N_ACCUMULATOR = s_accum

D_CONFORMING = ./tb_conforming.v ../conforming.v
N_CONFORMING = conforming



$(N_ACCUMULATOR): $(D_ACCUMULATOR)
	iverilog -o $(N_ACCUMULATOR).sim $(D_ACCUMULATOR)
	./$(N_ACCUMULATOR).sim

$(N_CONFORMING): $(D_CONFORMING)
	iverilog -o $(N_CONFORMING).sim $(D_CONFORMING)
	./$(N_CONFORMING).sim


clean:
	rm *.sim *.vcd
