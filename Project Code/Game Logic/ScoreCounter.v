module ScoreCounter(
  input wire clk,
  input wire reset,
  input wire [31:0] score_in,
  output reg [31:0] score_out
);

  reg [31:0] score;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset the score to 0 when reset is asserted
      score <= 32'b0;
    end else begin
      // Use non-blocking assignment for updating registers
      score <= score_in;
    end
  end

  always @(*) begin
    // Output the current score value
    score_out = score;
  end

endmodule
