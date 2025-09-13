module full_adder_tb;
reg a ;
reg b;
reg cin;
wire sum;
wire carry;
integer errors;

full_adder dut(
.a(a),
.b(b),
.cin(cin),
.sum(sum),
.carry(carry)
);

initial begin 
$dumpfile(" full_adder_tb.vcd ");
$dumpvars(0, full_adder_tb);
end

task check_input;
input reg t_a;
input reg t_b;
input reg t_cin;
reg expected_sum;
reg expected_carry;
begin
a = t_a;
b= t_b;
cin = t_cin;
expected_sum = t_a ^ t_b ^ t_cin;
expected_carry = (t_a & t_b) | ( t_b & t_cin ) | (t_cin & t_a);
#1;
if (( sum !== expected_sum ) || ( carry !== expected_carry )) begin
$display("Failed : Time= %0d | a=%b b=%b cin=%b | sum=%b carry=%b (expected_sum = %b ) (expected_carry) ", $time, a,b,cin,sum,carry,expected_sum,expected_carry);
errors = errors + 1;
end else begin
$display("Passed : Time= %0d | a=%b b=%b cin=%b | sum=%b carry=%b", $time, a,b,cin,sum,carry);
end
end
endtask

initial begin 
errors=0;
check_input(0,0,0);
check_input(0,0,1);
check_input(0,1,0);
check_input(0,1,1);
check_input(1,0,0);
check_input(1,0,1);
check_input(1,1,0);
check_input(1,1,1);
if(errors == 0)
$display("\nALL TEST PASSED.");
else 
$display("\n %0d TEST FAILED.", errors);
#5 $finish;
end
endmodule