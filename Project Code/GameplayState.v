module GameplayState (
    input wire clk,
    input wire rst,
    input wire btn_up,
    input wire btn_down,
    input wire btn_left,
    input wire btn_right,
    input wire enable, // Module activation
    input wire [1:0] difficulty,
    input wire [3:0] selected_song,
	 input wire [15:0] bpm_input, // Renamed to bpm_input
    output reg game_over,
	 
	 // Game logic
	 output [9:0] LEDR,
	 //output [6:0] HEX0,
	 //output [6:0] HEX1,
	 //output [6:0] HEX2,
	 output [6:0] HEX3,
	 output [6:0] HEX4,
	 output [6:0] HEX5,
	 
	 // Top level
	 input				AUD_ADCDAT,
	inout				AUD_BCLK,
	inout				AUD_ADCLRCK,
	inout				AUD_DACLRCK,
	inout				FPGA_I2C_SDAT,
	output				AUD_XCK,
	output				AUD_DACDAT,
	output				FPGA_I2C_SCLK
);

	wire audioFinish;
	

	Music_Player mop(	
	.clk(clk),
	.reset(rst),
	.play(enable), // Disable when module is not activated
	.selected_song(selected_song),
	.difficulty(difficulty),
	.bpm_input(bpm_input),
	.done(audioFinish),
	
	.AUD_ADCDAT(AUD_ADCDAT),
	// Bidirectionals
	.AUD_BCLK(AUD_BCLK),
	.AUD_ADCLRCK(AUD_ADCLRCK),
	.AUD_DACLRCK(AUD_DACLRCK),

	.FPGA_I2C_SDAT(FPGA_I2C_SDAT),

	// Outputs
	.AUD_XCK(AUD_XCK),
	.AUD_DACDAT(AUD_DACDAT),

	.FPGA_I2C_SCLK(FPGA_I2C_SCLK)	
);

// Hex decoder
	/*hex_decoder x1 (
        .c(score[3:0]),
        .display(HEX0)
    );
	 
	 hex_decoder x2 (
        .c(score[6:4]),
        .display(HEX1)
    );
	 
	 hex_decoder x3 (
        .c(score[9:5]),
        .display(HEX2)
    );*/
	 
	 hex_decoder x4 (
        .c(streak[3:0]),
        .display(HEX3)
    );
	 
	 hex_decoder x5 (
        .c(score[3:0]),
        .display(HEX4)
    );
	 
	 hex_decoder x6 (
        .c(score[6:4]),
        .display(HEX5)
    );
	 
	 
	 

	
    wire [1:0] arrowPos;
    wire spawnArrow;
	 
	 reg leftLight, rightLight, upLight, downLight;
	 
	 assign LEDR[3] = leftLight;
	 assign LEDR[0] = rightLight;
	 assign LEDR[1] = upLight;
	 assign LEDR[2] = downLight;
	 
	 
    reg [1:0] arrowPosition;
    reg [15:0] litCounter; // Counter to control how long the arrow remains lit

	 wire [31:0] score;
	 wire [31:0] streak;
	 
	 reg [1:0] updater;
	 
	  RandomNumber randy(
        .clk(clk),
        .randNum(arrowPos)
    );

    RateDividerDemo #(.CLOCK_FREQUENCY(400000000) // *8
    ) rat5 (
        .ClockIn(clk),
        .BPM(bpm_input),
        .Reset(rst),
        .Speed(difficulty),
        .Enable(spawnArrow)
    );
	 
	CombinedWrapper comby(
  .clk(clk),
  .reset(rst),
  .score_updater_selector(updater), // Selector for the ScoreUpdater
  .score_out(score),
  .streak_out(streak)
);

	reg streak1, streak2, streak3, streak4, streak5;
	
	 assign LEDR[9] = streak1;
	 assign LEDR[8] = streak2;
	 assign LEDR[7] = streak3;
	 assign LEDR[6] = streak4;
	 assign LEDR[5] = streak5;

    // State transition logic
    always @(posedge clk or posedge rst) begin
			   streak1 <= (streak > 0);
				streak2 <= (streak > 1);
				streak3 <= (streak > 2);
				streak4 <= (streak > 3);
				streak5 <= (streak > 4);
				
        if (rst) begin
            game_over = 0;
				arrowPosition <= 2'b00;
            litCounter <= 16'b0;
            leftLight <= 0;
            rightLight <= 0;
            upLight <= 0;
            downLight <= 0;
				streak1 <= 0;
				streak2 <= 0;
				streak3 <= 0;
				streak4 <= 0;
				streak5 <= 0;
        end
        else if (enable) begin
			  $display("Game Settings: Difficulty = %s, Song = %s", 
			  ((difficulty == 0) ? "Easy" : ((difficulty == 1) ? "Medium" : "Hard")), 
			  ((selected_song == 4'b0001) ? "Song 1" :   ((selected_song == 4'b0010) ? "Song 2" : "Song 3")) );
            
				// Gameplay logic

				updater <= 2'b00;
				
				
            // Arrow position logic
            if (spawnArrow) begin
                arrowPosition <= arrowPos; // Set arrow position based on random number
                litCounter <= 16'b0;
                // Set corresponding light
                case(arrowPosition)
                    2'b11: leftLight <= 1;
                    2'b00: rightLight <= 1;
                    2'b01: upLight <= 1;
                    2'b10: downLight <= 1;
                endcase
            end else begin
                // Handle button presses and score logic
                if (btn_left) begin
					 
						 if (leftLight) begin
							  leftLight <= 0;
							  updater <= 2'b01;
							  end
						  else begin
							  updater <= 2'b11;
						  end

                end
                if (btn_right) begin
						  
						  if (rightLight) begin
							  rightLight <= 0;
							  updater <= 2'b01;
							  end
						  else begin
							  updater <= 2'b11;
						  end
						  
                end
                if (btn_up) begin
						  
						  if (upLight) begin
							  upLight <= 0;
							  updater <= 2'b01;
							  end
						  else begin
							  updater <= 2'b11;
						  end
						  
                end
                if (btn_down) begin
						  
						  if (downLight) begin
							  downLight <= 0;
							  updater <= 2'b01;
							  end
						  else begin
							  updater <= 2'b11;
						  end
						  
						  
                    // Add score logic here if needed
						  
                end
					 
					 
            end


				
				
				
				
				
				
				
				// Gameplay logic end

				
				
				if (audioFinish) begin
                $display("Game over conditions met");
					 // There is a bug here, when repeated playing, game over is still one
                game_over = 1;
            end
            else begin
                game_over = 0;
            end
        end
    end

endmodule
