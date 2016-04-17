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
	 output reg AmPm,
    output reg [2:0]contador
    );
	 
	 reg [2:0]step;
	 reg Format;
	 reg BTupref;
	 reg BTdownref;
	 reg BTlref;
	 reg BTrref;
	 reg [3:0] varin;
	 reg [3:0] varout;
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
		varin<=0;
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
		step<=step+1'b1;
		end

	else if (step==1)//paso 1
		begin
		if (BTr>BTrref)
		begin
			if (contador==5)
			contador<=0;
			else contador<=contador+1'b1;
			BTrref<=BTr;
		end
		else if (BTr<BTrref)
			BTrref<=BTr;
		
		if (BTl>BTlref)
		begin
			if (contador==0)
			contador<=5;
			else contador<=contador-1'b1;
			BTlref<=BTl;
		end
		
		step<=step+1'b1;
		end
			
		else if (step==2)//paso 2
			begin
			case (contador)
			3'b000: varin<=HC[7:4];
			3'b001: varin<=HC[3:0];
			3'b010: varin<=MC[7:4];
			3'b011: varin<=MC[3:0];
			3'b100: varin<=SC[7:4];
			3'b101: varin<=SC[3:0];
			default varin<=HC[7:4];
			endcase
			
			step<=step+1'b1;
			end
		
		else if (step==3)
		begin
		
		if (Format!=format)
		begin
			if (format==0)
				begin
				if (AmPm==1)
				begin
				case (HC)
				8'h01:HC<=8'h13;
				8'h02:HC<=8'h14;
				8'h03:HC<=8'h15;
				8'h04:HC<=8'h16;
				8'h05:HC<=8'h17;
				8'h06:HC<=8'h18;
				8'h07:HC<=8'h19;
				8'h08:HC<=8'h20;
				8'h09:HC<=8'h21;
				8'h10:HC<=8'h22;
				8'h11:HC<=8'h23;
				default HC<=HC;
				endcase 
				AmPm<=0;
				end
				else if (AmPm==0&&HC==8'h12)HC<=8'h00;
			end
			if (format==1)
				begin
				case (HC)
				8'h00:begin
						HC<=8'h12;
						AmPm<=0;
						end
				8'h13:begin
						HC<=8'h01;
						AmPm<=1;
						end
				8'h14:begin
						HC<=8'h02;
						AmPm<=1;
						end
				8'h15:begin
						HC<=8'h03;
						AmPm<=1;
						end
				8'h16:begin
						HC<=8'h04;
						AmPm<=1;
						end
				8'h17:begin
						HC<=8'h05;
						AmPm<=1;
						end
				8'h18:begin
						HC<=8'h06;
						AmPm<=1;
						end
				8'h19:begin
						HC<=8'h07;
						AmPm<=1;
						end
				8'h20:begin
						HC<=8'h08;
						AmPm<=1;
						end
				8'h21:begin
						HC<=8'h09;
						AmPm<=1;
						end
				8'h22:begin
						HC<=8'h10;
						AmPm<=1;
						end
				8'h23:begin
						HC<=8'h11;
						AmPm<=1;
						end
				default HC<=HC;
				endcase 
				end
				Format<=format;
		end
		
		if (BTdown==BTdownref && BTup==BTupref)
		varout<=varin;
		
		if (BTup>BTupref)
		begin
			if (contador==1&&HC[7:4]==1&&Format==1&&varin==1)varout<=0;
			else if (contador==1&&HC[7:4]==2&&Format==0&&varin==3)varout<=0;
			else if ((contador==1||contador==3||contador==5)&&varin==9)varout<=0;
			else if (contador==0 && Format==1 && varin==1)
				begin
				varout<=0;
				AmPm<=~AmPm;
				end
			else if (varin==2 && contador==0)varout<=0;
			else if ((contador==2||contador==4)&&varin==5)varout<=0;
			else if (contador==0 && Format==1 && varin==0)
				begin
				varout<=1;
				HC[3:0]<=0;
				end
			else if (contador==0 && Format==0 && varin==1)
				begin
				varout<=2;
				HC[3:0]<=0;
				end
			
			else varout<=varin+1'b1;
			BTupref<=BTup;
		end
		
		if (BTdown>BTdownref)
		begin
			if (varin==0)
				begin
				if(contador==0 && Format==1)
					begin
					varout<=1;
					HC[3:0]<=0;
					AmPm<=~AmPm;
					end
				else if (contador==0&&Format==0)
					begin
					varout<=2;
					HC[3:0]<=0;
					end
				else if (contador==1&&HC[7:4]==2&&Format==0)varout<=3;
				else if (contador==1&&HC[7:4]==1&&Format==1)varout<=1;
				else if (contador==1||contador==3||contador==5)	varout<=9;
				else if (contador==2||contador==4)varout<=5;
				end
			else varout<=varin-1'b1;
			BTdownref<=BTdown;
		end
		
		step<=step+1'b1;
		end
		
		else if (step==4)
		begin
		case (contador)
			3'b000: HC[7:4]<=varout;
			3'b001: HC[3:0]<=varout;
			3'b010: MC[7:4]<=varout;
			3'b011: MC[3:0]<=varout;
			3'b100: SC[7:4]<=varout;
			3'b101: SC[3:0]<=varout;
			default HC[7:4]<=varout;
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
