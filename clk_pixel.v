`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:05:00 01/03/2016 
// Design Name: 
// Module Name:    clk_pixel 
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
module clk_pixel(
    input wire clk,
    output reg clk_pixel
    );
    reg cnt;

    initial begin
        cnt <= 0;
        clk_pixel <= 0;
    end

    always @(posedge clk)
    begin
        if (cnt == 1)
            begin
                cnt <= 0;
                clk_pixel <= ~clk_pixel;
            end
        else
            cnt <= 1;
    end

endmodule
