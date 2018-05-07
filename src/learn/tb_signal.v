module tb_signal;
  integer i = 0;
  integer j = 0;

  initial
    begin
      $monitor ("%g %d %d", $time, i, j);
      for (i=0; i< 255; i = i + 1) 
        #5 j = i * 3.4;
    end

endmodule
