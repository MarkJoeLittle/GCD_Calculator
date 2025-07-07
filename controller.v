`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:17:05 03/06/2014 
// Design Name: 
// Module Name:    controller 
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
module controller(clk, start, reset, done, x_sel, y_sel, x_ld, y_ld, x_neq_y, x_lt_y, d_ld);

input clk, start, reset, x_neq_y, x_lt_y;
output reg done;
output reg x_sel;
output reg y_sel;
output reg x_ld;
output reg y_ld;
output reg d_ld;

   parameter state0 = 4'b0000;
   parameter state1 = 4'b0001;
   parameter state2 = 4'b0010;
   parameter state3 = 4'b0011;
   parameter state4 = 4'b0100;
   parameter state5 = 4'b0101;
   parameter state6 = 4'b0110;
   parameter state7 = 4'b0111;
   parameter state8 = 4'b1000;
   parameter state9 = 4'b1001;
   parameter state10 = 4'b1010;
   parameter state11 = 4'b1011;
   parameter state12 = 4'b1100;

reg [3:0] state;

   always@(posedge clk)
	begin
      if (reset == 0)
		begin
         x_sel <= 0;
			y_sel <= 0;
			x_ld <= 0;
			y_ld <= 0;
			d_ld <= 0;
			done <= 0;
			state <= state0;
      end
      else if (start == 1 && reset == 1)
		begin
			case (state) 
			state0:
			begin
				if (1)
				begin
               state <= state1;
				end
				done <= 0;
         end
			state1:
			begin
            if (start == 0)
				begin
               state <= state2;
				end
            else if (start == 1)
				begin
               state <= state3;
				end
            else
				begin
               state <= state1;
				end
				done <= 0;				
         end
			state2:
			begin
            state <= state1;
				done <= 0;
         end
			state3:
			begin
            x_sel <= 0;
				x_ld <= 1;
				done <= 0;
				state <= state4;
         end
			state4:
			begin
            y_sel <= 0;
				y_ld <= 1;
				done <= 0;
				state <= state5;
         end
			state5:
			begin
            if (x_neq_y)
				begin
               state <= state6;
				end
            else if (!x_neq_y)
				begin
               state <= state11;
				end
            else
				begin
               state <= state5;
				end
				done <= 0;
         end
			state6:
			begin
            if (x_lt_y == 1)
				begin		
               state <= state7;
				end
            else if (x_lt_y == 0)
				begin				
               state <= state8;
				end
            else
				begin
               state <= state6;
				end
				done <= 0;
         end
			state7:
			begin
            y_sel <= 1;
				y_ld <= 1;
				done <= 0;
				state <= state9;
         end
			state8:
			begin
            x_sel <= 1;
				x_ld <= 1;
				done <= 0;
				state <= state9;
         end
			state9:
			begin
				y_sel <= 0;
				y_ld <= 0;
				x_sel <= 0;
				x_ld <= 0;
				done <= 0;
				state <= state10;
         end
			state10:
			begin
				done <= 0;
				state <= state5;
         end
			state11:
			begin
            d_ld <= 1;
				done <= 0;
				state <= state12;
         end
			state12:
			begin
				done <= 1;
         end
		endcase
end
end
endmodule