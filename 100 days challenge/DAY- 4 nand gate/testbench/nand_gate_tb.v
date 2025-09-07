module nand_gate_tb();
reg a;
reg b;
wire y;
integer errors;

nand_gate dut (
.a(a),
.b(b),
.y(y)
);

initial begin 
$dumpfile("nand_gate_tb.vcd");
$dumpvars (0, nand_gate_tb);
end

task check_nand;
input reg t_a, t_b;
reg expected;
begin 
a=t_a; b=t_b;
expected = ~(a&b);
#1;
if ( y!== expected) begin
$display(" Failed: Time=%0t | a=%b b=%b | y=&b (expected=%b)", $time, a,b,y, expected );
errors = errors +1;
end else begin
$display("Passed: Time=%0t | a=%b b=%b | y=&b", $time, a,b,y );
end
end
endtask

initial begin 
errors=0;
check_nand(0,0);
check_nand(1,1);
check_nand(1,0);
check_nand(0,1);
 if (errors == 0)
      $display("All tests PASSED.");
    else
      $display("%0d tests FAILED.", errors);
    $finish;
  end
endmodule
