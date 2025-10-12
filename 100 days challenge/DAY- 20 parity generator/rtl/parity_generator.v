//==============================================
// Parity Generator (Even Parity)
//==============================================
module parity_generator (
    input  [7:0] data_in,   // 8-bit input data
    output parity_bit       // Generated parity bit
);

    // Even parity: XOR of all bits
    assign parity_bit = ^data_in;  // Reduction XOR operator

endmodule
