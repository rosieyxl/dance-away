module RandomNumber(clk, randNum);

input clk;
reg storedValue;
output reg [1:0] randNum;

reg [127:0] seed = 128'b1011011000010111100100011100111101101011100011011111100111010100110110101101101010101010111101010111101001111001001101101111101010011010000011111110101011100101010110010111110110111011111011110000111000100111101100100111010111010001001000011111100000110011011000110010100111101111110111010010111000011000111001001010110011000000110011111111100011101000100101011101101111101011000110111110101101101111111100111010101101011111111000100101100110001100111111000100101101011110111001101111101110101110100110101100100100101010111010000111111101101110100101111100111101011011100101001000110001000101101100011010101001010100111001101011100010110111111010101001001110000101000101100001001000010110111011011101;


always @(posedge clk)
begin

storedValue = seed[0];
seed = seed >> 1;
seed[127] = storedValue;
randNum = seed[1:0];

end

endmodule