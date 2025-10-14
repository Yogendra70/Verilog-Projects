//==========================================================
//  Module Name : parity_checker
//  Function    : Checks even parity of input data
//==========================================================
module parity_checker #(parameter WIDTH = 8)
(
    input  [WIDTH-1:0] data_in,    // Input data
    input               parity_bit, // Received parity bit
    output reg          error_flag  // High if parity error detected
);

    // Internal parity calculation (even parity)
    wire calculated_parity;

    assign calculated_parity = ^data_in; // XOR all bits (odd => 1, even => 0)

    always @(*) begin
        // Compare received parity with calculated parity
        if (calculated_parity == parity_bit)
            error_flag = 0; // no error
        else
            error_flag = 1; // error detected
    end

endmodule
