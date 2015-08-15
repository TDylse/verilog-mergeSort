module tb_sort2values;
/*test the three cases A=B, A<B, A>B and verify the control signal start and 
and the push signal*/


reg clock;
reg reset;
reg start;    

reg [7:0]  A,B;
wire [7:0] data_out;
wire push;
 
initial //following block executed only once

begin
     clock = 0;
     reset = 0;
	 #10 reset = 1;
	 start = 1;
	 A = 5; B = 5;
	 #20 start  = 0;
	 #10 start  = 1; A = 10;B = 20;
	 #20 start  = 0; 
	 #10 start  = 1;A = 200;B=100;
	 #10 start  = 0; 
 end
 

always #5 clock=~clock;  //10ns clock

sort_2_values u1 (clock,reset,start,A,B,data_out,push);

endmodule