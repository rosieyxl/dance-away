module Song_FSM (
    input Clock,          // Clock input
    input Reset,          // Reset signal
    input [1:0] selected_song,    // Speed control (1/2, 1/1, 2/1, 4/1)
    input [31:0] note_counter,
	 output reg [18:0] frequency,
	 output reg done
);

localparam 
A1 = 	20'd909091,
Bb1 =	20'd858068,
B1 =	20'd809908,
C2 =	20'd764451,
Db2 =	20'd721546,
D2 =	20'd681049,
Eb2 =	20'd642824,
E2 =	20'd606745,
F2 =	20'd572691,
Gb2 =	20'd540549,
G2 =	20'd510210,
Ab2 =	20'd481574,
A2 =	20'd454545,
Bb2 =	20'd429034,
B2 =	20'd404954,
C3 =	20'd382226,
Db3 =	20'd360773,
D3 =	20'd340524,
Eb3 =	20'd321412,
E3 =	20'd303373,
F3 =	20'd286346,
Gb3 =	20'd270274,
G3 =	20'd255105,
Ab3 =	20'd240787,
A3 =	20'd227273,
Bb3 =	20'd214517,
B3 =	20'd202477,
C4 =	20'd191113,
Db4 =	20'd180386,
D4 =	20'd170262,
Eb4 =	20'd160706,
E4 =	20'd151686,
F4 =	20'd143173,
Gb4 =	20'd135137,
G4 =	20'd127553,
Ab4 =	20'd120394,
A4 =	20'd113636,
Bb4 =	20'd107258,
B4 =	20'd101238,
C5 =	20'd95556,
Db5 =	20'd90193,
D5 =	20'd85131,
Eb5 =	20'd80353,
E5 =	20'd75843,
F5 =	20'd71586,
Gb5 =	20'd67569,
G5 =	20'd63776,
Ab5 =	20'd60197,
A5 =	20'd56818,
Bb5 =	20'd53629,
B5 =	20'd50619,
C6 =	20'd47778,
Db6 =	20'd45097,
D6 =	20'd42566,
Eb6 =	20'd40177,
E6 =	20'd37922,
F6 =	20'd35793,
Gb6 =	20'd33784,
G6 =	20'd31888,
Ab6 =	20'd30098,
A6 =	20'd28409,
Bb6 = 20'd26814,
B6 =  20'd25274,
C7 =  20'd23889,
Db7 = 20'd22642,
D7 =  20'd21513,
Eb7 = 20'd20491,
E7 =  20'd19556,
F7 =  20'd18677,
Gb7 = 20'd17892,
G7 =  20'd17142,
Ab7 = 20'd16429,
A7 =  20'd15758,
Bb7 = 20'd15129;
	 
	 always @(posedge Clock) begin
	 
	 done <= 0;
 
 case (selected_song)
  
  //Song 1
  4'b0001: begin
  
  // Start song
  case (note_counter)
		0: frequency <= 0;
		1: frequency <= E4;
		2: frequency <= 0;
		3: frequency <= D4;
		4: frequency <= 0;		
		5: frequency <= C4; // Example duration for A4
		6: frequency <= 0;
		7: frequency <= D4;
		8: frequency <= 0;	
		9: frequency <= E4;
		10: frequency <= 0;
		11: frequency <= E4;
		12: frequency <= 0;
		13: frequency <= E4;
		14: frequency <= 0;
		15: frequency <= D4;
		16: frequency <= 0;
		17: frequency <= D4;
		18: frequency <= 0;
		19: frequency <= D4;
		20: frequency <= 0;
		21: frequency <= E4;
		22: frequency <= 0;
		23: frequency <= G4;
		24: frequency <= 0;
		25: frequency <= G4;
		26: frequency <= 0;
		27: frequency <= E4;
		28: frequency <= 0;
		29: frequency <= D4;
		30: frequency <= 0;		
		31: frequency <= C4; // Example duration for A4
		32: frequency <= 0;
		33: frequency <= D4;
		34: frequency <= 0;	
		35: frequency <= E4;
		36: frequency <= 0;
		37: frequency <= E4;
		38: frequency <= 0;
		39: frequency <= E4;
		40: frequency <= 0;
		41: frequency <= D4;
		42: frequency <= 0;
		43: frequency <= D4;
		44: frequency <= 0;
		45: frequency <= E4;
		46: frequency <= 0;
		47: frequency <= D4;
		48: frequency <= 0;
		49: frequency <= C4;
		50: done <= 1;
		
		// Add cases for other notes and durations as needed
		default: done <= 1; // Reset when not in loop
  endcase
  
  // end song
  
  end
  
  // Song 2
  4'b0010: begin 
  
  case (note_counter + 1)

    1: frequency <= G4;
    2: frequency <= G4;
    3: frequency <= G4;
    4: frequency <= 0;
    5: frequency <= G4;
    6: frequency <= G4;
    7: frequency <= G4;
    8: frequency <= 0;
    9: frequency <= G4;
    10: frequency <= G4;
    11: frequency <= G4;
    12: frequency <= 0;
    13: frequency <= Eb4;
    14: frequency <= Eb4;
    15: frequency <= Eb4;
    16: frequency <= Bb4;

    17: frequency <= G4;
    18: frequency <= G4;
    19: frequency <= G4;
    20: frequency <= G4;
    21: frequency <= Eb4;
    22: frequency <= Eb4;
    23: frequency <= Eb4;
    24: frequency <= Bb4;
    25: frequency <= G4;
    26: frequency <= G4;
    27: frequency <= G4;
    28: frequency <= G4;
    29: frequency <= G4;
    30: frequency <= G4;
    31: frequency <= G4;
    32: frequency <= G4;

    33: frequency <= D5;
    34: frequency <= D5;
    35: frequency <= D5;
    36: frequency <= 0;
    37: frequency <= D5;
    38: frequency <= D5;
    39: frequency <= D5;
    40: frequency <= 0;
    41: frequency <= D5;
    42: frequency <= D5;
    43: frequency <= D5;
    44: frequency <= D5;
    45: frequency <= Eb5;
    46: frequency <= Eb5;
    47: frequency <= Eb5;
    48: frequency <= Bb4;

    49: frequency <= Gb4;
    50: frequency <= Gb4;
    51: frequency <= Gb4;
    52: frequency <= Gb4;
    53: frequency <= Eb4;
    54: frequency <= Eb4;
    55: frequency <= Eb4;
    56: frequency <= Bb4;
    57: frequency <= G4;
    58: frequency <= G4;
    59: frequency <= G4;
    60: frequency <= G4;
    61: frequency <= G4;
    62: frequency <= G4;
    63: frequency <= G4;
    64: frequency <= G4;

    65: frequency <= G5;
    66: frequency <= G5;
    67: frequency <= G5;
    68: frequency <= G5;
    69: frequency <= G4;
    70: frequency <= G4;
    71: frequency <= 0;
    72: frequency <= G4;
    73: frequency <= G5;
    74: frequency <= G5;
    75: frequency <= G5;
    76: frequency <= G5;
    77: frequency <= Gb5;
    78: frequency <= Gb5;
    79: frequency <= Gb5;
    80: frequency <= F5;

    81: frequency <= E5;
    82: frequency <= Eb5;
    83: frequency <= E5;
    84: frequency <= E5;
    85: frequency <= 0;
    86: frequency <= 0;
    87: frequency <= Ab4;
    88: frequency <= Ab4;
    89: frequency <= Db5;
    90: frequency <= Db5;
    91: frequency <= Db5;
    92: frequency <= Db5;
    93: frequency <= C5;
    94: frequency <= C5;
    95: frequency <= C5;
    96: frequency <= B4;

    97: frequency <= Bb4;
    98: frequency <= A4;
    99: frequency <= Bb4;
    100: frequency <= Bb4;
    101: frequency <= 0;
    102: frequency <= 0;
    103: frequency <= Eb4;
    104: frequency <= Eb4;
    105: frequency <= Gb4;
    106: frequency <= Gb4;
    107: frequency <= Gb4;
    108: frequency <= Gb4;
    109: frequency <= Eb4;
    110: frequency <= Eb4;
    111: frequency <= Eb4;
    112: frequency <= G4;

    113: frequency <= Bb4;
    114: frequency <= Bb4;
    115: frequency <= Bb4;
    116: frequency <= Bb4;
    117: frequency <= G4;
    118: frequency <= G4;
    119: frequency <= G4;
    120: frequency <= Bb4;
    121: frequency <= D5;
    122: frequency <= D5;
    123: frequency <= D5;
    124: frequency <= D5;
    125: frequency <= D5;
    126: frequency <= D5;
    127: frequency <= D5;
    128: frequency <= D5;
	 
	 //  dfsdff
	 
	 129: frequency <= G5;
    130: frequency <= G5;
    131: frequency <= G5;
    132: frequency <= G5;
    133: frequency <= G4;
    134: frequency <= G4;
    135: frequency <= 0;
    136: frequency <= G4;
    137: frequency <= G5;
    138: frequency <= G5;
    139: frequency <= G5;
    140: frequency <= G5;
    141: frequency <= Gb5;
    142: frequency <= Gb5;
    143: frequency <= Gb5;
    144: frequency <= F5;
	 
	  145: frequency <= E5;
    146: frequency <= Eb5;
    147: frequency <= E5;
    148: frequency <= E5;
    149: frequency <= 0;
    150: frequency <= 0;
    151: frequency <= Ab4;
    152: frequency <= Ab4;
    153: frequency <= Db5;
    154: frequency <= Db5;
    155: frequency <= Db5;
    156: frequency <= Db5;
    157: frequency <= C5;
    158: frequency <= C5;
    159: frequency <= C5;
    160: frequency <= B4;
	 
	 161: frequency <= Bb4;
    162: frequency <= A4;
    163: frequency <= Bb4;
    164: frequency <= Bb4;
    165: frequency <= 0;
    166: frequency <= 0;
    167: frequency <= Eb4;
    168: frequency <= Eb4;
    169: frequency <= Gb4;
    170: frequency <= Gb4;
    171: frequency <= Gb4;
    172: frequency <= Gb4;
    173: frequency <= Eb4;
    174: frequency <= Eb4;
    175: frequency <= Eb4;
    176: frequency <= Bb4;
	 
	 // yeye
	 
	   177: frequency <= G4;
    178: frequency <= G4;
    179: frequency <= G4;
    180: frequency <= G4;
    181: frequency <= Eb4;
    182: frequency <= Eb4;
    183: frequency <= Eb4;
    184: frequency <= Bb4;
    185: frequency <= G4;
    186: frequency <= G4;
    187: frequency <= G4;
    188: frequency <= G4;
	 
	 189: done <= 1;

	 /* 189: frequency <= Bb4;
    190: frequency <= A4;
    191: frequency <= Bb4;
    192: frequency <= Bb4;
    193: frequency <= 0;
    194: frequency <= 0;
    195: frequency <= Eb4;
    196: frequency <= Eb4;
    197: frequency <= G4;
    198: frequency <= G4;
    199: frequency <= G4;
    200: frequency <= G4;
    201: frequency <= Eb4;
    202: frequency <= Eb4;
    203: frequency <= Eb4;
    204: frequency <= Bb4;
	 
	     205: frequency <= Gb4;
    206: frequency <= Gb4;
    207: frequency <= Gb4;
    208: frequency <= Gb4;
    209: frequency <= Eb4;
    210: frequency <= Eb4;
    211: frequency <= Eb4;
    212: frequency <= Bb4;
    213: frequency <= Gb4;
    214: frequency <= Gb4;
    215: frequency <= Gb4;
    216: frequency <= Gb4;
    217: frequency <= Gb4;
    218: frequency <= Gb4;
    219: frequency <= Gb4;
    220: frequency <= Gb4;
	 
	    221: frequency <= 0;
    222: frequency <= 0;
    223: frequency <= D5;
    224: frequency <= D5;
    225: frequency <= E5;
    226: frequency <= E5;
    227: frequency <= C5;
    228: frequency <= C5;
    229: frequency <= 0;
    230: frequency <= 0;
    231: frequency <= B5;
    232: frequency <= B5;
    233: frequency <= A5;
    234: frequency <= A5;
    235: frequency <= Gb5;
    236: frequency <= Gb5;
	
	    237: frequency <= F7;
    238: frequency <= F7;
    239: frequency <= Db6;
    240: frequency <= Db6;
    241: frequency <= A5;
    242: frequency <= A5;
    243: frequency <= C6;
    244: frequency <= C6;
    245: frequency <= Bb5;
    246: frequency <= Bb5;
    247: frequency <= Gb5;
    248: frequency <= Gb5;
    249: frequency <= Eb5;
    250: frequency <= Eb5;
	 
	 251: frequency <= 0;
    252: frequency <= 0;
    253: frequency <= D5;
    254: frequency <= D5;
    255: frequency <= E5;
    256: frequency <= E5;
    257: frequency <= C5;
    258: frequency <= C5;
    259: frequency <= 0;
    260: frequency <= 0;
    261: frequency <= B5;
    262: frequency <= B5;
    263: frequency <= A5;
    264: frequency <= A5;
    265: frequency <= Gb5;
    266: frequency <= Gb5;*/

	 
	 //267: done <= 1;
	
	
		
		// Add cases for other notes and durations as needed
		default: done <= 1; // Silence when not in a note
  endcase
  
  
 end
 
 // Beethoven virus
 4'b0011: begin 
	
	case (note_counter + 1)
    1: frequency <= 0;
    2: frequency <= 0;
    3: frequency <= 0;
    4: frequency <= 0;
    5: frequency <= 0;
    6: frequency <= 0;
    7: frequency <= 0;
    8: frequency <= 0;
    9: frequency <= 0;
    10: frequency <= 0;
    11: frequency <= E4;
    12: frequency <= E4;
    13: frequency <= A4;
    14: frequency <= A4;
    15: frequency <= B4;
    16: frequency <= B4;

    17: frequency <= C5;
    18: frequency <= C5;
    19: frequency <= C5;
    20: frequency <= C5;
    21: frequency <= C5;
    22: frequency <= C5;
    23: frequency <= D5;
    24: frequency <= D5;
    25: frequency <= B4;
    26: frequency <= B4;
    27: frequency <= B4;
    28: frequency <= B4;
    29: frequency <= B4;
    30: frequency <= C5;
    31: frequency <= C5;

    32: frequency <= A4;
    33: frequency <= A4;
    34: frequency <= A4;
    35: frequency <= A4;
    36: frequency <= A4;
    37: frequency <= A4;
    38: frequency <= A4;
    39: frequency <= A4;
    40: frequency <= 0;
    41: frequency <= 0;
    42: frequency <= A4;
    43: frequency <= Ab4;
    44: frequency <= A4;
    45: frequency <= A4; /// B is gone
    46: frequency <= A4;
    47: frequency <= D5;
    48: frequency <= D5;

    49: frequency <= E5;
    50: frequency <= E5;
    51: frequency <= E5;
    52: frequency <= 0;
    53: frequency <= E5;
    54: frequency <= E5;
    55: frequency <= E5;
    56: frequency <= 0;
    57: frequency <= E5;
    58: frequency <= E5;
    59: frequency <= E5;
    60: frequency <= 0;
    61: frequency <= E5;
    62: frequency <= E5;
    63: frequency <= E5;
    64: frequency <= 0;
	 
	 65: frequency <= E5;
    66: frequency <= E5;
    67: frequency <= E5;
    68: frequency <= E5;
    69: frequency <= E5;
    70: frequency <= E5;
    71: frequency <= E5;
    72: frequency <= E5;
    73: frequency <= E5;
    74: frequency <= E5;
    75: frequency <= E5;
    76: frequency <= E5;
    77: frequency <= D5;
    78: frequency <= D5;
    79: frequency <= E5;
    80: frequency <= E5;
	 
	 81: frequency <= F5;
    82: frequency <= F5;
    83: frequency <= F5;
    84: frequency <= F5;
    85: frequency <= F5;
    86: frequency <= F5;
    87: frequency <= F5;
    88: frequency <= F5;
    89: frequency <= B4;
    90: frequency <= B4;
    91: frequency <= B4;
    92: frequency <= B4;
    93: frequency <= C5;
    94: frequency <= C5;
    95: frequency <= D5;
    96: frequency <= D5;

	 97: frequency <= E5;
    98: frequency <= E5;
    99: frequency <= E5;
    100: frequency <= E5;
    101: frequency <= E5;
    102: frequency <= E5;
    103: frequency <= E5;
    104: frequency <= E5;
    105: frequency <= A4;
    106: frequency <= A4;
    107: frequency <= A4;
    108: frequency <= A4;
    109: frequency <= A4;
    110: frequency <= A4;
    111: frequency <= B4;
    112: frequency <= B4;
	 
	 113: frequency <= C5;
    114: frequency <= C5;
    115: frequency <= C5;
    116: frequency <= C5;
    117: frequency <= C5;
    118: frequency <= C5;
    119: frequency <= D5;
    120: frequency <= D5;
    121: frequency <= B4;
    122: frequency <= B4;
    123: frequency <= B4;
    124: frequency <= B4;
    125: frequency <= B4;
	 126: frequency <= B4;
    127: frequency <= C5;
    128: frequency <= C5;
	 
	 // Mistake
	 
	 129: frequency <= A4;
    130: frequency <= A4;
    131: frequency <= A4;
    132: frequency <= A4;
    133: frequency <= A4;
    134: frequency <= A4;
    135: frequency <= A4;
    136: frequency <= A4;
    137: frequency <= 0;
    138: frequency <= 0;
    139: frequency <= E4;
    140: frequency <= E4;
    141: frequency <= A4;
    142: frequency <= A4;
    143: frequency <= B4;
    144: frequency <= B4;

	 145: frequency <= C5;
    146: frequency <= C5;
    147: frequency <= C5;
    148: frequency <= C5;
    149: frequency <= C5;
    150: frequency <= C5;
    151: frequency <= D5;
    152: frequency <= D5;
    153: frequency <= B4;
    154: frequency <= B4;
    155: frequency <= B4;
    156: frequency <= B4;
    157: frequency <= B4;
	 158: frequency <= B4;
    159: frequency <= C5;
    160: frequency <= C5;
	 
	 // one line
	 
	 161: frequency <= A4;
    162: frequency <= A4;
    163: frequency <= A4;
    164: frequency <= A4;
    165: frequency <= A4;
    166: frequency <= A4;
    167: frequency <= A4;
    168: frequency <= A4;
    169: frequency <= 0;
    170: frequency <= 0;
    171: frequency <= A4;
    172: frequency <= Ab4;
    173: frequency <= A4;
    174: frequency <= A4;
    175: frequency <= D5;
    176: frequency <= D5;

	 177: frequency <= E5;
    178: frequency <= E5;
    179: frequency <= E5;
    180: frequency <= 0;
    181: frequency <= E5;
    182: frequency <= E5;
    183: frequency <= E5;
    184: frequency <= 0;
    185: frequency <= E5;
    186: frequency <= E5;
    187: frequency <= E5;
    188: frequency <= 0;
    189: frequency <= E5;
    190: frequency <= E5;
    191: frequency <= E5;
    192: frequency <= 0;

	 193: frequency <= E5;
    194: frequency <= E5;
    195: frequency <= E5;
    196: frequency <= E5;
    197: frequency <= E5;
    198: frequency <= E5;
    199: frequency <= E5;
    200: frequency <= E5;
    201: frequency <= E5;
    202: frequency <= E5;
    203: frequency <= E5;
    204: frequency <= E5;
    205: frequency <= D5;
    206: frequency <= D5;
    207: frequency <= E5;
    208: frequency <= E5;

	 209: frequency <= F5;
    210: frequency <= F5;
    211: frequency <= F5;
    212: frequency <= F5;
    213: frequency <= F5;
    214: frequency <= F5;
    215: frequency <= F5;
    216: frequency <= F5;
    217: frequency <= B4;
    218: frequency <= B4;
    219: frequency <= B4;
    220: frequency <= B4;
    221: frequency <= C5;
    222: frequency <= C5;
    223: frequency <= D5;
    224: frequency <= D5;

    225: frequency <= E5;
    226: frequency <= E5;
    227: frequency <= E5;
    228: frequency <= E5;
    229: frequency <= E5;
    230: frequency <= E5;
    231: frequency <= E5;
    232: frequency <= E5;
    233: frequency <= A4;
    234: frequency <= A4;
    235: frequency <= A4;
    236: frequency <= 0;
    237: frequency <= A4;
    238: frequency <= A4;
    239: frequency <= B4;
    240: frequency <= B4;

	 241: frequency <= C5;
    242: frequency <= C5;
    243: frequency <= C5;
    244: frequency <= C5;
    245: frequency <= C5;
    246: frequency <= C5;
    247: frequency <= D5;
    248: frequency <= D5;
    249: frequency <= B4;
    250: frequency <= B4;
    251: frequency <= B4;
    252: frequency <= B4;
    253: frequency <= B4;
    254: frequency <= B4;
    255: frequency <= C5;
    256: frequency <= C5;
	 
	 257: frequency <= A4;
    258: frequency <= A4;
    259: frequency <= A4;
    260: frequency <= A4;
    261: frequency <= A4;
    262: frequency <= A4;
    263: frequency <= A4;
    264: frequency <= A4;
    265: frequency <= 0;
    266: frequency <= 0;
    267: frequency <= A4;
    268: frequency <= A4;
    269: frequency <= Ab4;
    270: frequency <= Ab4;
    271: frequency <= A4;
    272: frequency <= A4;
	 
	 273: frequency <= B4;
    274: frequency <= B4;
    275: frequency <= E4;
    276: frequency <= E4;
    277: frequency <= Eb4;
    278: frequency <= Eb4;
    279: frequency <= E4;
    280: frequency <= E4;
    281: frequency <= B4;
    282: frequency <= B4;
    283: frequency <= E4;
    284: frequency <= E4;
    285: frequency <= E5;
    286: frequency <= E5;
    287: frequency <= D5;
    288: frequency <= D5;
	
	 289: frequency <= D5;
    290: frequency <= D5;
    291: frequency <= C5;
    292: frequency <= C5;
    293: frequency <= B4;
    294: frequency <= B4;
    295: frequency <= A4;
    296: frequency <= A4;
    297: frequency <= 0;
    298: frequency <= A4;
    299: frequency <= B4;
    300: frequency <= B4;
    301: frequency <= C5;
    302: frequency <= C5;
    303: frequency <= A4;
    304: frequency <= A4;
	 
    305: frequency <= B4;
    306: frequency <= B4;
    307: frequency <= G4;
    308: frequency <= G4;
    309: frequency <= Gb4;
    310: frequency <= Gb4;
    311: frequency <= G4;
    312: frequency <= G4;
    313: frequency <= B4;
    314: frequency <= B4;
    315: frequency <= G4;
    316: frequency <= G4;
    317: frequency <= G5;
    318: frequency <= G5;
    319: frequency <= F5;
    320: frequency <= F5;
	 
	 321: frequency <= 0;
    322: frequency <= F5;
    323: frequency <= E5;
    324: frequency <= E5;
    325: frequency <= D5;
    326: frequency <= D5;
    327: frequency <= C5;
    328: frequency <= C5;
    329: frequency <= 0; // repeated C5
    330: frequency <= C5;
    331: frequency <= D5;
    332: frequency <= D5;
    333: frequency <= E5;
    334: frequency <= E5;
    335: frequency <= C5;
    336: frequency <= C5;
	 
	 337: frequency <= Db5;
    338: frequency <= Db5;
    339: frequency <= A4;
    340: frequency <= A4;
    341: frequency <= C5;
    342: frequency <= C5;
    343: frequency <= E5;
    344: frequency <= E5;
    345: frequency <= A5;
    346: frequency <= A5;
    347: frequency <= A5;
    348: frequency <= A5;
    349: frequency <= G5;
    350: frequency <= G5;
    351: frequency <= G5;
    352: frequency <= G5;
	 
	 353: done <= 1;

    
	 

	endcase
 end
 
 endcase;
  
  
  
  
 
  
 end

endmodule