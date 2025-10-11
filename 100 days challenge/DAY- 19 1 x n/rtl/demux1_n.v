
module demux_1xN #(
  parameter N = 4,                      // Number of outputs
  parameter SEL_WIDTH = $clog2(N)       // Select line width
)(
  input  logic              din,        // 1-bit input
  input  logic [SEL_WIDTH-1:0] sel,     // select lines
  output logic [N-1:0]       dout       // outputs
);

  // Demux logic
  always_comb begin
    dout = '0;                  // default all outputs to 0
    dout[sel] = din;            // route input to selected line
  end

endmodule
