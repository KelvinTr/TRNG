module tb ();

  logic        rst, clk;
  logic        enable_i, valid_o, error_o;
  logic [7:0]  data_o;
  logic [31:0] temp;
  integer      i, f, count;

  // instantiate device under test
  // Change the number of cells and starter inverters to suit your needs
  // Ensure that Num_Cells and Num_Inv_Start are at least 7 each to meet NIST SP800-90b validations
  trng #(.NUM_CELLS(3), .NUM_INV_START(3), .SIM_MODE(1)) dut 
    (
      .clk(clk),
      .rst(rst),
      .enable_i(enable_i),
      .data_o(data_o),
      .valid_o(valid_o),
      .error_o(error_o)
    );

  // 5 ns clock
  initial 
  begin	
    clk = 1'b1;
    forever #10 clk = ~clk;
  end

  initial
  begin
    rst = 1'b1;
    #25 rst = ~rst;
  end

  initial
  begin
    enable_i = 1'b0;
    #100 enable_i = ~enable_i;
  end

    initial 
  begin	
    f = $fopen("output.txt","wb"); // use "xxd -r -p output.txt output.bin" to convert txt into binary file
    // Use https://github.com/usnistgov/SP800-90B_EntropyAssessment to validate data
    
    count = 0;
    for (i=0; i<100000; i=i+1) begin
      @(posedge valid_o) begin
        // if (count < 3) begin
        //   $fwrite(f,"%h",data_o);
        //   count = count + 1;
        // end else begin
        //   $fwrite(f,"%h\n",data_o);
        //   count = 0;
        // end
        $fwrite(f,"%h\n",data_o);

      end
    end
    $finish;
  end


endmodule
