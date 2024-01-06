module SongSelector (
    input wire clk,
    input wire rst,
    input wire btn_left,
    input wire btn_right,
    input wire enable, // Enable signal from FiniteStateSample
    output reg [3:0] selected_song,
    output reg [63:0] popup_message,
    output reg [15:0] bpm_output // Output for BPM
);

    // Define parameters for songs and BPM
    parameter SONG1 = 4'b0001;
    parameter SONG2 = 4'b0010;
    parameter SONG3 = 4'b0011;
    // Add more songs as needed

    // Define custom messages for the popup
    parameter [63:0] SONG1_MESSAGE = "Song 1";
    parameter [63:0] SONG2_MESSAGE = "Song 2";
    parameter [63:0] SONG3_MESSAGE = "Song 3";
    // Add more messages for additional songs

    // Define BPM for each song
    parameter [7:0] SONG1_BPM = 120;
    parameter [7:0] SONG2_BPM = 140;
    parameter [7:0] SONG3_BPM = 160;
    // Add more BPMs for additional songs

    // Define signals
    reg [3:0] next_song = SONG1; // Initialize next_song

    // State transition logic, modified to use enable signal
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            next_song = SONG1;
            popup_message <= SONG1_MESSAGE; // Reset message during reset
        end
        else if (enable) begin
            case (selected_song)  // Use selected_song for transitions
                SONG1:
                    if (btn_right) begin
                        $display("btn_right detected, going to Song 2");
                        popup_message <= SONG2_MESSAGE;
                        next_song <= SONG2;
								// a specific control signal "song1 = 1'b1;"
                    end
                SONG2:
                    if (btn_left) begin
                        $display("btn_left detected, going to Song 1");
                        popup_message <= SONG1_MESSAGE;
                        next_song <= SONG1;
                    end
                    else if (btn_right) begin
                        $display("btn_right detected, going to Song 3");
                        popup_message <= SONG3_MESSAGE;
                        next_song <= SONG3;
                    end
                SONG3:
                    if (btn_left) begin
                        $display("btn_left detected, going to Song 2");
                        popup_message <= SONG2_MESSAGE;
                        next_song <= SONG2;
                    end
                // Add more cases for additional songs
            endcase
        end
    end

    // Output logic, modified to use enable signal
    always @(posedge clk) begin
        if (rst) begin
            selected_song <= SONG1;
        end
        else if (enable) begin
            $display("SongSelector enabled: Selected Song = %s, Message = %s, BPM = %d",
                      ((selected_song == SONG1) ? "Song 1" : ((selected_song == SONG2) ? "Song 2" : "Song 3")),
                      popup_message, ((selected_song == SONG1) ? SONG1_BPM : ((selected_song == SONG2) ? SONG2_BPM : SONG3_BPM)));
            selected_song <= next_song;
            bpm_output <= ((selected_song == SONG1) ? SONG1_BPM : ((selected_song == SONG2) ? SONG2_BPM : SONG3_BPM));
        end
    end

endmodule
