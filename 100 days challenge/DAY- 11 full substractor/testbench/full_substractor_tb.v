module full_substractor_tb();
reg a;
reg b;
reg bin;
wire borrow;
wire difference;
integer errors;

full_substractor (
.a(a),
.b(b),
.bin(bin),
.borrow(borrow),
.difference(difference)
);

initial begin 
$dumpfile("full_substractor_tb.vcd");
$dumpvars(0,full_substractor_tb);
end

task check_input;
reg t_a;
reg t_b;
reg t_bin;
reg expected_borrow;
reg expected_difference;
begin 
a=t_a;
b=t_b;
bin=t_bin;
expected_borrow = (~t_a & t_b) | ((~(t_a ^ t_b)) & t_bin);
expected_difference = t_a^t_b^t_bin;
#1;
if(( difference !== expected_difference) || ( borrow !== expected_borrow)) begin
$display("Failed: Time=%0d | a=%b b=%b bin=%b | difference=%b borrow=%b (expected_difference=%b) (expected_borrow=%b)",$time,a,b,bin,difference,borrow, expected_difference, expected_borrow);
errors=errors +1;
end else begin
$display("Passed: Time=%0d | a=%b b=%b bin=%b | difference=%b borrow=%b", $time,a,b,bin,difference,borrow);
end
end
endtask

initial begin 
errors = 0;
check_input(0,0,0);
check_input(0,0,1);
check_input(0,1,0);
check_input(0,1,1);
check_input(1,0,0);
check_input(1,0,1);
check_input(1,1,0);
check_input(1,1,1);
if(errors == 0)
$display("\n All test passed.");
else
$display("\n %0d test failed", errors);
end
endmodule
