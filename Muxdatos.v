`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:19:18 04/05/2016 
// Design Name: 
// Module Name:    Muxdatos 
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
module Muxdatos(
    input [23:0] datos11,
    input [23:0] datos12,
	 input [23:0] datos13,
	 input [23:0] datos21,
    input [23:0] datos22,
	 input [23:0] datos23,
	 input ap1,
	 input ap2,
	 input seleccion,
    output reg [7:0] hora,
	 output reg [7:0] min,
    output reg [7:0] seg,
    output reg [7:0] dia,
	 output reg [7:0] mes,
	 output reg [7:0] year,
	 output reg [7:0] horacr,
	 output reg [7:0] mincr,
	 output reg [7:0] segcr,
	 output reg ampm
    );
always @*
	begin
	case(seleccion)
		1'b0:begin
			hora<=datos11[23:16];
			min<=datos11[15:8];
			seg<=datos11[7:0];
			dia<=datos12[23:16];
			mes<=datos12[15:8];
			year<=datos12[7:0];
			horacr<=datos13[23:16];
			mincr<=datos13[15:8];
			segcr<=datos13[7:0];
			ampm<=ap1;
			end
		1'b1:begin
			hora<=datos21[23:16];
			min<=datos21[15:8];
			seg<=datos21[7:0];
			dia<=datos22[23:16];
			mes<=datos22[15:8];
			year<=datos22[7:0];
			horacr<=datos23[23:16];
			mincr<=datos23[15:8];
			segcr<=datos23[7:0];
			ampm<=ap2;
			end
		default:begin
			hora<=datos11[23:16];
			min<=datos11[15:8];
			seg<=datos11[7:0];
			dia<=datos12[23:16];
			mes<=datos12[15:8];
			year<=datos12[7:0];
			horacr<=datos13[23:16];
			mincr<=datos13[15:8];
			segcr<=datos13[7:0];
			ampm<=ap1;
			end
	endcase 
	end

endmodule
