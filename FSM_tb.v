`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:25:36 02/28/2021
// Design Name:   FSM
// Module Name:   C:/Users/subhi/Documents/CDA4203 - System Design/Lab5/FSM_tb.v
// Project Name:  Lab5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FSM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FSM_tb;

	// Inputs
	reg [3:0] x_i;
	reg [3:0] y_i;
	reg go_i;
	reg reset;
	reg CLK;

	// Outputs
	wire [3:0] d_o;

	// Instantiate the Unit Under Test (UUT)
	FSM uut (
		.x_i(x_i), 
		.y_i(y_i), 
		.go_i(go_i), 
		.reset(reset), 
		.d_o(d_o), 
		.CLK(CLK)
	);

	// Clock Generator
	always begin
		CLK = ~CLK;
		#5;
	end

	initial begin
		// Initialize Inputs
		x_i = 0;
		y_i = 0;
		go_i = 0;
		reset = 0;
		CLK = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		x_i = 15;
		y_i = 3;
		#20;
		go_i = 1;
		#20;
		reset = 1;
		#20;
		reset = 0;
		x_i = 10;
		y_i = 5;
		#20;

	end
      
endmodule

