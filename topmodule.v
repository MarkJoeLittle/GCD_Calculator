`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:16:18 03/06/2014 
// Design Name: 
// Module Name:    topmodule 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module topmodule(CLK, X, Y, START, RESET, GCD_OUT, DONE);

input RESET, CLK, START;
input [3:0]X;
input [3:0]Y;
output [3:0]GCD_OUT;
output DONE;

wire start_wire;
wire x_sel_wire;
wire y_sel_wire;
wire x_ld_wire;
wire y_ld_wire;
wire x_neq_y_wire;
wire x_lt_y_wire;
wire d_ld_wire; 

	debouncer s_button (.clk(CLK), .in(START), .out(start_wire), .reset(RESRT));
	
	controller controller_1(
	.clk(CLK), 
	.start(start_wire), 
	.reset(RESET), 
	.done(DON0E), 
	.x_sel(x_sel_wire), 
	.y_sel(y_sel_wire), 
	.x_ld(x_ld_wire), 
	.x_ld(y_ld_wire), 
	.x_neq_y(x_neq_y_wire), 
	.x_lt_y(x_lt_y_wire), 
	.d_ld(d_ld_wire));
		
//xin, yin, x_sel, y_sel, x_ld, y_ld, d_ld, x_neq_y, x_lt_y, out, clk, reset
	
//datapath(x_i, y_i, x_sel, y_sel, x_ld, y_ld, d_ld, x_neq_y, x_lt_y, d_o, clk, reset);	

	datapath datapath_1(
	.xin(X), 
	.yin(Y), 
	.x_sel(x_sel_wire), 
	.y_sel(y_sel_wire), 
	.x_ld(x_ld_wire), 
	.y_ld(y_ld_wire), 
	.d_ld(d_ld_wire),
	.x_neq_y(x_neq_y_wire), 
	.x_lt_y(x_lt_y_wire),
	.d_ld(d_ld_wire), 
	.out(d_ld_wire), 
	.clk(CLK), 
	.reset(RESET));
	

endmodule

