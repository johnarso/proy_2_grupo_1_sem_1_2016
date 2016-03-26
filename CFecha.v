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
module CFecha(
    input [7:0] dia,
    input [7:0] mes,
    input [7:0] year,
	 input EN,
    input BTup,
    input BTdown,
    input BTl,
    input BTr,
	 input clk,
	 input reset,
    output reg [7:0] diaC,
    output reg [7:0] mesC,
    output reg [7:0] yearC
   
    );
	 reg [1:0]contador;
	 reg [2:0]step;
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
		diaC<=0;
		mesC<=0;
		yearC<=0;
		
		
		
	end
	else if (EN)
	begin
		
	if (step==0)
	begin
		diaC<=dia;
		mesC<=mes;
		yearC<=year;
		step<=step+1;
	end
		
	else if (step==1)
		begin
		if (BTr>BTrref)
		begin
			if (contador==2)
			contador<=0;
			else contador<=contador+1;
			BTrref<=BTr;
			
		end
		
		
		if (BTl>BTlref)
		begin
			if (contador==0)
			contador<=2;
			else contador<=contador-1;
			BTlref<=BTl;
			
		end
		
		step<=step+1;
		end
		
		else if (step==2)
			begin
			case (contador)
			2'b00:varin<=diaC;
			2'b01:varin<=mesC;
			2'b10:varin<=yearC;
			default varin<=diaC;
			endcase
			step<=step+1;
			end
		else if (step==3)
		begin
		if (BTdown==BTdownref && BTup==BTupref)
		varout<=varin;
		
		if (BTup>BTupref)
		begin
			if (varin==31 && contador==0)varout<=0;
			else if(varin==12 && contador==1)varout<=0;
			else if (varin==99)varout<=0;
			else if (varin==29 && mesC==2 && contador==0) varout<=0;
			else if (mesC==4 || mesC==6 || mesC==9 || mesC==11)
				begin
				if (varin==30 && contador==0)varout<=0;
				end
			else varout<=varin+1;
			BTupref<=BTup;
		end
		
		
		if (BTdown>BTdownref)
		begin
			if (varin==0 && contador==0)
			begin
				if(mesC==4 || mesC==6 || mesC==9 || mesC==11)varout<=30;
				else if(mesC==2)varout<=29;
				else varout<=31;
			end
			else if (varin==0 && contador==1)
			varout<=12;
			else if (varin==0 && contador==2)
			varout<=99;
			else varout<=varin-1;
			BTdownref<=BTdown;
			
		end
		step<=step+1;
		end
		
		else if (step==4)
		begin
		case (contador)
			2'b00:diaC<=varout;
			2'b01: mesC<=varout;
			2'b10: yearC<=varout;
			default diaC<=varout;
		endcase
		step<=1;
		end
		
		if (BTup<BTupref)
			BTupref<=BTup;
		if (BTdown<BTdownref)
			BTdownref<=BTdown;
		if (BTr<BTrref)
			BTrref<=BTr;
		if (BTl<BTlref)
			BTlref<=BTl;
		
		
	end
	else 
	begin
	step<=0;
	contador<=0;
	end
end
endmodule
