/*module RateDivider #(parameter CLOCK_FREQUENCY = 50000000)(
    input Clock,          // Clock input
    input Reset,          // Reset signal
    input [1:0] Speed,    // Speed control (1/2, 1/1, 2/1, 4/1)
    input [15:0] BPM,     // Beats Per Minute (e.g., 120 BPM) as a runtime input
    output reg Enable     // Enable signal
);

    reg [15:0] Count;
    wire tick;

    // Calculate the number of clock cycles per beat based on BPM and Speed
    reg [31:0] cyclesPerBeat;
    always @(*) begin
        case (Speed)
            2'b00: cyclesPerBeat = 0; // no speed
            2'b01: cyclesPerBeat = (BPM / 60) * 1 / (CLOCK_FREQUENCY); // 1/1 speed
            2'b10: cyclesPerBeat = 2*(BPM / 60) / (CLOCK_FREQUENCY); // 2/1 speed
            2'b11: cyclesPerBeat = 4*(BPM / 60) / (CLOCK_FREQUENCY); // 4/1 speed
        endcase
    end

    always @(posedge Clock or posedge Reset) begin
        if (Reset)
            Count <= 0;
        else if (Count >= cyclesPerBeat - 1)
            Count <= 0;
        else
            Count <= Count + 1;
    end

    assign tick = (Count == cyclesPerBeat - 1);

    always @(posedge Clock) begin
        Enable = tick;
        $display("Enable = %b, Count = %d, BPM = %d, CyclesPerBeat = %d", Enable, Count, BPM, cyclesPerBeat);
    end

endmodule
*/