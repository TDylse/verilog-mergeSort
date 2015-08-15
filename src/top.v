/*top.v
Author: Tristan Gibson

This module performs a merge Sort on a list of 32 unsigned integers.
Inputs: clock,reset,start.  Start goes high for once clock cycles
Output: done.  Indicates the Register File has been written with all values.  Goes high for once clock cycle

*/
module top(clock,reset,start,done);

//Parameters for DW FIFO
parameter width = 8;
parameter depth = 4;
parameter ae_level = 1;
parameter af_level = 1;
parameter err_mode = 0;
parameter rst_mode = 0;

//Constant input signal for DW FIFO
wire inst_diag_n;
assign inst_diag_n = 1'b1;


input clock,reset,start;
output done;

wire WE;
wire [4:0]  writeAddress;
wire [7:0]  WriteBus;
wire done;


wire [7:0] ReadBus0,ReadBus1,ReadBus2,ReadBus3,ReadBus4,ReadBus5,ReadBus6,ReadBus7,ReadBus8,ReadBus9,ReadBus10,ReadBus11,ReadBus12,ReadBus13,
           ReadBus14,ReadBus15,ReadBus16,ReadBus17,ReadBus18,ReadBus19,ReadBus20,ReadBus21,ReadBus22,ReadBus23,ReadBus24,ReadBus25,ReadBus26,ReadBus27,ReadBus28,ReadBus29,
		   ReadBus30,ReadBus31;
		   

		   
wire [7:0] FIFO1_1_datain,FIFO1_2_datain,FIFO1_3_datain,FIFO1_4_datain,FIFO1_5_datain,FIFO1_6_datain,FIFO1_7_datain,FIFO1_8_datain,FIFO1_9_datain,
           FIFO1_10_datain,FIFO1_11_datain,FIFO1_12_datain,FIFO1_13_datain,FIFO1_14_datain,FIFO1_15_datain,FIFO1_16_datain,
           FIFO2_1_datain,FIFO2_2_datain,FIFO2_3_datain,FIFO2_4_datain,FIFO2_5_datain,FIFO2_6_datain,FIFO2_7_datain,FIFO2_8_datain,
           FIFO3_1_datain,FIFO3_2_datain,FIFO3_3_datain,FIFO3_4_datain,
           FIFO4_1_datain,FIFO4_2_datain;
 
		   
wire [7:0] FIFO1_1_out,FIFO1_2_out,FIFO1_3_out,FIFO1_4_out,FIFO1_5_out,FIFO1_6_out,FIFO1_7_out,FIFO1_8_out,FIFO1_9_out,
           FIFO1_10_out,FIFO1_11_out,FIFO1_12_out,FIFO1_13_out,FIFO1_14_out,FIFO1_15_out,FIFO1_16_out,
    	   FIFO2_1_out,FIFO2_2_out,FIFO2_3_out,FIFO2_4_out,FIFO2_5_out,FIFO2_6_out,FIFO2_7_out,FIFO2_8_out,
           FIFO3_1_out,FIFO3_2_out,FIFO3_3_out,FIFO3_4_out,
		   FIFO4_1_out,FIFO4_2_out;

		   
