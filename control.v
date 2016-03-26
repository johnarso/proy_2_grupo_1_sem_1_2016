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
    output reg ENchora,
    output reg ENcfecha,
    output reg ENccrono,
    output reg ENghora,
    output reg ENgfecha,
    output reg ENgcrono,
    output reg ENedatos
    );
reg [9:0]contador;

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
		
	end
	else
	begin
		if (contador==0)
		begin
		ENedatos<=1;
		contador<=contador+1;
		end
		else if(contador==3)
		begin
		ENedatos<=0;
		contador<=contador+1;
		end
		else if(contador==288)
		begin
			if (Phora==1)ENchora<=1;
			else if (Pfecha==1)ENcfecha<=1;
			else if (Pcrono==1)ENccrono<=1;
			else contador<=contador+1;
			
		end
		else if (contador==289)
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
		
		else if (contador==293)
		begin
			ENghora<=0;
			ENgfecha<=0;
			ENgcrono<=0;
			contador<=contador+1;
		end
		else if (contador==395)contador<=0;
		
		else contador<=contador+1;
	end
	
	end

endmodule
