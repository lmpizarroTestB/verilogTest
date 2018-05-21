//
//
// VHDL Simulation of Trapezoidal Filter for Digital
// Nuclear Spectroscopy systems
// Ms Kavita Pathak 
// Dr. Sudhir Agrawal
// International Journal of Scientific and Research Publications, Volume 5,
// Issue 8, August 2015
//
//
module trapezoid #(parameter Nbits = 14,
                parameter ADDR_WIDTH = 8
                )(x, y, clk, clr, params, selParam);


  parameter MAX_PARAMS = 1 << ADDR_WIDTH;

endmodule
