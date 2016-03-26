`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:38:53 03/22/2016 
// Design Name: 
// Module Name:    CHora 
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
module CHora(
    input [7:0] H,
    input [7:0] M,
    input [7:0] S,
	 input ampm,
	 input format,
	 input EN,
    input BTup,
    input BTdown,
    input BTl,
    input BTr,
	 input clk,
	 input reset,
    output reg [7:0] HC,
    output reg [7:0] MC,
    output reg [7:0] SC,
	 output reg AmPm
   
    );
	 reg [1:0]contador;
	 reg [2:0]step;
	 reg Format;
	 reg BTupref;
	 reg BTdownref;
	 reg BTlref;
	 reg BTrref;
	 reg [7:0] varin;
	 reg [7:0] varout;
	 
always @(posedge clk)
begin
	if (reset)
	begin
		contador<=0;
		step<=0;
		BTupref<=0;
		BTdownref<=0;
	   BTlref<=0;
	   BTrref<=0;
		varout<=0;
		HC<=0;
		MC<=0;
		SC<=0;
		AmPm<=0;
		Format<=0;
		
	end
	else if (EN)
	begin

	if (step==0)
		begin
		HC<=H;
		MC<=M;
		SC<=S;
		AmPm<=ampm;
		Format<=format;
		step<=step+1;
		end

	else if (step==1)//paso 1
		begin
		if (BTr>BTrref)
		begin
			if (contador==2)
			contador<=0;
			else contador<=contador+1;
			BTrref<=BTr;
		end
		else if (BTr<BTrref)
			BTrref<=BTr;
		
		if (BTl>BTlref)
		begin
			if (contador==0)
			contador<=2;
			else contador<=contador-1;
			BTlref<=BTl;
		end
		
		step<=step+1;
		end
			
		else if (step==2)//paso 2
			begin
			case (contador)
			2'b00: varin<=HC;
			2'b01: varin<=MC;
			2'b10: varin<=SC;
			default varin<=HC;
			endcase
			
			step<=step+1;
			end
		
		else if (step==3)
		begin
		if (BTdown==BTdownref && BTup==BTupref)
		varout<=varin;
		
		
		if (BTup>BTupref)
		begin
			if (varin==59)
			varout<=0;
			else if (varin==12 && contador==0 && Format==1)
			begin
				varout<=0;
				AmPm<=~AmPm;
			end
			else if (varin<=24 && contador==0)
			varout<=0;
			else varout<=varin+1;
			BTupref<=BTup;
		end
		
		if (BTdown>BTdownref)
		begin
			if (varin==0 && contador==0 && Format==1)
			varout<=12;
			else if (varin==0 && contador==0)
			varout<=24;
			else if (varin==0)
			varout<=59;
			else varout<=varin-1;
			BTdownref<=BTdown;
		end
		
		step<=step+1;
		end
		
		else if (step==4)
		begin
		case (contador)
			2'b00: HC<=varout;
			2'b01: MC<=varout;
			2'b10: SC<=varout;
			default HC<=varout;
		endcase
		step<=1;
		end
		
		if (BTup<BTupref)
			BTupref<=BTup;
		if (BTdown<BTdownref)
			BTdownref<=BTdown;
		if (BTl<BTlref)
			BTlref<=BTl;
		if (BTr<BTrref)
			BTrref<=BTr;
		
	end
	else 
	begin
	step<=0;
	contador<=0;
	end
	

end
endmodule
