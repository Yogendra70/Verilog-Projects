module not_gate_tb();
reg a;
wire y;
interger errors;

not_gate dut(
 .a(a),
 .y(y)
);

// Dumping variables for waveform analysis
initial begin 
$dumpfile("not_gate_tb.vcd");
$dumpvars (0, not_gate_tb);
end

 // Self-checking task
task check_not;
input reg t_a;
reg expected;
begin
a = t_a;
expected = ~t_a;
#1;
if (y !== expected) begin
$display("Failed: a=%b y=%b ( expexted =%b)", a, y, expected);
errors = errors + 1;
end else begin 
$display("Passed: a=%b y=%b", a,y);
end
end
endtask

// Main test process

initial begin 
errors = 0;
check_not(0);
check_not(1);
  if (errors == 0)
      $display("All tests PASSED.");
    else
      $display("%0d tests FAILED.", errors);
    $finish;
  end
endmodule


