`timescale 1ns/1ps
module tb_demux_1x4;

  reg din;
  reg [1:0] sel;
  wire [3:0] y;

  // Instantiate the DUT (Device Under Test)
  demux_1x4 dut (.din(din), .sel(sel), .y(y));

  integer i;
  reg [3:0] expected;

  initial begin
    $display("Time | din | sel | y | Expected | Result");
    $display("-----------------------------------------");

    // Loop through all combinations
    for (i = 0; i < 8; i = i + 1) begin
      {din, sel} = i[2:0]; // combine din and sel for simplicity
      #1; // small delay

      // Expected output
      expected = 4'b0000;
      if (din)
        expected[sel] = 1'b1;

      // Compare actual and expected
      if (y === expected)
        $display("%4t |  %b  | %b  | %b |   %b    | PASS", $time, din, sel, y, expected);
      else
        $display("%4t |  %b  | %b  | %b |   %b    | FAIL", $time, din, sel, y, expected);
    end

    $finish;
  end

endmodule
