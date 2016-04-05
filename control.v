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
	 output reg ENcinic,
	 output reg lock,
	 output reg selmuxdt,
	 output reg [2:0]selmuxctr
    );
reg [9:0]contador;
reg crini;
reg form;
reg Phoraref;
reg Pfecharef;
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
		Phoraref<=0;
		Pfecharef<=0;
		ENcinic<=0;
		lock<=0;
		selmuxdt<=0;
		selmuxctr<=0;
	end
	else
	begin
	if (contador==155)
		begin
		if (cronoini!=crini)
		begin
			ENcinic<=1;
			selmuxctr<=1;
			crini<=cronoini;
			contador<=contador+1'b1;
		end
		else if (Phora!=Phoraref||Pfecha!=Pfecharef)
		begin
		selmuxctr<=1;
		if (Phora==1||Pfecha==1)
			begin
				ENcinic<=1;
				lock<=1;
			end
		else if (Phora==0 && Pfecha==0)
			begin
				ENcinic<=1;
				lock<=0;
			end
			Phoraref<=Phora;
			Pfecharef<=Pfecha;
			contador<=contador+1'b1;
		end
		else if (format!=form)
		begin 
			ENcinic<=1;
			selmuxctr<=1;
			form<=format;
			contador<=contador+1'b1;
		end
		else contador<=186;
		end
		
		else if (contador==157)
		begin
		ENcinic<=0;
		contador<=contador+1'b1;
		end
		
		else if (contador==196)
		begin
		ENedatos<=1;
		selmuxctr<=2;
		selmuxdt<=0;
		contador<=contador+1'b1;
		end
		
		else if(contador==198)
		begin
		ENedatos<=0;
		contador<=contador+1'b1;
		end
		
		else if(contador==626)
		begin
			if (Phora==1)
				begin
				ENchora<=1;
				selmuxdt<=1;
				contador<=contador+1'b1;
				end
			else if (Pfecha==1)
				begin
				ENcfecha<=1;
				selmuxdt<=1;
				contador<=contador+1'b1;
				end
			else if (Pcrono==1)
				begin
				ENccrono<=1;
				selmuxdt<=1;
				contador<=contador+1'b1;
				end
			else contador<=155;
			
		end
		else if (contador==628)
		begin
		if (Phora==0)
			begin
			ENchora<=0;
			ENghora<=1;
			selmuxctr<=3;
			contador<=contador+1'b1;
			end
		else if(Pfecha==0)
			begin
			ENcfecha<=0;
			ENgfecha<=1;
			selmuxctr<=4;
			contador<=contador+1'b1;
			end
		else if(Pcrono==0)
			begin
			ENccrono<=0;
			ENgcrono<=1;
			selmuxctr<=5;
			contador<=contador+1'b1;
			end
		
		end
		
		else if (contador==630)
		begin
			ENghora<=0;
			ENgfecha<=0;
			ENgcrono<=0;
			contador<=contador+1'b1;
		end
		else if (contador==788)contador<=55;
		
		else contador<=contador+1'b1;
	end
	
	end

endmodule
