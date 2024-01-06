module TopVGA
	(
		clk,						//	On Board 50 MHz
		// Your inputs and outputs here
		Reset,							// On Board Keys
		switch,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input clk;				//	50 MHz
	input Reset;
	input [1:0] switch;	
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(Reset),
			.clock(clk),
			.colour(oColour),
			.x(oX),
			.y(oY),
			.plot(drawFr),
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK),
			.VGA_SYNC(VGA_SYNC),
			.VGA_CLK(VGA_CLK)
	);

		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "ImperialMarch.mif";
			
	//wire Reset;
	//assign Reset = KEY[1];
	//wire switch;
	//assign switch = SW[1];

	wire [2:0] oColour;
	wire [7:0] oX;
	wire [6:0] oY;

	wire [7:0] clearXCount;
	wire [6:0] clearYCount;

	wire [14:0] address;
	wire drawEasy, drawFr, done;

	control C0(clk, Reset, switch, address, drawFr, drawEasy, done, fsmReset);
	datapath D0(clk, Reset, drawEasy, done, fsmReset, oX, oY, oColour, address);

endmodule

module control(
	input Clock,
	input Reset,
	input switch,
	input [14:0] address,
	output reg drawFr, drawEasy, done, fsmReset
);

	parameter X_SCREEN_PIXELS = 8'd160;
	parameter Y_SCREEN_PIXELS = 7'd120;

    localparam  HOME = 3'd0,
				WAIT_DRAW = 3'd1,
                EASY_MODE = 3'd2,
				WAIT_DONE = 3'd3;

	reg [2:0] current, next;

    always @(*)
    begin
        case(current)
            HOME: next = WAIT_DRAW;
				WAIT_DRAW: begin
				if (switch) next = EASY_MODE;
				else next = WAIT_DRAW;
			end
            EASY_MODE: begin
				if (address == 15'd19199) next = WAIT_DONE;
				else next = EASY_MODE;
			end
			WAIT_DONE: next = HOME;
			default: next = HOME;
		endcase
	end

	always @(*)
	begin
		drawEasy = 1'b0;
		fsmReset = 1'b0;
		drawFr = 1'b0;
		done = 1'b0;

		case (current)
		HOME: begin
			fsmReset = 1'b1;
			drawFr = 1'b1;
		end
		EASY_MODE: begin
			fsmReset = 1'b0;
			drawEasy = 1'b1;
			drawFr = 1'b1;
		end
		WAIT_DONE: begin
			drawEasy = 1'b0;
			drawFr = 1'b0;
			done = 1'b1;
		end
		endcase
	end

	always @(posedge Clock)
	begin
		if (Reset) current <= HOME;
		else current <= next;
	end

endmodule

module datapath(
	input Clock, Reset, drawEasy, done, fsmReset,
	output reg [7:0] oX,
	output reg [6:0] oY,
	output reg [2:0] oColour,
	output reg [14:0] address
);

	wire [2:0] iColour;
	
	mainMenu m0(address, Clock, iColour);

	parameter X_SCREEN_PIXELS = 8'd160;
	parameter Y_SCREEN_PIXELS = 7'd120;

	reg [7:0] clearXCount;
	reg [6:0] clearYCount;

	always @(posedge Clock)
	begin
		if (Reset || fsmReset) begin
			oX <= 8'd0;
			oY <= 7'b0;
			oColour <= 3'b111;
			clearXCount <= 8'b0;
			clearYCount <= 7'b0;
			address <= 15'b0;
		end
		else begin
			oX <= clearXCount;
			oY <= clearYCount;
			oColour <= iColour;

			if (drawEasy) begin
				if ((clearXCount == X_SCREEN_PIXELS - 1) && (clearYCount != Y_SCREEN_PIXELS - 1)) begin
					clearXCount <= 8'b0;
					clearYCount <= clearYCount + 1;
				end
				else clearXCount <= clearXCount + 1;
			end
			
			if (done) address <= 15'd0;
			else address <= address + 1;
		end
	end
endmodule