// 3x8 Decoder RTL
module decoder3x8 (
    input  [2:0] din,     // 3-bit input
    input        en,      // enable signal
    output reg [7:0] dout // 8-bit output
);

    always @(*) begin
        if (en)
            dout = 8'b00000001 << din; // decode input when enabled
        else
            dout = 8'b00000000;        // all outputs low when disabled
    end

endmodule
