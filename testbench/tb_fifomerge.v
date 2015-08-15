module tb_fifomerge;
/*setup multiple stages of FIFOs with different depth 
FIFO1 + FIFO2 > FIFO3  depth = 4->8
FIFO4 + FIFO5 > FIFO6  depth = 4->8
FIFO3 + FIFO6 > FIFO7  depth = 8->16

FIFO8 + FIFO9 > FIFO10 depth = 2->4

Verify FIFO7 dataIn path has the complete sorted chain

*/
parameter width = 8;
parameter depth = 4;
parameter ae_level = 1;
parameter af_level = 1;
parameter err_mode = 0;
parameter rst_mode = 0;

reg clock;
reg reset;

  

reg FIFO1_push,FIFO2_push,FIFO4_push,FIFO5_push,FIFO8_push,FIFO9_push;//FIFO6_push;//,FIFO7_push;
reg [7:0] FIFO1_datain,FIFO2_datain, FIFO4_datain,FIFO5_datain,FIFO8_datain,FIFO9_datain;
wire [7:0] FIFO3_datain,FIFO6_datain,FIFO7_datain,FIFO10_datain;
reg FIFO7_pop,FIFO10_pop;

wire [7:0] FIFO1_out,FIFO2_out,FIFO3_out,FIFO4_out,FIFO5_out,FIFO6_out,FIFO7_out,FIFO8_out,FIFO9_out,FIFO10_out;

reg inst_diag_n;

wire [4:0] count1, count2;
wire [8:0] count3;
wire [2:0] count4;


initial // setup vectors
  begin
    // req_data1 = 1;req_data1 = 1;
   
end

 

initial //following block executed only once

begin
     clock = 0;
     reset = 0;
	 
	 inst_diag_n = 1;        //needs to be high
	 #10 reset = 1;
	 	 
	 FIFO1_datain = 8'd2; FIFO2_datain = 8'd1;   FIFO4_datain = 8'd42;   	 FIFO5_datain = 8'd41;
	 FIFO8_datain = 8'd4; FIFO9_datain = 8'd67;
	 
	 FIFO1_push = 0; FIFO2_push = 0;   //start filling up
	 FIFO4_push = 0; FIFO5_push = 0;
	 FIFO8_push = 0; FIFO9_push = 0;
	 
	 
	 #5
     #10 FIFO1_datain = 8'd4;    FIFO2_datain = 8'd3;    FIFO4_datain = 8'd44;  FIFO5_datain = 8'd43;    FIFO8_datain = 8'd8; FIFO9_datain = 8'd72;
	     
	 #10 FIFO1_datain = 8'd6;    FIFO2_datain = 8'd5;    FIFO4_datain = 8'd46;  FIFO5_datain = 8'd45;    
	     FIFO8_push = 1; FIFO9_push = 1;
     #10 FIFO1_datain = 8'd10;    FIFO2_datain = 8'd7;   FIFO4_datain = 8'd48;  FIFO5_datain = 8'd47;
	     
	 //#10 req_data1 = 0;req_data2 = 0;
	 #5 FIFO1_push = 1; FIFO2_push = 1;   FIFO4_push = 1; FIFO5_push = 1;
	 #50 FIFO7_pop = 1'b0;
	 FIFO10_pop = 1'b0;
end

always #5 clock=~clock;  //10ns clock


   


DW_fifo_s1_sf #(width,  depth,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_push),
        .pop_req_n(FIFO1_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_datain),   .empty(FIFO1_empty),
        .almost_empty(almost_empty_inst),   .half_full(half_full_inst),
        .almost_full(almost_full_inst),   .full(FIFO1_full),
        .error(error_inst),   .data_out(FIFO1_out) );
		
DW_fifo_s1_sf #(width,  depth,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO2 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO2_push),
        .pop_req_n(FIFO2_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO2_datain),   .empty(FIFO2_empty),
        .almost_empty(almost_empty_inst2),   .half_full(half_full_inst2),
        .almost_full(almost_full_inst2),   .full(FIFO2_full),
        .error(error_inst),   .data_out(FIFO2_out) );

DW_fifo_s1_sf #(width,  8,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO3 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO3_push),
        .pop_req_n(FIFO3_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO3_datain),   .empty(FIFO3_empty),
        .almost_empty(almost_empty_inst3),   .half_full(half_full_inst3),
        .almost_full(almost_full_inst3),   .full(FIFO3_full),
        .error(error_inst),   .data_out(FIFO3_out) );

DW_fifo_s1_sf #(width,  depth,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO4 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO4_push),
        .pop_req_n(FIFO4_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO4_datain),   .empty(FIFO4_empty),
        .almost_empty(almost_empty_inst4),   .half_full(half_full_inst4),
        .almost_full(almost_full_inst4),   .full(FIFO4_full),
        .error(error_inst4),   .data_out(FIFO4_out) );


