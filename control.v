`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:37:24 03/25/2016 
// Design Name: 
// Module Name:    control 
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
module control(
    input clock,
    input reset,
	 input Phora,
	 input Pfecha,
	 input Pcrono,
	 input cronoini,
	 input format,
    output reg ENchora,
    output reg ENcfecha,
    output reg ENccrono,
    output reg ENghora,
    output reg ENgfecha,
    output reg ENgcrono,
    output reg ENedatos,
	 output reg ENcformat,
	 output reg ENcinic,
	 output reg ENlock
    );
reg [9:0]contador;
reg crini;
reg form;
always @(posedge clock)
	begin
	if (reset)
	begin
		ENchora<=0;
		ENcfecha<=0;
		ENccrono<=0;
		ENghora<=0;
		ENgfecha<=0;
		ENgcrono<=0;
		ENedatos<=0;
		contador<=0;
		crini<=0;
		form<=0;
	end
	else
	begin
	if (contador==32)
		begin
		if (cronoini!=crini)ENcinic<=1;
		if (Phora==1||Pfecha==1)ENlock<=1;
		if (format!=form)ENcinic<=1;
		contador<=contador+1;
		end
		
		else if (contador==62)
		begin
		ENedatos<=1;
		contador<=contador+1;
		end
		
		else if(contador==65)
		begin
		ENedatos<=0;
		contador<=contador+1;
		end
		
		else if(contador==382)
		begin
			if (Phora==1)ENchora<=1;
			else if (Pfecha==1)ENcfecha<=1;
			else if (Pcrono==1)ENccrono<=1;
			else contador<=contador+1;
			
		end
		else if (contador==383)
		begin
		if (ENchora==1)
			begin
			ENchora<=0;
			ENghora<=1;
			contador<=contador+1;
			end
		else if(ENcfecha==1)
			begin
			ENcfecha<=0;
			ENgfecha<=1;
			contador<=contador+1;
			end
		else if(ENccrono==1)
			begin
			ENccrono<=0;
			ENgcrono<=1;
			contador<=contador+1;
			end
		
		else contador<=0;
		
		end
		
		else if (contador==387)
		begin
			ENghora<=0;
			ENgfecha<=0;
			ENgcrono<=0;
			crini<=cronoini;
			form<=format;
			contador<=contador+1;
		end
		else if (contador==489)contador<=32;
		
		else contador<=contador+1;
	end
	
	end

endmodule
