// Simple 2-input AND gate module
module and_gate (
    input  a,    // Input a
    input  b,    // Input b
    output out   // Output out = a & b
);

assign out = a & b;

endmodule
