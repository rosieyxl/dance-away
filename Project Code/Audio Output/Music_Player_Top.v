module Music_Player_Top(
	// Inputs
	CLOCK_50,
	KEY,
	SW,
	HEX0,
	HEX1,
	LEDR,

	AUD_ADCDAT,

	// Bidirectionals
	AUD_BCLK,
	AUD_ADCLRCK,
	AUD_DACLRCK,

	FPGA_I2C_SDAT,

	// Outputs
	AUD_XCK,
	AUD_DACDAT,

	FPGA_I2C_SCLK
	
);

input				CLOCK_50;
input		[3:0]	KEY;
input 	[9:0] SW;
output [6:0] HEX0;
output [6:0] HEX1;
output [9:0] LEDR;


input				AUD_ADCDAT;

// Bidirectionals
inout				AUD_BCLK;
inout				AUD_ADCLRCK;
inout				AUD_DACLRCK;

inout				FPGA_I2C_SDAT;

// Outputs
output				AUD_XCK;
output				AUD_DACDAT;

output				FPGA_I2C_SCLK;


wire done;


assign LEDR[5] = done;

Music_Player magpie(
	
	.clk(CLOCK_50),
	.reset(SW[9]),
	.selected_song(SW[3:2]),
	.difficulty(SW[1:0]),
	.HEX0(HEX0),
	.HEX1(HEX1),
	.play(SW[8]),
	.bpm_input(16'b1111000),
	
	

	.AUD_ADCDAT(AUD_ADCDAT),

	// Bidirectionals
	.AUD_BCLK(AUD_BCLK),
	.AUD_ADCLRCK(AUD_ADCLRCK),
	.AUD_DACLRCK(AUD_DACLRCK),

	.FPGA_I2C_SDAT(FPGA_I2C_SDAT),

	// Outputs
	.AUD_XCK(AUD_XCK),
	.AUD_DACDAT(AUD_DACDAT),

	.FPGA_I2C_SCLK(FPGA_I2C_SCLK),
	.done(done)
	
);


endmodule