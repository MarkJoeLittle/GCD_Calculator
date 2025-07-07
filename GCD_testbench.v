`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:34:22 03/06/2014
// Design Name:   topmodule
// Module Name:   E:/Desktop/School Docs/5/Semester2/CDA 4203L-002/Lab5/finalGCD/GCD_testbench.v
// Project Name:  finalGCD
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: topmodule
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module GCD_testbench;

	// Inputs
	reg CLK;
	reg [3:0] X;
	reg [3:0] Y;
	reg START;
	reg RESET;

	// Outputs
	wire [3:0] GCD_OUT;
	wire DONE;

	// Instantiate the Unit Under Test (UUT)
	topmodule uut (
		.CLK(CLK), 
		.X(X), 
		.Y(Y), 
		.START(START), 
		.RESET(RESET), 
		.GCD_OUT(GCD_OUT), 
		.DONE(DONE)
	);

	always
   begin
      CLK <= 0;
      #25;
      CLK <= 1;
      #25;
   end

	initial begin
		// Initialize Inputs
		CLK = 1;
		X = 0;
		Y = 0;
		START = 0;
		RESET = 0;

		// Wait 100 ns for global RESET to finish
		#100;
        
		  RESET = 1;
		  #100;
		  START = 1;
		  X = 4;
		  Y = 6;
		  
		  
		// Add stimulus here

	end
      
endmodule

