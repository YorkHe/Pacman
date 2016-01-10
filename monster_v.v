`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:02:47 01/10/2016
// Design Name:   monster
// Module Name:   H:/System_Group/Pacman/monster_v.v
// Project Name:  Pacman
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: monster
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module monster_v;

	// Inputs
	reg clk;
	reg [2:0] index;
	reg [8:0] p_x;
	reg [8:0] p_y;

	// Outputs
	wire [8:0] m_x;
	wire [8:0] m_y;

	// Instantiate the Unit Under Test (UUT)
	monster uut (
		.clk(clk), 
		.index(index), 
		.p_x(p_x), 
		.p_y(p_y), 
		.m_x(m_x), 
		.m_y(m_y)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		index = 0;
		p_x = 0;
		p_y = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
        
        forever #20 clk<=~clk;

	end
      
endmodule

