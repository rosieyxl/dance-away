module PulseGenerator (
    input wire clk,
    input wire signal,
    output reg pulse
);

reg previous_signal;

always @(posedge clk) begin
    if (signal && !previous_signal) begin
        pulse <= 1;
    end else begin
        pulse <= 0;
    end
    previous_signal <= signal;
end

endmodule
