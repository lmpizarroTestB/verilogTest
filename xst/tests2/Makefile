
D_CALAMOD = ./tb_ca_la_mod.v  ../accumulators.v 
N_CALAMOD = ca_la_mod

D_COUNTER10 = ./tb_counter10.v ../counters.v
N_COUNTER10 = counter10

D_COUNTER_8 = ./tb_counter_8.v ../counters.v
N_COUNTER_8 = counter_8


all: basic_and ca_la_mod $(N_COUNTER10) $(N_COUNTER_8)

basic_and: tb_basic_and.v 
	iverilog -o basic_and.sim tb_basic_and.v  
	./basic_and.sim
	
ca_la_mod: $(D_CALAMOD) 
	iverilog -o $(N_CALAMOD).sim $(D_CALAMOD)
	./$(N_CALAMOD).sim

$(N_COUNTER10): $(D_COUNTER10) 
	iverilog -o $(N_COUNTER10).sim $(D_COUNTER10)
	./$(N_COUNTER10).sim

$(N_COUNTER_8): $(D_COUNTER_8) 
	iverilog -o $(N_COUNTER_8).sim $(D_COUNTER_8)
	./$(N_COUNTER_8).sim

clean:
	rm *.sim
	