assign done =  (writeAddress == 5'd31) ? 1'b1 : 1'b0;
   


//---------------------
//Register File
RegFile MemoryBank(clock, WE, writeAddress, WriteBus, ReadBus0,ReadBus1,ReadBus2,ReadBus3,ReadBus4,ReadBus5,ReadBus6,ReadBus7,ReadBus8,ReadBus9,
                 ReadBus10,ReadBus11,ReadBus12,ReadBus13,ReadBus14,ReadBus15,ReadBus16,ReadBus17,ReadBus18,ReadBus19,ReadBus20,ReadBus21,ReadBus22,ReadBus23,ReadBus24,
				 ReadBus25,ReadBus26,ReadBus27,ReadBus28,ReadBus29,ReadBus30,ReadBus31);
//---------------------	   
		   

//----------------------		   
// First Stage of sorting
sort_2_values u1( clock,reset,start,ReadBus0,  ReadBus1,  FIFO1_1_datain,  FIFO1_1_push);
sort_2_values u2( clock,reset,start,ReadBus2,  ReadBus3,  FIFO1_2_datain,  FIFO1_2_push);
sort_2_values u3( clock,reset,start,ReadBus4,  ReadBus5,  FIFO1_3_datain,  FIFO1_3_push);
sort_2_values u4( clock,reset,start,ReadBus6,  ReadBus7,  FIFO1_4_datain,  FIFO1_4_push);
sort_2_values u5( clock,reset,start,ReadBus8,  ReadBus9,  FIFO1_5_datain,  FIFO1_5_push);
sort_2_values u6( clock,reset,start,ReadBus10, ReadBus11, FIFO1_6_datain,  FIFO1_6_push);
sort_2_values u7( clock,reset,start,ReadBus12, ReadBus13, FIFO1_7_datain,  FIFO1_7_push);
sort_2_values u8( clock,reset,start,ReadBus14, ReadBus15, FIFO1_8_datain,  FIFO1_8_push);
sort_2_values u9( clock,reset,start,ReadBus16, ReadBus17, FIFO1_9_datain,  FIFO1_9_push);
sort_2_values u10(clock,reset,start,ReadBus18, ReadBus19, FIFO1_10_datain, FIFO1_10_push);
sort_2_values u11(clock,reset,start,ReadBus20, ReadBus21, FIFO1_11_datain, FIFO1_11_push);
sort_2_values u12(clock,reset,start,ReadBus22, ReadBus23, FIFO1_12_datain, FIFO1_12_push);
sort_2_values u13(clock,reset,start,ReadBus24, ReadBus25, FIFO1_13_datain, FIFO1_13_push);
sort_2_values u14(clock,reset,start,ReadBus26, ReadBus27, FIFO1_14_datain, FIFO1_14_push);
sort_2_values u15(clock,reset,start,ReadBus28, ReadBus29, FIFO1_15_datain, FIFO1_15_push);
sort_2_values u16(clock,reset,start,ReadBus30, ReadBus31, FIFO1_16_datain, FIFO1_16_push);


//--------------------
//FIFO MERGE

//-------------------
//Stage 2
fifoMerge  #(.depth(2))
   STAGE2_1 (.clock(clock), .reset(reset), 
		    .req_data1(FIFO1_1_pop), .dataIn1(FIFO1_1_out), .FIFO1_full(FIFO1_1_full), .FIFO1_empty(FIFO1_1_empty),
            .req_data2(FIFO1_2_pop), .dataIn2(FIFO1_2_out), .FIFO2_full(FIFO1_2_full), .FIFO2_empty(FIFO1_2_empty),
		    .dataOut(FIFO2_1_datain), .push_dataOut(FIFO2_1_push)); 
			
fifoMerge  #(.depth(2))
   STAGE2_2 (.clock(clock), .reset(reset), 
		    .req_data1(FIFO1_3_pop), .dataIn1(FIFO1_3_out), .FIFO1_full(FIFO1_3_full), .FIFO1_empty(FIFO1_3_empty),
            .req_data2(FIFO1_4_pop), .dataIn2(FIFO1_4_out), .FIFO2_full(FIFO1_4_full), .FIFO2_empty(FIFO1_4_empty),
		    .dataOut(FIFO2_2_datain), .push_dataOut(FIFO2_2_push));

fifoMerge  #(.depth(2))
   STAGE2_3 (.clock(clock), .reset(reset), 
		    .req_data1(FIFO1_5_pop), .dataIn1(FIFO1_5_out), .FIFO1_full(FIFO1_5_full), .FIFO1_empty(FIFO1_5_empty),
            .req_data2(FIFO1_6_pop), .dataIn2(FIFO1_6_out), .FIFO2_full(FIFO1_6_full), .FIFO2_empty(FIFO1_6_empty),
		    .dataOut(FIFO2_3_datain), .push_dataOut(FIFO2_3_push));
			
fifoMerge  #(.depth(2))
   STAGE2_4 (.clock(clock), .reset(reset), 
		    .req_data1(FIFO1_7_pop), .dataIn1(FIFO1_7_out), .FIFO1_full(FIFO1_7_full), .FIFO1_empty(FIFO1_7_empty),
            .req_data2(FIFO1_8_pop), .dataIn2(FIFO1_8_out), .FIFO2_full(FIFO1_8_full), .FIFO2_empty(FIFO1_8_empty),
		    .dataOut(FIFO2_4_datain), .push_dataOut(FIFO2_4_push));
			
fifoMerge  #(.depth(2))
   STAGE2_5 (.clock(clock), .reset(reset), 
		    .req_data1(FIFO1_9_pop),  .dataIn1(FIFO1_9_out),  .FIFO1_full(FIFO1_9_full),  .FIFO1_empty(FIFO1_9_empty),
            .req_data2(FIFO1_10_pop), .dataIn2(FIFO1_10_out), .FIFO2_full(FIFO1_10_full), .FIFO2_empty(FIFO1_10_empty),
		    .dataOut(FIFO2_5_datain), .push_dataOut(FIFO2_5_push));
			
fifoMerge  #(.depth(2))
   STAGE2_6 (.clock(clock), .reset(reset), 
		    .req_data1(FIFO1_11_pop), .dataIn1(FIFO1_11_out), .FIFO1_full(FIFO1_11_full), .FIFO1_empty(FIFO1_11_empty),
            .req_data2(FIFO1_12_pop), .dataIn2(FIFO1_12_out), .FIFO2_full(FIFO1_12_full), .FIFO2_empty(FIFO1_12_empty),
		    .dataOut(FIFO2_6_datain), .push_dataOut(FIFO2_6_push));

fifoMerge  #(.depth(2))
   STAGE2_7 (.clock(clock), .reset(reset), 
		    .req_data1(FIFO1_13_pop), .dataIn1(FIFO1_13_out), .FIFO1_full(FIFO1_13_full), .FIFO1_empty(FIFO1_13_empty),
            .req_data2(FIFO1_14_pop), .dataIn2(FIFO1_14_out), .FIFO2_full(FIFO1_14_full), .FIFO2_empty(FIFO1_14_empty),
		    .dataOut(FIFO2_7_datain), .push_dataOut(FIFO2_7_push));
			
fifoMerge  #(.depth(2))
   STAGE2_8 (.clock(clock), .reset(reset), 
		    .req_data1(FIFO1_15_pop), .dataIn1(FIFO1_15_out), .FIFO1_full(FIFO1_15_full), .FIFO1_empty(FIFO1_15_empty),
            .req_data2(FIFO1_16_pop), .dataIn2(FIFO1_16_out), .FIFO2_full(FIFO1_16_full), .FIFO2_empty(FIFO1_16_empty),
		    .dataOut(FIFO2_8_datain), .push_dataOut(FIFO2_8_push));

//-------------------
//Stage 3			
fifoMerge  #(.depth(4))
   STAGE3_1 (.clock(clock), .reset(reset), 
		    .req_data1(FIFO2_1_pop), .dataIn1(FIFO2_1_out), .FIFO1_full(FIFO2_1_full), .FIFO1_empty(FIFO2_1_empty),
            .req_data2(FIFO2_2_pop), .dataIn2(FIFO2_2_out), .FIFO2_full(FIFO2_2_full), .FIFO2_empty(FIFO2_2_empty),
		    .dataOut(FIFO3_1_datain), .push_dataOut(FIFO3_1_push));
			
fifoMerge  #(.depth(4))
   STAGE3_2 (.clock(clock), .reset(reset), 
		    .req_data1(FIFO2_3_pop), .dataIn1(FIFO2_3_out), .FIFO1_full(FIFO2_3_full), .FIFO1_empty(FIFO2_3_empty),
            .req_data2(FIFO2_4_pop), .dataIn2(FIFO2_4_out), .FIFO2_full(FIFO2_4_full), .FIFO2_empty(FIFO2_4_empty),
		    .dataOut(FIFO3_2_datain), .push_dataOut(FIFO3_2_push));

fifoMerge  #(.depth(4))
   STAGE3_3 (.clock(clock), .reset(reset), 
		    .req_data1(FIFO2_5_pop), .dataIn1(FIFO2_5_out), .FIFO1_full(FIFO2_5_full), .FIFO1_empty(FIFO2_5_empty),
            .req_data2(FIFO2_6_pop), .dataIn2(FIFO2_6_out), .FIFO2_full(FIFO2_6_full), .FIFO2_empty(FIFO2_6_empty),
		    .dataOut(FIFO3_3_datain), .push_dataOut(FIFO3_3_push));

fifoMerge  #(.depth(4))
   STAGE3_4 (.clock(clock), .reset(reset), 
		    .req_data1(FIFO2_7_pop), .dataIn1(FIFO2_7_out), .FIFO1_full(FIFO2_7_full), .FIFO1_empty(FIFO2_7_empty),
            .req_data2(FIFO2_8_pop), .dataIn2(FIFO2_8_out), .FIFO2_full(FIFO2_8_full), .FIFO2_empty(FIFO2_8_empty),
		    .dataOut(FIFO3_4_datain), .push_dataOut(FIFO3_4_push));
			

//-------------------
//Stage 4
fifoMerge  #(.depth(8))
   STAGE4_1 (.clock(clock), .reset(reset), 
		    .req_data1(FIFO3_1_pop), .dataIn1(FIFO3_1_out), .FIFO1_full(FIFO3_1_full), .FIFO1_empty(FIFO3_1_empty),
            .req_data2(FIFO3_2_pop), .dataIn2(FIFO3_2_out), .FIFO2_full(FIFO3_2_full), .FIFO2_empty(FIFO3_2_empty),
		    .dataOut(FIFO4_1_datain), .push_dataOut(FIFO4_1_push));
			
fifoMerge  #(.depth(8))
   STAGE4_2 (.clock(clock), .reset(reset), 
		    .req_data1(FIFO3_3_pop), .dataIn1(FIFO3_3_out), .FIFO1_full(FIFO3_3_full), .FIFO1_empty(FIFO3_3_empty),
            .req_data2(FIFO3_4_pop), .dataIn2(FIFO3_4_out), .FIFO2_full(FIFO3_4_full), .FIFO2_empty(FIFO3_4_empty),
		    .dataOut(FIFO4_2_datain), .push_dataOut(FIFO4_2_push));


//-------------------
//Stage 5 write to Register File			
fifoMerge_regFile #(.depth(16))
  STAGE5_1 (.clock(clock), .reset(reset), 
		    .req_data1(FIFO4_1_pop), .dataIn1(FIFO4_1_out), .FIFO1_full(FIFO4_1_full), .FIFO1_empty(FIFO4_1_empty),
            .req_data2(FIFO4_2_pop), .dataIn2(FIFO4_2_out), .FIFO2_full(FIFO4_2_full), .FIFO2_empty(FIFO4_2_empty),
		    .dataOut(WriteBus), .push_dataOut(WE), .count(writeAddress));			



//----------------------
//FIFOs
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_1 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_1_push),
        .pop_req_n(FIFO1_1_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_1_datain),   .empty(FIFO1_1_empty),
        .almost_empty(almost_empty_inst),   .half_full(half_full_inst),
        .almost_full(almost_full_inst),   .full(FIFO1_1_full),
        .error(error_inst),   .data_out(FIFO1_1_out) );
		
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_2 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_2_push),
        .pop_req_n(FIFO1_2_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_2_datain),   .empty(FIFO1_2_empty),
        .almost_empty(almost_empty_inst2),   .half_full(half_full_inst2),
        .almost_full(almost_full_inst2),   .full(FIFO1_2_full),
        .error(error_inst2),   .data_out(FIFO1_2_out) );
		
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_3 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_3_push),
        .pop_req_n(FIFO1_3_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_3_datain),   .empty(FIFO1_3_empty),
        .almost_empty(almost_empty_inst3),   .half_full(half_full_inst3),
        .almost_full(almost_full_inst3),   .full(FIFO1_3_full),
        .error(error_inst3),   .data_out(FIFO1_3_out) );
		
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_4 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_4_push),
        .pop_req_n(FIFO1_4_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_4_datain),   .empty(FIFO1_4_empty),
        .almost_empty(almost_empty_inst4),   .half_full(half_full_inst4),
        .almost_full(almost_full_inst4),   .full(FIFO1_4_full),
        .error(error_inst4),   .data_out(FIFO1_4_out) );
		
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_5 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_5_push),
        .pop_req_n(FIFO1_5_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_5_datain),   .empty(FIFO1_5_empty),
        .almost_empty(almost_empty_inst5),   .half_full(half_full_inst5),
        .almost_full(almost_full_inst5),   .full(FIFO1_5_full),
        .error(error_inst5),   .data_out(FIFO1_5_out) );
		
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_6 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_6_push),
        .pop_req_n(FIFO1_6_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_6_datain),   .empty(FIFO1_6_empty),
        .almost_empty(almost_empty_inst6),   .half_full(half_full_inst6),
        .almost_full(almost_full_inst6),   .full(FIFO1_6_full),
        .error(error_inst6),   .data_out(FIFO1_6_out) );
		
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_7 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_7_push),
        .pop_req_n(FIFO1_7_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_7_datain),   .empty(FIFO1_7_empty),
        .almost_empty(almost_empty_inst7),   .half_full(half_full_inst7),
        .almost_full(almost_full_inst7),   .full(FIFO1_7_full),
        .error(error_inst7),   .data_out(FIFO1_7_out) );
		
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_8 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_8_push),
        .pop_req_n(FIFO1_8_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_8_datain),   .empty(FIFO1_8_empty),
        .almost_empty(almost_empty_inst8),   .half_full(half_full_inst8),
        .almost_full(almost_full_inst8),   .full(FIFO1_8_full),
        .error(error_inst8),   .data_out(FIFO1_8_out) );
		
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_9 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_9_push),
        .pop_req_n(FIFO1_9_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_9_datain),   .empty(FIFO1_9_empty),
        .almost_empty(almost_empty_inst9),   .half_full(half_full_inst9),
        .almost_full(almost_full_inst9),   .full(FIFO1_9_full),
        .error(error_inst9),   .data_out(FIFO1_9_out) );

DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_10 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_10_push),
        .pop_req_n(FIFO1_10_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_10_datain),   .empty(FIFO1_10_empty),
        .almost_empty(almost_empty_inst10),   .half_full(half_full_inst10),
        .almost_full(almost_full_inst10),   .full(FIFO1_10_full),
        .error(error_inst10),   .data_out(FIFO1_10_out) );
		
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_11 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_11_push),
        .pop_req_n(FIFO1_11_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_11_datain),   .empty(FIFO1_11_empty),
        .almost_empty(almost_empty_inst11),   .half_full(half_full_inst11),
        .almost_full(almost_full_inst11),   .full(FIFO1_11_full),
        .error(error_inst11),   .data_out(FIFO1_11_out) );
		
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_12 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_12_push),
        .pop_req_n(FIFO1_12_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_12_datain),   .empty(FIFO1_12_empty),
        .almost_empty(almost_empty_inst12),   .half_full(half_full_inst12),
        .almost_full(almost_full_inst12),   .full(FIFO1_12_full),
        .error(error_inst12),   .data_out(FIFO1_12_out) );
		
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_13 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_13_push),
        .pop_req_n(FIFO1_13_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_13_datain),   .empty(FIFO1_13_empty),
        .almost_empty(almost_empty_inst13),   .half_full(half_full_inst13),
        .almost_full(almost_full_inst13),   .full(FIFO1_13_full),
        .error(error_inst13),   .data_out(FIFO1_13_out) );
		
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_14 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_14_push),
        .pop_req_n(FIFO1_14_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_14_datain),   .empty(FIFO1_14_empty),
        .almost_empty(almost_empty_inst14),   .half_full(half_full_inst14),
        .almost_full(almost_full_inst14),   .full(FIFO1_14_full),
        .error(error_inst14),   .data_out(FIFO1_14_out) );
		
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_15 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_15_push),
        .pop_req_n(FIFO1_15_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_15_datain),   .empty(FIFO1_15_empty),
        .almost_empty(almost_empty_inst15),   .half_full(half_full_inst15),
        .almost_full(almost_full_inst15),   .full(FIFO1_15_full),
        .error(error_inst15),   .data_out(FIFO1_15_out) );
		
