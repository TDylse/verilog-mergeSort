module tb_regfile;
/*load the register File with data from *.dat files,then write a pattern*/


reg clock;
reg reset;
reg WE;    
reg [4:0]  WriteAddress;
reg [7:0]  WriteBus;



wire [7:0] ReadBus0,ReadBus1,ReadBus2,ReadBus3,ReadBus4,ReadBus5,ReadBus6,ReadBus7,ReadBus8,ReadBus9,ReadBus10,ReadBus11,ReadBus12,ReadBus13,
           ReadBus14,ReadBus15,ReadBus16,ReadBus17,ReadBus18,ReadBus19,ReadBus20,ReadBus21,ReadBus22,ReadBus23,ReadBus24,ReadBus25,ReadBus26,ReadBus27,ReadBus28,ReadBus29,
		   ReadBus30,ReadBus31;



initial // setup vectors
  begin
   	$readmemh("H:/Documents/School/project/proj464data/list0.dat", u1.my_memory);  
    WE = 1;
end

 
initial //following block executed only once

begin
     clock = 0;
     reset = 0;
	 #10 reset = 1;
	 WriteAddress = 8'd0;
	 WriteBus = 0;
 end
 
always@(posedge clock)
 begin
    WriteAddress = WriteAddress + 1;
    WriteBus = WriteBus + 1; 
 end

always #5 clock=~clock;  //10ns clock

RegFile u1 (clock, WE, WriteAddress, WriteBus, ReadBus0,ReadBus1,ReadBus2,ReadBus3,ReadBus4,ReadBus5,ReadBus6,ReadBus7,ReadBus8,ReadBus9,
                 ReadBus10,ReadBus11,ReadBus12,ReadBus13,ReadBus14,ReadBus15,ReadBus16,ReadBus17,ReadBus18,ReadBus19,ReadBus20,ReadBus21,ReadBus22,ReadBus23,ReadBus24,
				 ReadBus25,ReadBus26,ReadBus27,ReadBus28,ReadBus29,ReadBus30,ReadBus31);
endmodule