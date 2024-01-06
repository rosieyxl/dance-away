module DifficultySelector (
    input wire clk,
    input wire rst,
    input wire btn_left,
    input wire btn_right,
    input wire enable, // Enable signal from FiniteStateSample
    output reg [1:0] difficulty,
    output reg [63:0] popup_message
);

    // Define parameters for difficulties
    parameter EASY = 2'b00;
    parameter MEDIUM = 2'b01;
    parameter HARD = 2'b10;

    // Define custom messages for the popup
    parameter [63:0] EASY_MESSAGE = "Easy";
    parameter [63:0] MEDIUM_MESSAGE = "Medium";
    parameter [63:0] HARD_MESSAGE = "Hard";

    // Define signals
    reg [1:0] next_difficulty = EASY; // Initialize next_difficulty

    // State transition logic, modified to use enable signal
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            next_difficulty = EASY;
            popup_message <= EASY_MESSAGE; // Reset message during reset
        end
        else if (enable) begin
		  //$display("Hello?")
            case (next_difficulty)
                EASY:
                    if (btn_right) begin
                        $display("btn_right detected, going to Medium difficulty");
                        popup_message <= MEDIUM_MESSAGE;
                        next_difficulty <= MEDIUM;
                    end
                MEDIUM:
                    if (btn_left) begin
                        $display("btn_left detected, going to Easy difficulty");
                        popup_message <= EASY_MESSAGE;
                        next_difficulty <= EASY;
                    end
                    else if (btn_right) begin
                        $display("btn_right detected, going to Hard difficulty");
                        popup_message <= HARD_MESSAGE;
                        next_difficulty <= HARD;
                    end
                HARD:
                    if (btn_left) begin
                        $display("btn_left detected, going to Medium difficulty");
                        popup_message <= MEDIUM_MESSAGE;
                        next_difficulty <= MEDIUM;
                    end
            endcase
        end
    end

    // Output logic, modified to use enable signal
always @(posedge clk) begin
    if (rst) begin
        difficulty <= EASY;
    end
    else if (enable) begin
        //$display("DifficultySelector enabled: State = %s, Message = %s", ((difficulty == EASY) ? "Easy" : ((difficulty == MEDIUM) ? "Medium" : "Hard")), popup_message);
        difficulty <= next_difficulty;
    end
end


endmodule