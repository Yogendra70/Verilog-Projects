`timescale 1ns/1ps
module tb_demux_1xN;

  // Parameters
  parameter N = 4;
  // Avoid $clog2 for old compilers
  // Manually compute select width: 2 bits for N=4
  parameter SEL_WIDTH = 2;

  // Signals
  reg din;
  reg [SEL_WIDTH-1:0] sel;
  wire [N-1:0] dout;

  integer i, j;
  integer error_count;
  reg [N-1:0] expected;

  // DUT
  demux_1xN #(.N(N)) dut (
    .din(din),
    .sel(sel),
    .dout(dout)
  );

  // Self-checking block
  initial begin
    $display("==========================================");
    $display("Starting DEMUX 1xN Self-Checking Test...");
    $display("==========================================");

    error_count = 0;

    // test for din = 0 and din = 1
    for (j = 0; j < 2; j = j + 1) begin
      din = j;
      for (i = 0; i < N; i = i + 1) begin
        sel = i;
        #1;
        expected = 0;
        expected[i] = din;

        if (dout !== expected) begin
          $display("❌ Mismatch: sel=%0d din=%0b | Expected=%b Got=%b", sel, din, expected, dout);
          error_count = error_count + 1;
        end else begin
          $display("✅ Pass: sel=%0d din=%0b | dout=%b", sel, din, dout);
        end
      end
    end

    $display("==========================================");
    if (error_count == 0)
      $display("✅ All DEMUX testcases PASSED successfully!");
    else
      $display("❌ DEMUX test FAILED with %0d mismatches!", error_count);
    $display("==========================================");

    $finish;
  end

endmodule
