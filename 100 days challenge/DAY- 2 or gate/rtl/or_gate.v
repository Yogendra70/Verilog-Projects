// Simple 2-input AND gate module
module or_gate(
input a,
input b,
output y
);

assign y = a|b;
endmodule