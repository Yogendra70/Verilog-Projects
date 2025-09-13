module half_substractor(
input a,
input b,
output difference,
output borrow 
);

assign difference = a^b;
assign borrow = (~a) & b;
endmodule