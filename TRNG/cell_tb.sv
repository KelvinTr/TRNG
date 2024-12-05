
module tb ();

  logic       rst, clk;
  logic       en_i, en_o, rnd_o;
  

  // instantiate device under test
  trng_cell #(.NUM_INV(5),.SIM_MODE(1)) dut 
    (
      .clk(clk),
      .rst(rst),
      .en_i(en_i),
      .en_o(en_o),
      .rnd_o(rnd_o)
    );

  // 5 ns clock
  initial 
  begin	
    clk = 1'b0;
    forever #10 clk = ~clk;
  end

  initial 
  begin	
    rst = 1'b1;
    en_i = 1'b0;
    #25 rst = ~rst;
    #90 en_i = ~en_i;
  end


//   always @(posedge valid_o) begin
//     $display(data_o);
//   end


   
endmodule
