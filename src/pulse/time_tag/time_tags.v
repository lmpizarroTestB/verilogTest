//
// Modulo verilog que cuando llega un logic_pulse
// genera un tag de tiempo para ese pulso y una
// señal de arrivo de pulso/nuevo tag
//
module time_tags (input logic_pulse, 
	          input clk, 
		  input reset,
	          output reg [45:0] tag_time,
	          output reg new_tag);

// registro que mantiene el tiempo transcurrido 
reg [45:0] timer;

// cada vez que llega un pulso del clock (clk) incrementa el timer
// si hay señal de reset pone el timer a 0
always @(posedge clk)
begin
if (clk)
     begin
	timer = timer + 1;
     end
end

//
// Pone a cero el timer y el tag_time
//
always @(reset)
begin
	timer = 0;
	tag_time = 0;
end

// Procesa el pulso nuclear 
// si hay pulso logico y el clock esta en 1(uno)
// asigna a la salida el valor que en ese momento
// tiene el timer
// y pone en 1(uno) la señal de que hay un nuevo tag / pulso nuclear
always @(logic_pulse)
begin
	if (logic_pulse & clk) 
	begin
		tag_time = timer;
		new_tag = 1;
	end
end

// aca se pone a 0 la senial de new_tag
// con el flanco de bajada del clk
always @(negedge clk)
begin
	if (new_tag == 1) new_tag = 0;
end

endmodule
