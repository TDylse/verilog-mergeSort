/*  fifoMerge.v
Author: Tristan Gibson
This module merges the contents of two FIFOs into another
FIFO that double the depth of the previous FIFOS.  We wait until both Input FIFOS are FULL before
starting the comparison.  

The parameter "depth" is passed
into this module that represents the depth of the input FIFOs.

The parameter depth2 is the depth of the output FIFO and is calculated based on depth.

The controls and status for the FIFOs (push, pop, full, empty) are ACTIVE LOW

The "//synopsys template" is used to enable the parameterize in sythsys
*/


module fifoMerge  (clock, reset, req_data1, FIFO1_full, FIFO1_empty, dataIn1, 
                               req_data2, FIFO2_full, FIFO2_empty, dataIn2, dataOut,push_dataOut);


// synopsys template
parameter width = 8;
parameter depth = 4;
parameter depth2 = (depth+depth);

input clock;
input reset;
input [width-1 : 0] dataIn1, dataIn2;                        //Input FIFOs
input FIFO1_full,FIFO2_full,FIFO1_empty,FIFO2_empty;         //FIFO status flags
  
  
  
output [width-1 : 0] dataOut;
output req_data1,req_data2;                      //pop controls for input FIFOs
output push_dataOut;                             //push control for output FIFO

  
reg [width-1 : 0] dataOut;
reg req_data1,req_data2;
reg [depth:0] count;
  
parameter [1:0]    //FSM states  
  S0 = 2'b00,    
  S1 = 2'b01;    
  
reg [2:0] current_state, next_state;
reg push_dataOut;
  
 /*Simple state machine and counter to control datapath */
    
always@(posedge clock or negedge reset)
  if (!reset) 
     begin
	   current_state <= S0;
	   count <=0;
	 end
  else 
    begin
	  current_state <= next_state;
	  count <= count + (!req_data1 | !req_data2);
	end
     

  

always@(*)
 begin
      
   case (current_state)
       
	  
     S0: begin                                     //state waiting for input FIFOs to fill up                       
          dataOut = 8'b00000000;
		  push_dataOut = 1'b1;
		  req_data1 = 1; req_data2 = 1;
          if (FIFO1_full & FIFO2_full)
		    next_state <= S1;                      
	      else 
		    next_state <= S0;
			
		  end
     S1: begin                                    //once FIFOs are full, start using counter to increment through both FIFOs
	       if (count >=  (depth2-1))
             next_state <= S0;
           else			 
		     next_state <= S1;
			 
			 
           if (!FIFO1_empty & !FIFO2_empty)     //simple case: take the lower value of each FIFO, and pop next value for that FIFO
	         begin
	          if (dataIn1 < dataIn2)
	            begin
				 dataOut = dataIn1;
				 push_dataOut = 1'b0;
				 req_data1 = 0;
				 req_data2 = 1;
				 
		        end
			  else
			    begin  
			     dataOut = dataIn2;
			     push_dataOut = 1'b0;
			     req_data1 = 1;
			     req_data2 = 0;
			     end
			 end	 
			else                             //handle the cases when one FIFO is empty
                begin
                  if (FIFO1_empty)           
				    begin
					  dataOut = dataIn2;
					  push_dataOut = 1'b0;
			          req_data1 = 1;
			          req_data2 = 0;
			        end
				  else
				     begin
	                   dataOut = dataIn1;
	                   push_dataOut = 1'b0;
				       req_data1 = 0;
				       req_data2 = 1;
		             end
		        end
		 end
     default:
			begin
			//prevent latches
			push_dataOut = 1'b1; 	 
			dataOut = 8'b00000000;
			req_data1 = 1;
			req_data2 = 1;
			next_state <= S0;
			end
			  
	  endcase
end
  
  
 endmodule
		
		
