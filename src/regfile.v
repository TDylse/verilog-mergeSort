/* regfile.v
Author: Based on Dr. Franzon Notes from ECE520 with modification of 32 Read Lines by Tristan Gibson

*/

module RegFile (clock, WE, WriteAddress, WriteBus, ReadBus0,ReadBus1,ReadBus2,ReadBus3,ReadBus4,ReadBus5,ReadBus6,ReadBus7,ReadBus8,ReadBus9,
                 ReadBus10,ReadBus11,ReadBus12,ReadBus13,ReadBus14,ReadBus15,ReadBus16,ReadBus17,ReadBus18,ReadBus19,ReadBus20,ReadBus21,ReadBus22,ReadBus23,ReadBus24,
				 ReadBus25,ReadBus26,ReadBus27,ReadBus28,ReadBus29,ReadBus30,ReadBus31);

input clock, WE;
input [4:0] WriteAddress;
input [7:0] WriteBus;


output [7:0] ReadBus0,ReadBus1,ReadBus2,ReadBus3,ReadBus4,ReadBus5,ReadBus6,ReadBus7,ReadBus8,ReadBus9,
             ReadBus10,ReadBus11,ReadBus12,ReadBus13,ReadBus14,ReadBus15,ReadBus16,ReadBus17,ReadBus18,ReadBus19,ReadBus20,ReadBus21,ReadBus22,ReadBus23,ReadBus24,
			 ReadBus25,ReadBus26,ReadBus27,ReadBus28,ReadBus29,ReadBus30,ReadBus31;




reg [7:0] my_memory [0:31]; // thirty-two 8-bit registers



// provide one write enable line per register
wire [31:0] WElines;
integer i;

// Write '1' into write enable line for selected register
assign WElines = (WE << WriteAddress);

always@(posedge clock)
	for (i=0; i<=31; i=i+1)
		if (WElines[i]) my_memory[i] <= WriteBus;

//assign ReadBus = Register[ReadAddress];
assign ReadBus0  = my_memory[5'd0];
assign ReadBus1  = my_memory[5'd1];
assign ReadBus2  = my_memory[5'd2];
assign ReadBus3  = my_memory[5'd3];
assign ReadBus4  = my_memory[5'd4];
assign ReadBus5  = my_memory[5'd5];
assign ReadBus6  = my_memory[5'd6];
assign ReadBus7  = my_memory[5'd7];
assign ReadBus8  = my_memory[5'd8];
assign ReadBus9  = my_memory[5'd9];
assign ReadBus10 = my_memory[5'd10];
assign ReadBus11 = my_memory[5'd11];
assign ReadBus12 = my_memory[5'd12];
assign ReadBus13 = my_memory[5'd13];
assign ReadBus14 = my_memory[5'd14];
assign ReadBus15 = my_memory[5'd15];
assign ReadBus16 = my_memory[5'd16];
assign ReadBus17 = my_memory[5'd17];
assign ReadBus18 = my_memory[5'd18];
assign ReadBus19 = my_memory[5'd19];
assign ReadBus20 = my_memory[5'd20];
assign ReadBus21 = my_memory[5'd21];
assign ReadBus22 = my_memory[5'd22];
assign ReadBus23 = my_memory[5'd23];
assign ReadBus24 = my_memory[5'd24];
assign ReadBus25 = my_memory[5'd25];
assign ReadBus26 = my_memory[5'd26];
assign ReadBus27 = my_memory[5'd27];
assign ReadBus28 = my_memory[5'd28];
assign ReadBus29 = my_memory[5'd29];
assign ReadBus30 = my_memory[5'd30];
assign ReadBus31 = my_memory[5'd31];

endmodule