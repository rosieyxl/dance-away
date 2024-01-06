module StreakCounter(
  input wire clk,
  input wire reset,
  input wire [31:0] streak_in,
  output reg [31:0] streak_out
);

  reg [31:0] streak;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      streak <= 32'b0;
    end else begin
      streak <= streak_in; // Use non-blocking assignment to update streak
    end
  end

  always @(*) begin
    streak_out = streak;
  end

endmodule
