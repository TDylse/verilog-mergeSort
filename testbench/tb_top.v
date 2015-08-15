module tb_top;
/*systemVerilog File!

Read in the list.dat file
->write into register File
->save a local copy in test bench and call the sort() function
Start the the Merge Sort
Extract the second to last Merge to write to PenUltimate
Wait for the done flag
Calculate the number of cycles and compare the Register File to SystemVerilog sorted vector

*/

reg clock;
reg reset;
reg start;
wire done;

integer test[32];
integer mergeSorted[32];
integer FIFO4_1[16];
integer FIFO4_2[16];
integer penUltimate[32];
integer ii = 0;

reg [15:0] clkCounter,numCycles;


string dataset    = "H:/Documents/School/project/proj464data/list9.dat";
string sortedFile = "sorted9.dat";
string penFile    = "penUltimate9.dat";

always #5 clock=~clock;  //10ns clock

initial
begin
	clock = 0;
    reset = 0;
	numCycles = 0;
	$readmemh(dataset, u1.MemoryBank.my_memory);       //Put into Register File
	
	#10 reset = 1;
	#10 start = 1;                                    //start the mergeSort
	#10 start = 0;
    #800
	$writememh(sortedFile,u1.MemoryBank.my_memory);   //write the contents of Register File to disk 
	#10
	
	$readmemh(sortedFile,mergeSorted);                
	$readmemh(dataset, test);                         //Read original dataset into Vector for verification

	$display("test         %p",test);
	test.sort();                                      //sort the test vector 
	$display("test         %p",test);
	$display("MergeSort    %p",mergeSorted);
	for(int i=0;i<=31;i++)
	   begin
	     if (test[i] != mergeSorted[i]) $display("Error");    //Compare 
	   end
	
	
    $display("FIFO4_1      %p",FIFO4_1);
	$display("FIFO4_2      %p",FIFO4_2);
	
	for(int i=0;i<=31;i++)
	  begin
	   if (i<16)
	    penUltimate[i] = FIFO4_1[i];
	   else
	    penUltimate[i] = FIFO4_2[i-16];
	  end
	$writememh(penFile,penUltimate);    
	$readmemh(penFile, test);
	$display("penUltimate  %p",test);
	
end


always@(posedge done)                                        //Print number of cycles since we started
 begin
   numCycles = clkCounter;
   $display("Done! %p Cycles", numCycles);
end

always@(posedge clock)                                        //count clock cycles since the start flag
 begin
   if (start == 1) clkCounter = 0;
   
   if (!done) clkCounter = clkCounter + 1;
 end

always@(posedge clock)                                        //Grab the data before Final Merge for PenUltimate
  begin
   if (!u1.FIFO4_1_push)
    begin
	  FIFO4_1[ii] = u1.FIFO4_1_datain;
	  FIFO4_2[ii] = u1.FIFO4_2_datain;
      ii = ii + 1;
	end
  end


top u1 (clock,reset,start,done);

endmodule