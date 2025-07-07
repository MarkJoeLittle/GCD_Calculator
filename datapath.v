`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:26:58 03/06/2014 
// Design Name: 
// Module Name:    datapath 
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

module debouncer(clk, in, out, reset);

input clk, in, reset;
output reg out;

parameter delay = 5;
reg [19:0] timer = 0;
reg temp;

always @ (posedge clk or negedge reset) begin
	if(reset == 0) begin
		out=0;
		timer=19'b0;	
		temp=0;
	end
	else if(in != temp) begin
		temp=in;
		timer=0;
	end
	else if(timer == delay) begin
		out=temp;
		timer=0;
	end
	else begin
		timer = timer + 1;
	end
end
endmodule


////////////////////////////////////////////////////////////////////////////////////

module mux(ina, inb, sel, out);

	input [3:0]ina;
	input [3:0]inb;
	input sel;
	
	output [3:0]out;
	
//	if (sel == 1)
//		assign out = ina;
//	else 
//		assign out = inb;
		
		assign ou = (sel == 0) ? ina : inb;
	
//	always @ (sel or ina or inb)
//	
//	case (sel)
//	
//	1'b0: 
//	1'b1: 
//	
//	endcase

endmodule

///////////////////////////////////////////////////////////////////////////////////

module a_neq_b(ina, inb, out);

	//inputs
	input [3:0]ina;
	input [3:0]inb;
	
	// outputs
	output out;
	
	assign out = (ina != inb) ? 1 : 0;

endmodule
 

///////////////////////////////////////////////////////////////////////////////////

module a_lt_b(ina, inb, out);
	
	//inputs
	input [3:0]ina;
	input [3:0]inb;
	
	//outputs
	output out;
	
	assign out = (ina < inb) ? 1 : 0;

endmodule

////////////////////////////////////////////////////////////////////////////////////

module subtractor(ina, inb, out);

	input [3:0]ina;
	input [3:0]inb;

	output [3:0]out;

	assign out = ina - inb;
	
endmodule

////////////////////////////////////////////////////////////////////////////////////////
			
module register(ina, ld, clk, reset, out);

	input [3:0]ina;
	input ld;
	input reset;
	input clk;
	
	output reg [3:0] out;
	
	always @ (negedge clk or negedge reset ) begin
		if (reset == 0) begin
			out <= 4'b0000;		
		end
		else if (ld == 1) begin
			out <= ina;
		end
	end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////

module datapath(xin, yin, x_sel, y_sel, x_ld, y_ld, d_ld, x_neq_y, x_lt_y, out, clk, reset);

input x_sel, y_sel, x_ld, y_ld, d_ld, reset, clk;
input [3:0]xin;
input [3:0]yin;
output x_neq_y;
output x_lt_y;
output [3:0]out;

wire [3:0] w1;
wire [3:0] w2; 
wire [3:0] w3; 
wire [3:0] w4; 
wire [3:0] w5;
wire [3:0] w6;

	mux mux_x(xin, w2, x_sel, w1);
	
	mux mux_y(yin, w3, y_sel, w4);
	
	register reg_x(w1, x_ld, clk, reset, w5);
	
	register reg_y(w4, y_ld, clk, reset, w6);
	
	a_neq_b x_neq_y1(w5, w6, x_neq_y);
		
	a_lt_b x_lt_y1(w5, w6, x_lt_y);
	
	subtractor x_sub_y(w5, w6, w2);
		
	subtractor y_sub_x(w6, w5, w3);
		
	register reg_d(w5, d_ld, clk, reset, out);
		
endmodule 

