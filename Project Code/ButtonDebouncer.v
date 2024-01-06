module ButtonDebouncer (
    input wire clk,
    input wire rst,
    input wire raw_btn, // Raw button state
    output reg debounced_btn // Debounced button state
);

    // Define parameters for debouncing
    parameter DEBOUNCE_DELAY = 10; // Adjust as needed

    // Internal signals for debounce logic
    reg [DEBOUNCE_DELAY-1:0] shift_reg;
    reg [DEBOUNCE_DELAY-1:0] shift_reg_d1;
    reg [DEBOUNCE_DELAY-1:0] shift_reg_d2;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            shift_reg <= {DEBOUNCE_DELAY{1'b0}};
            shift_reg_d1 <= {DEBOUNCE_DELAY{1'b0}};
            shift_reg_d2 <= {DEBOUNCE_DELAY{1'b0}};
        end else begin
            // Shift the register
            shift_reg_d2 <= shift_reg_d1;
            shift_reg_d1 <= shift_reg;
            shift_reg <= {shift_reg[DEBOUNCE_DELAY-2:0], raw_btn};
            
            // Debounce logic
            if ((shift_reg == shift_reg_d1) && (shift_reg == shift_reg_d2))
                debounced_btn <= shift_reg[DEBOUNCE_DELAY-1];
        end
    end
endmodule
