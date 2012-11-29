////////////////////////////////////////////////////////////////////////////////
// ECE 485/585: Microprocessor System Design
// Portland State University - Fall 2012 
// Final Project: 
// 
// File:		PROJECT.v (Top-level wrapper module for project)
// Authors: 
// Description:
//
//
//
////////////////////////////////////////////////////////////////////////////////
module PROJECT(input clk, 
	       input 		 clear, 
	       input [3:0] 	 n, 
	       input [31:0] 	 add_in,
	       input done,
	       output wire [25:0] add_out
	       
    );
	
	
	// signals from file to caches
	
	wire [31:0]i_add, d_add;
   assign i_add = add_in;
   assign d_add = add_in;
	// signals between caches and next-level cache
	wire [511:0] l2_i_data, l2_d_data;
	wire [31:0] l2_i_add, l2_d_add;
	
	// signals to/from stats
	wire [31:0] i_hit;
	wire [31:0] d_hit;
	wire [31:0] i_miss;
	wire [31:0]	d_miss;
	wire [31:0] i_reads;
	wire [31:0] d_reads;
	wire [31:0] d_writes;

	// do file input and stream to caches

	INS_CACHE Instruction (
    //.clk(clk), 
    .n(n), 
    .add_in(add_in), 
    .add_out(add_out),	
    .hit(i_hit), 
    .miss(i_miss),
    .reads(i_reads)
    );
	
STATS stats(
	// INPUTS
    .print(done),			// mux to determine reads/writes
   .ins_reads(i_reads),
	.ins_hit(i_hit),
	.ins_miss(i_miss),
	
	.data_reads(0),
	.data_writes(0),
	.data_hit(0),
	.data_miss(0)
    );


endmodule
