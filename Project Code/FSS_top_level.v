module FSS_top_level (
    input [3:0] KEY,
    input [9:0] SW,
    output [6:0] HEX0,
    output [6:0] HEX1,
    output [6:0] HEX2, // Additional hex display output
	 // Gameplay Top level
	output [6:0]HEX3,
	output [6:0]HEX4,
	output [6:0]HEX5,
	output [9:0] LEDR,
	
	 inout				PS2_CLK,
	inout				PS2_DAT,
    input CLOCK_50,
	 
	 //Audio Top level
	 input				AUD_ADCDAT,
	inout				AUD_BCLK,
	inout				AUD_ADCLRCK,
	inout				AUD_DACLRCK,
	inout				FPGA_I2C_SDAT,
	output				AUD_XCK,
	output				AUD_DACDAT,
	output				FPGA_I2C_SCLK,
	
	// VGA Top Level
	output			VGA_CLK,   				//	VGA Clock
	output			VGA_HS,					//	VGA H_SYNC
	output			VGA_VS,					//	VGA V_SYNC
	output			VGA_BLANK_N,				//	VGA BLANK
	output			VGA_SYNC_N,				//	VGA SYNC
	output	[7:0]	VGA_R,   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G,	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B   				//	VGA Blue[7:0]
	
	
	
);

    wire [3:0] selectedSong;
    wire [3:0] difficultySelected;
    wire [3:0] stateOutput;
    wire key0_pulse, key1_pulse, key2_pulse, key3_pulse;
    reg [3:0] prev_key;

    // Inverted keys
    wire [3:0] inv_KEY;
    assign inv_KEY = ~KEY;

    // Pulse each switch key:
    PulseGenerator key0_pulse_gen (
        .clk(CLOCK_50),
        .signal(inv_KEY[0]), // right
        .pulse(key0_pulse)
    );

    PulseGenerator key1_pulse_gen (
        .clk(CLOCK_50),
        .signal(inv_KEY[1]), // up
        .pulse(key1_pulse)
    );

    PulseGenerator key2_pulse_gen (
        .clk(CLOCK_50),
        .signal(inv_KEY[2]), // down
        .pulse(key2_pulse)
    );

    PulseGenerator key3_pulse_gen (
        .clk(CLOCK_50),
        .signal(inv_KEY[3]), //left
        .pulse(key3_pulse)
    );
	 
	 // Keyboard input
	 
	wire kb_up, kb_down, kb_left, kb_right;
	wire kb_up_pulse, kb_down_pulse, kb_left_pulse, kb_right_pulse;
	
	KeyboardInput kirby(
	.clk(CLOCK_50),
	.reset(SW[9]),
	.holdUp(kb_up),
	.holdDown(kb_down),
	.holdLeft(kb_left),
	.holdRight(kb_right),
	.PS2_CLK(PS2_CLK),
	.PS2_DAT(PS2_DAT)
	
);
	 
	 // Pulse each keyboard key
	 PulseGenerator kb_pulse_up (
        .clk(CLOCK_50),
        .signal(kb_up),
        .pulse(kb_up_pulse)
    );

    PulseGenerator kb_pulse_down (
        .clk(CLOCK_50),
        .signal(kb_down),
        .pulse(kb_down_pulse)
    );

    PulseGenerator kb_pulse_left (
        .clk(CLOCK_50),
        .signal(kb_left),
        .pulse(kb_left_pulse)
    );

    PulseGenerator kb_pulse_right (
        .clk(CLOCK_50),
        .signal(kb_right),
        .pulse(kb_right_pulse)
    );
	 
	 
	 // Combine the inputs
	 
	 reg combine_up, combine_down, combine_left, combine_right;
	 
	 reg [3:0] combineDiff, combineSong, combineState;
	 
	 
	 always @(*) begin
		combine_up = ((kb_up_pulse + key1_pulse) > 0);
		combine_down = ((kb_down_pulse + key2_pulse) > 0);
		combine_left = ((kb_left_pulse + key3_pulse) > 0);
		combine_right = ((kb_right_pulse + key0_pulse) > 0);
		
	 end
	 
	 
	 always @(posedge CLOCK_50) begin
		combineDiff = (stateOutput == 3)? 0 : difficultySelected; 
		combineSong = (stateOutput == 3)? 0 : selectedSong; 
		combineState = (stateOutput == 3)? 0 : stateOutput; 
	 end
	 

    FiniteStateSample fsm_inst (
        .clk(CLOCK_50),
        .rst(SW[9]),
        .btn_up(combine_up),
        .btn_down(combine_down),
        .btn_left(combine_left),
        .btn_right(combine_right),
        .state_output(stateOutput),
        .selectedSong(selectedSong),
        .difficutlySelected(difficultySelected),
		  
		  // Audio top level
		  .AUD_ADCDAT(AUD_ADCDAT),
			.AUD_BCLK(AUD_BCLK),
			.AUD_ADCLRCK(AUD_ADCLRCK),
			.AUD_DACLRCK(AUD_DACLRCK),
			.FPGA_I2C_SDAT(FPGA_I2C_SDAT),
			.AUD_XCK(AUD_XCK),
			.AUD_DACDAT(AUD_DACDAT),
			.FPGA_I2C_SCLK(FPGA_I2C_SCLK),
		
			// VGA top level
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK),
			
			//Gameplay top level
				 .HEX3y(HEX0),
				 .HEX4y(HEX1),
				 .HEX5y(HEX2),
				 .LEDR(LEDR)
    );

	// Tentative displays
    hex_decoder x1 (
        .c(combineState),
        .display(HEX5)
    );

    hex_decoder x2 (
        .c(combineSong),
        .display(HEX4)
    );

    hex_decoder x3 (
        .c(combineDiff),
        .display(HEX3)
    );

