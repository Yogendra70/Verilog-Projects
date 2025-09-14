module full_substractor(
input a,
input b, 
input bin,
output borrow,
output difference
);

assign difference =  a^b^cin;
assign borrow = (~a & b) | ((~(a ^ b)) & bin);
endmodule