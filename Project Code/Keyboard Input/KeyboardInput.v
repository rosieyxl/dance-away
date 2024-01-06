
module KeyboardInput (
	// Inputs
	clk,
	holdLeft, 
	holdRight, 
	holdUp, 
	holdDown,
	reset,

	// Bidirectionals
	PS2_CLK,
	PS2_DAT,
	
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/

// Inputs
input				clk;
input reset;
//input		[3:0]	KEY;

// Bidirectionals
inout				PS2_CLK;
inout				PS2_DAT;

output reg holdLeft, holdRight, holdUp, holdDown;

// Outputs
/*
output		[6:0]	HEX0;
output		[6:0]	HEX1;
output		[6:0]	HEX2;
output		[6:0]	HEX3;
output		[6:0]	HEX4;
output		[6:0]	HEX5;
output		[6:0]	HEX6;
output		[6:0]	HEX7;
output		[9:0] LEDR;
*/

/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/

// Internal Wires
wire		[7:0]	ps2_key_data;
wire				ps2_key_pressed;

// Internal Registers
reg			[7:0]	last_data_received;

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/

 localparam LEFT = 8'h6B,
          UP = 8'h75,
          RIGHT = 8'h74,
          DOWN = 8'h72,
          BREAK = 8'hF0;

//reg left, up, right, down;
reg breaky;
reg shift, wait12, clean;
reg [3:0] current, next;

localparam  SHIFT = 4'd0,
             CLEAR = 4'd10,
             CLEARALL = 4'd11,
             WAIT = 4'd9,
             LEFT1 = 4'd5,
             UP1 = 4'd6,
             RIGHT1 = 4'd7,
             DOWN1 = 4'd8;

/*assign LEDR[9] = shift;
assign LEDR[8] = wait12;
assign LEDR[7] = clean;
assign LEDR[4] = breaky;
assign LEDR[3] = holdLeft;
assign LEDR[2] = holdUp;
assign LEDR[1] = holdRight;
assign LEDR[0] = holdDown;*/


//reg holdLeft, holdRight, holdUp, holdDown;

always @(*)
begin
    case (current)
        shift: next = ps2_key_pressed ? WAIT : shift;
        WAIT: begin
            if (last_data_received == LEFT) begin
                next = LEFT1;
            end
            else if (last_data_received == UP) begin
                next = UP1;
            end
            else if (last_data_received == RIGHT) begin
                next = RIGHT1;
            end
            else if (last_data_received == DOWN) begin
                next = DOWN1;
            end
            else begin
                next = WAIT;
            end
        end
        LEFT1: begin
            if (last_data_received == BREAK) begin
                next = CLEAR;
            end
            else begin
                next = LEFT1;
            end
        end
        UP1: begin
            if (last_data_received == BREAK) begin
                next = CLEAR;
            end
            else begin
                next = UP1;
            end
        end
        RIGHT1: begin
            if (last_data_received == BREAK) begin
                next = CLEAR;
            end
            else begin
                next = RIGHT1;
            end
        end
        DOWN1: begin
            if (last_data_received == BREAK) begin
                next = CLEAR;
            end
            else begin
             next = DOWN1;
            end
        end
        CLEAR: begin
            if (last_data_received == LEFT) begin
                next = CLEARALL;
            end
            else if (last_data_received == UP) begin
                next = CLEARALL;
            end
            else if (last_data_received == RIGHT) begin
                next = CLEARALL;
            end
            else if (last_data_received == DOWN) begin
                next = CLEARALL;
            end
            else begin
                next = CLEAR;
            end
        end
        CLEARALL: next = ps2_key_pressed ? CLEARALL : shift;
    default: next = shift;
    endcase
end

always @(posedge clk)
begin
    /*left = 0;
    up = 0;
    right = 0;
    down = 0;*/
    shift = 0;
    wait12 = 0;
    clean = 0;
    holdDown = 0;
    holdRight = 0;
    holdLeft = 0;
    holdUp = 0;
    case (current)
        shift: shift = 1;
        WAIT: begin
            wait12 = 1;
        end
        LEFT1: begin
            holdLeft = 1;
        end
        UP1: begin
            holdUp = 1;
        end
        RIGHT1: begin
            holdRight = 1;
        end
        DOWN1: begin
            holdDown = 1;
        end

        CLEARALL: begin
            holdDown = 0;
            holdRight = 0;
            holdLeft = 0;
            holdUp = 0;
        end
    endcase
end

always @(posedge clk)
begin
    if (reset) begin
        last_data_received <= 8'h00;
    end
    else if (ps2_key_pressed == 1'b1) begin
        last_data_received <= ps2_key_data;
    end
    current <= next;
end


/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

PS2_Controller PS2 (
	// Inputs
	.CLOCK_50				(clk),
	.reset				(reset),

	// Bidirectionals
	.PS2_CLK			(PS2_CLK),
 	.PS2_DAT			(PS2_DAT),

	// Outputs
	.received_data		(ps2_key_data),
	.received_data_en	(ps2_key_pressed)
);


endmodule