endmodule

module hex_decoder(c, display);
	input [3:0] c;
	output [6:0] display;
	assign display[0] = ~(~c[3] & c[2] & c[0] | c[3] & ~c[2] & ~c[1] | c[1] & c[2] | c[1] & ~c[3] | ~c[0] & c[3] | ~c[0] & ~c[2]);

	assign display[1] = ~(~c[2] & ~c[0] | ~c[2] & ~c[1] | ~c[3] & c[1] & c[0] | ~c[3] & c[2] & ~c[1] & ~c[0] | c[3] & c[2] & ~c[1] & c[0]);

	assign display[2] = ~(~c[3] & c[2] | c[3] & ~c[2] | ~c[2] & c[0] | ~c[1] & ~c[2] | c[3] & c[2] & ~c[1] & c[0]);

	assign display[3] = ~(~c[3] & ~c[2] & c[1] | ~c[3] & ~c[2] & ~c[0] | c[2] & c[1] & ~c[0] | c[3] & ~c[2] & c[0] | c[3] & ~c[1] | c[2] & ~c[1] & c[0]);

	assign display[4] = ~(~c[2] & ~c[0] | c[3] & c[2] | c[3] & c[1] | c[1] & ~c[0]);

	assign display[5] = ~(~c[3] & ~c[1] & ~c[0] | ~c[0] & c[2] | c[3] & ~c[2] & c[0] | c[3] & ~c[2] & ~c[1] | c[2] & ~c[1] & ~c[3] | c[3] & c[2] & c[1] | c[3] & c[1] & ~c[0]);

	assign display[6] = ~(~c[3] & c[1] & ~c[0] | ~c[3] & ~c[2] & c[1] | c[3] & ~c[2] & ~c[0] | c[3] & ~c[2] & ~c[1] | c[2] & ~c[1] & c[0] | ~c[3] & c[2] & ~c[1] | c[3] & c[2] & c[1] | c[3] & c[1] & c[0]);
endmodule

