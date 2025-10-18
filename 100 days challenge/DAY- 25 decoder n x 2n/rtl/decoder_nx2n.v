//==================================================
// n x 2^n DECODER (PARAMETERIZED)
//==================================================
module decoder #(parameter N = 3)(
  input  [N-1:0] in,       // N-bit input
  output [2**N-1:0] out    // 2^N-bit output
);

  // One-hot decode logic
  assign out = 1 << in;

endmodule
