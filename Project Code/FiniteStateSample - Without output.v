module FiniteStateSample (
    input wire clk,
    input wire rst,
    input wire btn_up,
    input wire btn_down,
    input wire btn_left,
    input wire btn_right
);

    // Define parameters for states
    parameter MAIN_MENU = 2'b00;
    parameter DIFFICULTY_SELECTOR = 2'b01;
    parameter SONG_SELECTOR = 2'b10;
    parameter GAMEPLAY = 2'b11;

    // Define signals
    reg [1:0] state;
    reg [1:0] next_state;
    wire [1:0] difficulty; // To store selected difficulty
    wire [3:0] selected_song; // To store selected song
    wire [63:0] popup_message; // Custom message for the popup
    reg difficulty_selector_enable; // Enable signal for DifficultySelector
    reg song_selector_enable; // Enable signal for SongSelector
    reg gameplay_enable; // Enable signal for GameplayState

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
        .popup_message(popup_message)
    );

    // Instantiate GameplayState
GameplayState gameplayState_inst (
    .clk(clk),
    .rst(rst),
    .btn_up(btn_up),
    .btn_down(btn_down),
    .btn_left(btn_left),
    .btn_right(btn_right),
    .enable(gameplay_enable),
    .difficulty(difficulty),         // Pass difficulty
    .selected_song(selected_song),   // Pass selected_song
    .game_over(game_over)
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= MAIN_MENU;
            next_state <= MAIN_MENU;
            difficulty_selector_enable = 0;
            song_selector_enable = 0;
            gameplay_enable = 0;
        end
        else begin
            state <= next_state;
        end
    end

    // State transition logic
    always @(posedge clk) begin
        difficulty_selector_enable = (state == DIFFICULTY_SELECTOR);
        song_selector_enable = (state == SONG_SELECTOR);
        gameplay_enable = (state == GAMEPLAY);

        case (state)
            MAIN_MENU: 
                begin
                    $display("State = Main Menu");
                    if (btn_up || btn_down || btn_left || btn_right) begin
                        next_state = DIFFICULTY_SELECTOR;
                    end
                end    
            DIFFICULTY_SELECTOR:
                begin
                    $display("State = Difficulty Selector");
                    if (btn_up) begin
                        next_state = MAIN_MENU;
                        $display("btn_up detected, going back to main");
                    end
                    else if (btn_down) begin
                        next_state = SONG_SELECTOR;
                        $display("btn_down detected, going to song selector");
                    end
                end
            SONG_SELECTOR:
                begin
                    $display("State = Song Selector");
                    // Add your display statements for selected difficulty and song here
                    if (btn_up) begin
                        $display("btn_up detected, going back to difficulty selector");
                        next_state = DIFFICULTY_SELECTOR;
                    end
                    else if (btn_down) begin
                        $display("btn_down detected, going to gameplay");
                        next_state = GAMEPLAY;
                    end
                end
            GAMEPLAY:
                begin
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
    end

endmodule
