
module demux_1x2 (
    input  wire din,    // Data input
    input  wire sel,    // Select line
    output reg  y0,     // Output 0
    output reg  y1      // Output 1
);

    always @(*) begin
        case (sel)
            1'b0: begin
                y0 = din;
                y1 = 1'b0;
            end
            1'b1: begin
                y0 = 1'b0;
                y1 = din;
            end
        endcase
    end

endmodule