DW_fifo_s1_sf #(width,  2,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO1_16 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO1_16_push),
        .pop_req_n(FIFO1_16_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO1_16_datain),   .empty(FIFO1_16_empty),
        .almost_empty(almost_empty_inst16),   .half_full(half_full_inst16),
        .almost_full(almost_full_inst16),   .full(FIFO1_16_full),
        .error(error_inst16),   .data_out(FIFO1_16_out) );
		
		
DW_fifo_s1_sf #(width,  4,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO2_1 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO2_1_push),
        .pop_req_n(FIFO2_1_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO2_1_datain),   .empty(FIFO2_1_empty),
        .almost_empty(almost_empty_inst17),   .half_full(half_full_inst17),
        .almost_full(almost_full_inst17),   .full(FIFO2_1_full),
        .error(error_inst17),   .data_out(FIFO2_1_out) );	

DW_fifo_s1_sf #(width,  4,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO2_2 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO2_2_push),
        .pop_req_n(FIFO2_2_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO2_2_datain),   .empty(FIFO2_2_empty),
        .almost_empty(almost_empty_inst18),   .half_full(half_full_inst18),
        .almost_full(almost_full_inst18),   .full(FIFO2_2_full),
        .error(error_inst18),   .data_out(FIFO2_2_out) );

