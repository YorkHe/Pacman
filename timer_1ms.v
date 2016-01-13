`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:09:35 01/03/2016 
// Design Name: 
// Module Name:    timer_1ms 
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
module timer1ms(
    input wire clk,
    output reg clk_1ms
    );

    reg [19:0] cnt;

    initial begin
        cnt[19:0] <= 0;
        clk_1ms <= 0;
    end

    always @(posedge clk) begin
        if (cnt[19:0] == 1000000) begin
            cnt <= 0;
            clk_1ms <= ~clk_1ms;
        end else
            cnt <= cnt + 1'b1;
    end

endmodule

module timer25mhz(
    input wire clk,
    output reg clk_25mhz
);

reg cnt;

initial begin
    clk_25mhz <= 0;
    cnt <= 0;
end

always @(posedge clk) begin
    if (cnt == 1) begin
        cnt <= 0;
        clk_25mhz <= ~clk_25mhz;
    end else
        cnt <= cnt + 1'b1;
end

endmodule
