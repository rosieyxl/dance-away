module ConfirmationPopup (
    input wire clk,
    input wire rst,
    input wire activate,   // Signal to activate the confirmation popup
    input wire btn_up,     // Cancel button
    input wire btn_down,   // Confirm button
    input [15:0] custom_message, // Custom message for the popup
    output reg confirmed, // Signal to indicate whether the user confirmed the action
    output reg canceled   // Signal to indicate whether the user canceled the action
);
    // Define parameters for states
    parameter IDLE = 2'b00;
    parameter ACTIVE = 2'b01;
    parameter CONFIRMED = 2'b10;
    parameter CANCELED = 2'b11;

    // Define signals
    reg [1:0] state, next_state;
    reg [15:0] message;

    // State register
    always @(posedge clk or posedge rst)
        if (rst)
            state <= IDLE;
        else
            state <= next_state;

    // State transition logic
    always @(posedge clk) begin
        // Default next state values
        next_state = state;
        confirmed = 1'b0;
        canceled = 1'b0;

        // Default message value
		  // Implement how to display this
        message = custom_message;

        case (state)
            IDLE:
                if (activate)
                    next_state = ACTIVE;
            ACTIVE:
                if (activate)
                    next_state = CONFIRMED;
                else if (btn_up)
                    next_state = CANCELED;
                else if (btn_down)
                    next_state = CONFIRMED;
            CONFIRMED:
                // Additional logic if needed
            CANCELED:
                // Additional logic if needed
        endcase
    end
endmodule

// How to implement

/*
ConfirmationPopup difficulty_confirmation (
    .clk(clk),
    .rst(rst),
    .activate(difficulty_selector.confirm_popup), // Connect to difficulty_selector's confirm_popup
    .btn_up(btn_up),     // Connect to cancel button
    .btn_down(btn_down), // Connect to confirm button
    .custom_message("Confirm difficulty selection?"), // Set the custom message
    .confirmed(difficulty_confirmed), // Signal to indicate confirmation
    .canceled(difficulty_canceled)    // Signal to indicate cancelation
);
*/
