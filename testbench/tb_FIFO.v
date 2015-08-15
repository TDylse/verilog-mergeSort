module tb_FIFO;
/*Verify FIFO by filling it up and popping data off and examine full/empty flag*/

parameter width = 8;
  parameter depth = 4;
  parameter ae_level = 1;
  parameter af_level = 1;
  parameter err_mode = 0;
  parameter rst_mode = 0;

  reg inst_clk;
  reg inst_rst_n;
  reg inst_push_req_n;
  reg inst_pop_req_n;
  reg inst_diag_n;
  reg [width-1 : 0] inst_data_in;
  wire empty_inst;
  wire almost_empty_inst;
  wire half_full_inst;
  wire almost_full_inst;
  wire full_inst;
  wire error_inst;
  wire [width-1 : 0] data_out_inst;
  
 initial //following block executed only once

begin
     inst_clk = 0;
     inst_rst_n = 0;
	 inst_pop_req_n = 0;
	 inst_diag_n = 1;        //needs to be high
	 #10 inst_rst_n = 1;

	 
	 inst_data_in = 8'd5;
	 inst_push_req_n = 0;   //start filling up
	 #10 inst_data_in = 8'd2;
	 #10 inst_data_in = 8'd3;
	 #10 inst_data_in = 8'd4;
	 #10 inst_data_in = 8'd5;
	
	 //inst_pop_req_n = 0;
	 #30 inst_push_req_n = 1'b0;
     	 
end
  
  
  

  // Instance of DW_fifo_s1_sf
  DW_fifo_s1_sf #(width,  depth,  ae_level,  af_level,  err_mode,  rst_mode)
    U1 (.clk(inst_clk),   .rst_n(inst_rst_n),   .push_req_n(inst_push_req_n),
        .pop_req_n(inst_pop_req_n),   .diag_n(inst_diag_n),
        .data_in(inst_data_in),   .empty(empty_inst),
        .almost_empty(almost_empty_inst),   .half_full(half_full_inst),
        .almost_full(almost_full_inst),   .full(full_inst),
        .error(error_inst),   .data_out(data_out_inst) );
		
			



always #5 inst_clk=~inst_clk;  //10ns clock

endmodule /* test_fixture */