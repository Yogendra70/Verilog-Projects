module xor_gate_tb();
reg a ;
reg b;
wire y;
integer errors;

xor_gate dut( 
.a(a),
.b(b),
.y(y)
);

initial begin 
     $dumpfile("xor_gate_tb.vcd");
     $dumpvars(0, xor_gate_tb);
    end

task check_xor;
input reg t_a;
input reg t_b;
reg expected ;
begin
a= t_a;
b= t_b;
expected = t_a ^ t_b;
#1;

if(y!== expected ) begin
$display ("Failed: Time=%0t | a=%b b=%b | y=%b (expected=%b)", $time,a,b,y,expected);
errors = errors +1;
end else begin
$display("Passed: Time=%0t | a=%b b=%b | y=%b ", $time,a,b,y);
end
end
endtask

initial begin 
error=0;
check_xor(0,0);
check_xor(1,0);
check_xor(1,1);
check_xor(0,1);
if(errors ==0)
$display("ALL TEST PASSED ");
else
$display("%0d are failed", errors);
$finish;
end
endmodule
