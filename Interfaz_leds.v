`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:45 04/16/2016 
// Design Name: 
// Module Name:    Interfaz_leds 
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
module Interfaz_leds(
	input reset, clk,
	output reg [5:0] leds
    );
	 
	 always @(posedge reset, posedge clk)
	 begin
		if (reset) leds=6'h00;
		else leds=6'hff;
	 end
	 
	 
endmodule
