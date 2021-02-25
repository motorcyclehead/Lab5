`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:49:06 02/25/2021 
// Design Name: 
// Module Name:    GCD 
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
module GCD(x_i, y_i, go_i, x_ld, x_sel, y_ld, y_sel, x_neq_y, x_lt_y, d_o, CLK);

localparam
	state_1 = 4'b0000,
	state_2 = 4'b0001,
	state_3 = 4'b0010,
	state_4 = 4'b0011,
	state_5 = 4'b0100,
	state_6 = 4'b0101,
	state_7 = 4'b0110;

input [3:0] x_i, y_i;
input x_neq_y, x_lt_y;

output [3:0] d_o;
output x_ld, y_ld, x_sel, y_sel;

reg [3:0] x, y;
reg [3:0] state = state_1;

wire x_ld, y_ld, x_sel, y_sel;

always @(posedge CLK)

	case (state)
		state_1 : begin
			if(go_i) begin
				state = state_2;
			end
		end
		
		state_2 : begin
			x_ld = 1;
			x_sel = 0;
			y_ld = 1;
			y_sel = 0;
			state = state_3;
		end
		
		state_3 : begin
			if(x_neq_y)
				state = state_4;
			else
				state = state_7;
		end
		
		state_4 : begin
			if(x_lt_y)
				state = state_5;
			else
				state = state_6;
		end
		
		state_5 : begin
			y_ld = 1;
			y_sel = 1;
		end
		
		state_6 : begin
			x_ld = 1;
			x_sel = 1;
		end
		
		state_7 : begin
			d_o = x;
		end

	endcase
endmodule
