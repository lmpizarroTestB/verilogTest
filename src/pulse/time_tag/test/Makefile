CC=iverilog
FLAGS=-Wall -Winfloop

D_TIME_TAGS = ./tb_time_tags.v ../time_tags.v
N_TIME_TAGS = time_tags

all: N_TIME_TAGS

$(N_TIME_TAGS): $(D_TIME_TAGS)
	iverilog -o $(N_TIME_TAGS).sim $(D_TIME_TAGS)
	./$(N_TIME_TAGS).sim


clean:
	rm *.sim *.vcd
