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
    hex_decoder HEX0_display (
        .display(HEX0),
        .c(key0_count)
    );

    hex_decoder HEX1_display (
        .display(HEX1),
        .c(key1_count)
    );

    hex_decoder HEX2_display (
        .display(HEX2),
        .c(key2_count)
    );

    hex_decoder HEX3_display (
        .display(HEX3),
        .c(key3_count)
    );

endmodule

/*module hex_decoder(c, display);
	input [3:0] c;
	output [6:0] display;
	assign display[0] = ~(~c[3] & c[2] & c[0] | c[3] & ~c[2] & ~c[1] | c[1] & c[2] | c[1] & ~c[3] | ~c[0] & c[3] | ~c[0] & ~c[2]);

	assign display[1] = ~(~c[2] & ~c[0] | ~c[2] & ~c[1] | ~c[3] & c[1] & c[0] | ~c[3] & c[2] & ~c[1] & ~c[0] | c[3] & c[2] & ~c[1] & c[0]);

	assign display[2] = ~(~c[3] & c[2] | c[3] & ~c[2] | ~c[2] & c[0] | ~c[1] & ~c[2] | c[3] & c[2] & ~c[1] & c[0]);

	assign display[3] = ~(~c[3] & ~c[2] & c[1] | ~c[3] & ~c[2] & ~c[0] | c[2] & c[1] & ~c[0] | c[3] & ~c[2] & c[0] | c[3] & ~c[1] | c[2] & ~c[1] & c[0]);

	assign display[4] = ~(~c[2] & ~c[0] | c[3] & c[2] | c[3] & c[1] | c[1] & ~c[0]);

	assign display[5] = ~(~c[3] & ~c[1] & ~c[0] | ~c[0] & c[2] | c[3] & ~c[2] & c[0] | c[3] & ~c[2] & ~c[1] | c[2] & ~c[1] & ~c[3] | c[3] & c[2] & c[1] | c[3] & c[1] & ~c[0]);

	assign display[6] = ~(~c[3] & c[1] & ~c[0] | ~c[3] & ~c[2] & c[1] | c[3] & ~c[2] & ~c[0] | c[3] & ~c[2] & ~c[1] | c[2] & ~c[1] & c[0] | ~c[3] & c[2] & ~c[1] | c[3] & c[2] & c[1] | c[3] & c[1] & c[0]);
endmodule*/

