/*  sort_2_values.v
Author: Tristan Gibson
This module takes in two 8-bit unsigned value on one clock edge and sequentially
outputs them in ascending order on the next two pos clock edges along with a ACTIVE LOW
control signal for a FIFO push

The control signal "start" initiates the comparison
*/

module sort_2_values(clock,reset,start,A,B,data_out,push);

input clock,reset,start;
input  [7:0] A,B;

output [7:0] data_out;

output push;
reg [7:0] data_out;
reg push;



parameter [2:0]          //FSM states
  S0 = 3'b000,    
  S1 = 3'b001,
  S2 = 3'b010,  
  S3 = 3'b011,
  S4 = 3'b100;
  
reg [2:0] current_state, next_state;  
reg [1:0] count;
wire  LT_LE;

assign LT_LE = A < B;

/*State Machine Reg */
always@(posedge clock or negedge reset)
  if (!reset) current_state <= S0;
  else current_state <= next_state;
  


always@(*)
 begin
  
  casex(current_state)
  
   S0: begin                                   //"reset" state waiting for start
        push = 1;
		data_out   =  8'b00000000;
        if (start == 1)
		  begin
		    if (LT_LE)
		       next_state = S1;
			else
			   next_state = S2;
		  end	   
	    else
		    next_state = S0;
	   end
	   
   S1: begin                                 //when A<B
        push       = 0;
		data_out   = A; 
        next_state = S3;
       end		
   S2: begin                                 //when B<A
        push       = 0;
        data_out   = B;
        next_state = S4;
	   end	
		
   S3: begin                                //output B after A, and then we're done 
        push       = 0;
        data_out   = B;
        next_state = S0;
        end
   S4: begin                                //output A after B, and then we're done
        push       = 0;
        data_out   = A;
        next_state = S0;
       end
 
   default: begin 
             push       = 1;	            //prevent latches
             next_state = S0;
			 data_out   =  8'b00000000;
		    end
	endcase		
 end			
   


endmodule
