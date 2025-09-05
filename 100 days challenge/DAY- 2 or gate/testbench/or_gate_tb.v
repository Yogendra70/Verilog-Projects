module or_gate_tb;
  reg a, b;
  wire y;
  integer errors;

  // Device Under Test
  or_gate dut(.y(y), .a(a), .b(b));

  // Dumping variables for waveform analysis
  initial begin
    $dumpfile("or_gate_tb.vcd"); // VCD output file
    $dumpvars(0, or_gate_tb);    // Dump all signals from this tb
  end

  // Self-checking task
  task check_or;
    input reg ta, tb;
    reg expected;
    begin
      a = ta; b = tb;
      expected = ta | tb;
      #1; // Wait for output to stabilize
      if (y !== expected) begin
        $display("FAILED: a=%b b=%b y=%b (expected %b)", a, b, y, expected);
        errors = errors + 1;
      end else begin
        $display("PASSED: a=%b b=%b y=%b", a, b, y);
      end
    end
  endtask

  // Main test process
  initial begin
    errors = 0;
    check_or(0, 0);
    check_or(0, 1);
    check_or(1, 0);
    check_or(1, 1);
    if (errors == 0)
      $display("All tests PASSED.");
    else
      $display("%0d tests FAILED.", errors);
    $finish;
  end
endmodule