DW_fifo_s1_sf #(width,  4,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO2_3 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO2_3_push),
        .pop_req_n(FIFO2_3_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO2_3_datain),   .empty(FIFO2_3_empty),
        .almost_empty(almost_empty_inst19),   .half_full(half_full_inst19),
        .almost_full(almost_full_inst19),   .full(FIFO2_3_full),
        .error(error_inst19),   .data_out(FIFO2_3_out) );

DW_fifo_s1_sf #(width,  4,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO2_4 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO2_4_push),
        .pop_req_n(FIFO2_4_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO2_4_datain),   .empty(FIFO2_4_empty),
        .almost_empty(almost_empty_inst119),   .half_full(half_full_inst119),
        .almost_full(almost_full_inst119),   .full(FIFO2_4_full),
        .error(error_inst119),   .data_out(FIFO2_4_out) );

DW_fifo_s1_sf #(width,  4,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO2_5 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO2_5_push),
        .pop_req_n(FIFO2_5_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO2_5_datain),   .empty(FIFO2_5_empty),
        .almost_empty(almost_empty_inst20),   .half_full(half_full_inst20),
        .almost_full(almost_full_inst20),   .full(FIFO2_5_full),
        .error(error_inst20),   .data_out(FIFO2_5_out) );

DW_fifo_s1_sf #(width,  4,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO2_6 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO2_6_push),
        .pop_req_n(FIFO2_6_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO2_6_datain),   .empty(FIFO2_6_empty),
        .almost_empty(almost_empty_inst21),   .half_full(half_full_inst21),
        .almost_full(almost_full_inst21),   .full(FIFO2_6_full),
        .error(error_inst21),   .data_out(FIFO2_6_out) );

