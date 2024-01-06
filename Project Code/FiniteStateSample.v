module FiniteStateSample (
    input wire clk,
    input wire rst,
    input wire btn_up,
    input wire btn_down,
    input wire btn_left,
    input wire btn_right,
    output reg [3:0] state_output, // Tentative output
    output reg [3:0] selectedSong, // Tentative output
	 output reg [3:0] difficutlySelected, // Tentative output
	 
	 // Audio Top level
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
	output			VGA_BLANK,				//	VGA BLANK
	output			VGA_SYNC,				//	VGA SYNC
	output	[7:0]	VGA_R,   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G,	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B,   				//	VGA Blue[7:0]
	
	// Gameplay Top level
	output [6:0 ]HEX3y,
	output [6:0 ]HEX4y,
	output [6:0 ]HEX5y,
	output [9:0] LEDR
);

    // Define parameters for states
    parameter MAIN_MENU = 2'b00;
	 parameter SONG_SELECTOR = 2'b01;
    parameter DIFFICULTY_SELECTOR = 2'b010; 
    parameter GAMEPLAY = 2'b11;

    // Define signals
    reg [1:0] state;
    reg [1:0] next_state;
    wire [1:0] difficulty; // To store selected difficulty
    wire [3:0] selected_song; // To store selected song
    wire [63:0] popup_message; // Custom message for the popup
    wire [15:0] bpm; // To store BPM
    reg difficulty_selector_enable; // Enable signal for DifficultySelector
    reg song_selector_enable; // Enable signal for SongSelector
    reg gameplay_enable; // Enable signal for GameplayState
	 
	 // Jolt reset Gameplay every time we start
	 reg gameplayReset;
	 
	 // VGA
	 TopVGA topy(
			.Reset(!rst),
			.clk(clk),
			.switch(state),

			// Top levels
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK),
			.VGA_SYNC(VGA_SYNC),
			.VGA_CLK(VGA_CLK)
	);

    // Instantiate DifficultySelector
    DifficultySelector difficultySelector_inst (
        .clk(clk),
        .rst(rst),
        .btn_left(btn_left),
        .btn_right(btn_right),
        .enable(difficulty_selector_enable), // Connect enable signal
        .difficulty(difficulty),
        .popup_message(popup_message)
    );

    // Instantiate SongSelector
    SongSelector songSelector_inst (
        .clk(clk),
        .rst(rst),
        .btn_left(btn_left),
        .btn_right(btn_right),
        .enable(song_selector_enable), // Connect enable signal
        .selected_song(selected_song),
        .popup_message(popup_message),
        .bpm_output(bpm)
    );

    // Instantiate GameplayState
    GameplayState gameplayState_inst (
        .clk(clk),
        .rst(gameplayReset), // Jolt reset
        .btn_up(btn_up),
        .btn_down(btn_down),
        .btn_left(btn_left),
        .btn_right(btn_right),
        .enable(gameplay_enable),
        .difficulty(difficulty),         // Pass difficulty
        .selected_song(selected_song),   // Pass selected_song
        .game_over(game_over),
        .bpm_input(bpm),
		  
		  // Pass top level
		  .AUD_ADCDAT(AUD_ADCDAT),
			.AUD_BCLK(AUD_BCLK),
			.AUD_ADCLRCK(AUD_ADCLRCK),
			.AUD_DACLRCK(AUD_DACLRCK),
			.FPGA_I2C_SDAT(FPGA_I2C_SDAT),
			.AUD_XCK(AUD_XCK),
			.AUD_DACDAT(AUD_DACDAT),
			.FPGA_I2C_SCLK(FPGA_I2C_SCLK),	
			
			// Pass Gameplay Top level
			//.HEX0(HEX0),
	 //.HEX1(HEX1),
	 //.HEX2(HEX2),
	 .HEX3(HEX3y),
	 .HEX4(HEX4y),
	 .HEX5(HEX5y),
	 .LEDR(LEDR)
    );
	 

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state = MAIN_MENU;
            next_state = MAIN_MENU;
            difficulty_selector_enable = 0;
            song_selector_enable = 0;
            gameplay_enable = 0;
        end
        else begin
            state = next_state;
        end

        // Assign the value of 'state' to the output reg 'state_output'
        state_output <= state;
		  selectedSong <= selected_song;
		  difficutlySelected <= difficulty;
		  

        difficulty_selector_enable = (state == DIFFICULTY_SELECTOR);
        song_selector_enable = (state == SONG_SELECTOR);
        gameplay_enable = (state == GAMEPLAY);

        case (state)
            MAIN_MENU: 
                begin
                    $display("State = Main Menu");
                    if (btn_up || btn_down || btn_left || btn_right) begin
                        next_state = SONG_SELECTOR;
								// down sound
                    end
                end 
			SONG_SELECTOR:
                begin
                    $display("State = Song Selector");
                    // Add your display statements for selected difficulty, song, and BPM here
                    $display("Selected Difficulty = %d, Selected Song = %s, BPM = %d", difficulty, ((selected_song == 4'b0001) ? "Song 1" : ((selected_song == 4'b0010) ? "Song 2" : "Song 3")), bpm);
                    if (btn_up) begin
                        $display("btn_up detected, going back to Main menu");
                        next_state = MAIN_MENU;
								// up sound
                    end
                    else if (btn_down) begin
                        $display("btn_down detected, going to Difficulty selector");
                        next_state = DIFFICULTY_SELECTOR;
								// gameplay sound
                    end
                end		 
            DIFFICULTY_SELECTOR:
                begin
                    $display("State = Difficulty Selector");
                    if (btn_up) begin
                        next_state = SONG_SELECTOR;
                        $display("btn_up detected, going back to Song Selector");
								// up sound
                    end
                    else if (btn_down) begin
                        next_state = GAMEPLAY;
                        $display("btn_down detected, going to Gameplay");
								// down sound
                    end
                end
            GAMEPLAY:
                begin
						// NEED TO IMPLEMENT JOLT RESET
                    $display("State = Gameplay");
                    // Add logic for gameplay state
                    // Transition back to SONG_SELECTOR when the game is finished
                    // You can use the game_over signal to indicate when the game is finished
                    if (game_over) begin
                        $display("Game over detected, going back to song selector");
                        next_state = SONG_SELECTOR;
                    end
                end
        endcase
		  
		  // if song selector or difficulty selector  changed, play sound.
    end
	 
	 
	 // Jolt reset for gameplay
	 always @(posedge gameplay_enable or posedge rst) begin
		gameplayReset = ((rst + game_over) > 0);
	 
	 end

endmodule


// New module
// takes in duration, clock, reset, outputs the signal back for the duration in the input.
