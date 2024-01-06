module PulseChecker (
    input [3:0] KEY,
    input [9:0] SW,
    output [6:0] HEX0,
    output [6:0] HEX1,
    output [6:0] HEX2,
    output [6:0] HEX3, // Additional hex display output for key3
    input CLOCK_50
);

    reg [15:0] key0_count, key1_count, key2_count, key3_count;
    reg key0_pulse, key1_pulse, key2_pulse, key3_pulse;

    // Inverted keys
    wire [3:0] inv_KEY;
    assign inv_KEY = ~KEY;

    // Pulse generator instances for each key
    PulseGenerator key0_pulse_gen (
        .clk(CLOCK_50),
        .signal(inv_KEY[0]),
        .pulse(key0_pulse)
    );

    PulseGenerator key1_pulse_gen (
        .clk(CLOCK_50),
        .signal(inv_KEY[1]),
        .pulse(key1_pulse)
    );

    PulseGenerator key2_pulse_gen (
        .clk(CLOCK_50),
        .signal(inv_KEY[2]),
        .pulse(key2_pulse)
    );

    PulseGenerator key3_pulse_gen (
        .clk(CLOCK_50),
        .signal(inv_KEY[3]),
        .pulse(key3_pulse)
    );

    // Counter logic
    always @(posedge CLOCK_50) begin
        if (key0_pulse) key0_count <= key0_count + 1;
        if (key1_pulse) key1_count <= key1_count + 1;
        if (key2_pulse) key2_count <= key2_count + 1;
        if (key3_pulse) key3_count <= key3_count + 1;
    end

    // Hex display logic
    SevenSegmentDisplay HEX0_display (
        .SW(SW),
        .HEX(HEX0),
        .value(key0_count)
    );

    SevenSegmentDisplay HEX1_display (
        .SW(SW),
        .HEX(HEX1),
        .value(key1_count)
    );

    SevenSegmentDisplay HEX2_display (
        .SW(SW),
        .HEX(HEX2),
        .value(key2_count)
    );

    SevenSegmentDisplay HEX3_display (
        .SW(SW),
        .HEX(HEX3),
        .value(key3_count)
    );

endmodule