DW_fifo_s1_sf #(width,  4,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO2_7 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO2_7_push),
        .pop_req_n(FIFO2_7_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO2_7_datain),   .empty(FIFO2_7_empty),
        .almost_empty(almost_empty_inst22),   .half_full(half_full_inst22),
        .almost_full(almost_full_inst22),   .full(FIFO2_7_full),
        .error(error_inst22),   .data_out(FIFO2_7_out) );

DW_fifo_s1_sf #(width,  4,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO2_8 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO2_8_push),
        .pop_req_n(FIFO2_8_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO2_8_datain),   .empty(FIFO2_8_empty),
        .almost_empty(almost_empty_inst23),   .half_full(half_full_inst23),
        .almost_full(almost_full_inst23),   .full(FIFO2_8_full),
        .error(error_inst23),   .data_out(FIFO2_8_out) );		
		
		
//------------------------------------------------------------------------
DW_fifo_s1_sf #(width,  8,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO3_1 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO3_1_push),
        .pop_req_n(FIFO3_1_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO3_1_datain),   .empty(FIFO3_1_empty),
        .almost_empty(almost_empty_inst24),   .half_full(half_full_inst24),
        .almost_full(almost_full_inst24),   .full(FIFO3_1_full),
        .error(error_inst24),   .data_out(FIFO3_1_out) );	

