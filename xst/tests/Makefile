all: adder_8 mult4_bb

adder_8: tb_adder_8.v ../accumulators.v
	iverilog -o adder_8.sim tb_adder_8.v ../accumulators.v 
	./adder_8.sim
	

mult4_bb: tb_mult4_bb.v ../multipliers.v ../accumulators.v
	iverilog -o mult4_bb.sim tb_mult4_bb.v ../multipliers.v ../accumulators.v
	./mult4_bb.sim

clean:
	rm *.sim 
