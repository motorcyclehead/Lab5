`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:06:11 02/25/2021 
// Design Name: 
// Module Name:    FSM 
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
module FSM(x_i, y_i, go_i, reset, d_o, CLK);
 
input [3:0] x_i, y_i; 
input reset, go_i, CLK;

output [3:0] d_o;

wire ctrl_x_reg, ctrl_y_reg, ctrl_d_reg, ctrl_x_in, ctrl_y_in, neq_ctrl, lt_ctrl;
wire [3:0] subt1_x_in, subt2_y_in, x_reg_d_reg, x_o, y_o, x_in_x_reg, y_in_y_reg;

	Controller controller(
		.CLK(CLK),
		.x_i(x_i),
		.y_i(y_i),
		.x_neq_y(neq_ctrl),
		.x_lt_y(lt_ctrl),
		.x_ld(ctrl_x_reg),
		.y_ld(ctrl_t_reg),
		.x_sel(ctrl_x_in),
		.y_sel(ctrl_y_in),
		.d_o(ctrl_d_reg),
		.go_i(go_i)
		);
	
	dff x_reg(
		.CLK(CLK),
		.d(x_in_x_reg),
		.enable(ctrl_x_in),
		.reset(reset),
		.q(x_o)
		);
	
	dff y_reg(
		.CLK(CLK),
		.d(y_in_y_reg),
		.enable(ctrl_y_in),
		.reset(reset),
		.q(y_o)
	);
	
	dff d_reg(
		.CLK(CLK),
		.d(x_o),
		.enable(ctrl_d_reg),
		.reset(reset),
		.q(d_o)
	);
	
	mux_21_beh x_in(
		.mux_in0(x_i),
		.mux_in1(subt1_x_in),
		.sel(ctrl_x_in),
		.mux_out(x_in_x_reg)
	);
	
	mux_21_beh y_in(
		.mux_in0(y_i),
		.mux_in1(subt2_y_in),
		.sel(ctrl_y_in),
		.mux_out(y_in_y_reg)
	);
	
	NEQ neq(
		.x(x_o),
		.y(y_o),
		.x_neq_y(neq_ctrl)
	);
	
	less_than lt(
		.x(x_o),
		.y(y_o),
		.x_lt_y(lt_ctrl)
	);
	
	Subt subt1(
		.x(x_o),
		.y(y_o),
		.d(subt1_x_in)
	);
	
	Subt subt2(
		.x(y_o),
		.y(y_o),
		.d(subt2_y_in)
	);


endmodule


module dff(CLK, d, q, enable, reset);

	input CLK;
	input [3:0] d;
	input enable, reset;
	output [3:0] q;

	reg [3:0] q;
	initial begin q=0; end

	always @(posedge CLK) begin

		if(reset && !enable) begin q = 0; end
		
		else if (enable && !reset) begin q = d; end
		
		else q = q;
		
	end

endmodule

module NEQ(x, y, x_neq_y);

	input [3:0] x, y;
	
	output x_neq_y;
	
	assign x_neq_y = (x != y) ? 1'b1 : 1'b0;
	
endmodule

module less_than (x, y, x_lt_y);

	input [3:0] x, y;
	
	output x_lt_y;
	
	assign x_lt_y = (x < y) ? 1'b1 : 1'b0;
	
endmodule

module mux_21_beh(mux_in0, mux_in1, sel, mux_out);

input sel;
input [3:0] mux_in0, mux_in1;
output reg [3:0] mux_out;

always @(sel)

	if(sel == 1'b0) begin
		mux_out = mux_in0;
	end
	else if(sel == 1'b1) begin
		mux_out = mux_in1;
	end

endmodule

module Subt(x, y, d);

	input [3:0] x, y;
	
	output [3:0] d;
	
	assign d = x - y;
	
endmodule