DW_fifo_s1_sf #(width,  8,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO3_2 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO3_2_push),
        .pop_req_n(FIFO3_2_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO3_2_datain),   .empty(FIFO3_2_empty),
        .almost_empty(almost_empty_inst25),   .half_full(half_full_inst25),
        .almost_full(almost_full_inst25),   .full(FIFO3_2_full),
        .error(error_inst25),   .data_out(FIFO3_2_out) );

DW_fifo_s1_sf #(width,  8,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO3_3 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO3_3_push),
        .pop_req_n(FIFO3_3_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO3_3_datain),   .empty(FIFO3_3_empty),
        .almost_empty(almost_empty_inst26),   .half_full(half_full_inst26),
        .almost_full(almost_full_inst26),   .full(FIFO3_3_full),
        .error(error_inst26),   .data_out(FIFO3_3_out) );

DW_fifo_s1_sf #(width,  8,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO3_4 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO3_4_push),
        .pop_req_n(FIFO3_4_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO3_4_datain),   .empty(FIFO3_4_empty),
        .almost_empty(almost_empty_inst27),   .half_full(half_full_inst27),
        .almost_full(almost_full_inst27),   .full(FIFO3_4_full),
        .error(error_inst27),   .data_out(FIFO3_4_out) );		
//------------------------------------------------------------------------	

DW_fifo_s1_sf #(width,  16,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO4_1 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO4_1_push),
        .pop_req_n(FIFO4_1_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO4_1_datain),   .empty(FIFO4_1_empty),
        .almost_empty(almost_empty_inst28),   .half_full(half_full_inst28),
        .almost_full(almost_full_inst28),   .full(FIFO4_1_full),
        .error(error_inst28),   .data_out(FIFO4_1_out) );	

DW_fifo_s1_sf #(width,  16,  ae_level,  af_level,  err_mode,  rst_mode)
    FIFO4_2 (.clk(clock),   .rst_n(reset),   .push_req_n(FIFO4_2_push),
        .pop_req_n(FIFO4_2_pop),   .diag_n(inst_diag_n),
        .data_in(FIFO4_2_datain),   .empty(FIFO4_2_empty),
        .almost_empty(almost_empty_inst29),   .half_full(half_full_inst29),
        .almost_full(almost_full_inst29),   .full(FIFO4_2_full),
        .error(error_inst29),   .data_out(FIFO4_2_out) );


	
		


endmodule