DW_fifo_s1_sf #(width,  depth,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO5 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO5_push),
        .pop_req_n(FIFO5_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO5_datain),   .empty(FIFO5_empty),
        .almost_empty(almost_empty_inst5),   .half_full(half_full_inst5),
        .almost_full(almost_full_inst5),   .full(FIFO5_full),
        .error(error_inst5),   .data_out(FIFO5_out) );


DW_fifo_s1_sf #(width,  8,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO6 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO6_push),
        .pop_req_n(FIFO6_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO6_datain),   .empty(FIFO6_empty),
        .almost_empty(almost_empty_inst6),   .half_full(half_full_inst6),
        .almost_full(almost_full_inst6),   .full(FIFO6_full),
        .error(error_inst6),   .data_out(FIFO6_out) );		
		
DW_fifo_s1_sf #(width,  16,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO7 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO7_push),
        .pop_req_n(FIFO7_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO7_datain),   .empty(FIFO7_empty),
        .almost_empty(almost_empty_inst7),   .half_full(half_full_inst7),
        .almost_full(almost_full_inst7),   .full(FIFO7_full),
        .error(error_inst7),   .data_out(FIFO7_out) );

DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO8 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO8_push),
        .pop_req_n(FIFO8_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO8_datain),   .empty(FIFO8_empty),
        .almost_empty(almost_empty_inst8),   .half_full(half_full_inst8),
        .almost_full(almost_full_inst8),   .full(FIFO8_full),
        .error(error_inst8),   .data_out(FIFO8_out) );
		
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO9 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO9_push),
        .pop_req_n(FIFO9_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO9_datain),   .empty(FIFO9_empty),
        .almost_empty(almost_empty_inst9),   .half_full(half_full_inst9),
        .almost_full(almost_full_inst9),   .full(FIFO9_full),
        .error(error_inst9),   .data_out(FIFO9_out) );
		
DW_fifo_s1_sf #(width,  4,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO10 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO10_push),
        .pop_req_n(FIFO10_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO10_datain),   .empty(FIFO10_empty),
        .almost_empty(almost_empty_inst10),   .half_full(half_full_inst10),
        .almost_full(almost_full_inst10),   .full(FIFO10_full),
        .error(error_inst10),   .data_out(FIFO10_out) );

//fifoMerge u1 (clock, reset, req_data1, FIFO1_full, FIFO1_out, 
                               //req_data2, FIFO2_full, FIFO2_out, dataOut);
//FIFO1 FIFO2 > FIFO3							   
fifoMerge  #(.depth(4))
           u1 (.clock(clock), .reset(reset), .req_data1(FIFO1_pop), .FIFO1_full(FIFO1_full),
                           .FIFO1_empty(FIFO1_empty), .dataIn1(FIFO1_out), .req_data2(FIFO2_pop), .FIFO2_full(FIFO2_full), .FIFO2_empty(FIFO2_empty),
						   .dataIn2(FIFO2_out), .dataOut(FIFO3_datain), .push_dataOut(FIFO3_push));

//FIFO4 FIFO5 > FIFO6						   
fifoMerge  #(.depth(4))
           u2 (.clock(clock), .reset(reset), .req_data1(FIFO4_pop), .FIFO1_full(FIFO4_full),
                           .FIFO1_empty(FIFO4_empty), .dataIn1(FIFO4_out), .req_data2(FIFO5_pop), .FIFO2_full(FIFO5_full), .FIFO2_empty(FIFO5_empty),
						   .dataIn2(FIFO5_out), .dataOut(FIFO6_datain), .push_dataOut(FIFO6_push));
//FIFO3 FIFO6 > FIFO7							   
fifoMerge  #(.depth(8))
          u3 (.clock(clock), .reset(reset), .req_data1(FIFO3_pop), .FIFO1_full(FIFO3_full),
                           .FIFO1_empty(FIFO3_empty), .dataIn1(FIFO3_out), .req_data2(FIFO6_pop), .FIFO2_full(FIFO6_full), .FIFO2_empty(FIFO6_empty),
						   .dataIn2(FIFO6_out), .dataOut(FIFO7_datain), .push_dataOut(FIFO7_push));
						   
//FIFO8 FIFO9 > FIFO10						   
fifoMerge  #(.depth(2))
          u4 (.clock(clock), .reset(reset), .req_data1(FIFO8_pop), .FIFO1_full(FIFO8_full),
                           .FIFO1_empty(FIFO8_empty), .dataIn1(FIFO8_out), .req_data2(FIFO9_pop), .FIFO2_full(FIFO9_full), .FIFO2_empty(FIFO9_empty),
						   .dataIn2(FIFO9_out), .dataOut(FIFO10_datain), .push_dataOut(FIFO10_push));





endmodule /* test_fixture */






