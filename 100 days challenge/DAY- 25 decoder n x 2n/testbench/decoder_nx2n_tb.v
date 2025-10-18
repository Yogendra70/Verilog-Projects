//==================================================
// SELF-CHECKING TESTBENCH FOR n x 2^n DECODER
//==================================================
module tb_decoder;

  // Parameter
  parameter N = 3;

  // Signals
  reg  [N-1:0] in;
  wire [2**N-1:0] out;

  // Instantiate DUT
  decoder #(N) dut (.in(in), .out(out));

  // Self-checking logic
  integer i;
  reg [2**N-1:0] expected;

  initial begin
    $display("Starting n x 2^n decoder test...");

    // Loop over all possible inputs
    for (i = 0; i < 2**N; i = i + 1) begin
      in = i;
      expected = 1 << i;
      #1; // wait for output to settle

      // Check
      if (out !== expected)
        $display("ERROR: input=%0d | expected=%b | got=%b", i, expected, out);
      else
        $display("PASS : input=%0d | output=%b", i, out);
    end

    $display("Test completed.");
    $finish;
  end
endmodule
