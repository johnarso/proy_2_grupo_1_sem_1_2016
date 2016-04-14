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
	 input fin,
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
	 output reg ENcompa,
	 output reg lock,
	 output reg [1:0]selmuxdt,
	 output reg [2:0]selmuxctr
	
    );
reg [11:0]contador;
reg crini;
reg crini2;
reg form;
reg finref;
reg [20:0]contEdatos;
always @(posedge clock)
	begin
	if (reset)
	begin
		finref<=0;
		ENchora<=0;
		ENcfecha<=0;
		ENccrono<=0;
		ENghora<=0;
		ENgfecha<=0;
		ENgcrono<=0;
		ENedatos<=0;
		ENcompa<=0;
		contador<=0;
		crini<=0;
		crini2<=0;
		form<=0;
		ENcinic<=0;
		lock<=0;
		selmuxdt<=0;
		selmuxctr<=0;
		contEdatos<=0;
	end
	else
	begin
	if (contador==170)// se escriben ceros en todos los datos del RTC
		begin
		ENghora<=1;
		contador<=contador+1'b1;
		end
	else if (contador==172)
		begin
		ENghora<=0;
		contador<=contador+1'b1;
		end
	else if (contador==420)
		begin
		ENgfecha<=1;
		contador<=contador+1'b1;
		end
	else if (contador==422)
		begin
		ENgfecha<=0;
		contador<=contador+1'b1;
		end
	else if (contador==670)
		begin
		ENgcrono<=1;
		contador<=contador+1'b1;
		end
	else if (contador==672)
		begin
		ENgcrono<=0;
		contador<=contador+1'b1;
		end
	
	else if (contador==920) // se extraen los datos del RTC
		begin
		if (contEdatos==0)
			begin 
			ENedatos<=1;
			selmuxctr<=2;
			if (ENccrono==0)selmuxdt<=0;
			contador<=contador+1'b1;
			end
		else contador<=1500;
		contEdatos<=contEdatos+1'b1;
		end
		
		else if(contador==922)
		begin
		ENedatos<=0;
		contador<=contador+1'b1;
		end
	
	else if (contador==1500) //se ve si existe algun cambio en el formato, cronometro o bloqueo
		begin
		ENcompa<=1;
		if (cronoini!=crini||fin>finref)
		begin
			ENcinic<=1;
			selmuxctr<=1;
			crini<=cronoini;
			contador<=contador+1'b1;
		end
		else if ((Phora==1||Pfecha==1)&&lock==0)
		begin
		selmuxctr<=1;
		ENcinic<=1;
		lock<=1;
		contador<=contador+1'b1;
		end
		else if (format!=form)
		begin 
			ENcinic<=1;
			selmuxctr<=1;
			form<=format;
			contador<=contador+1'b1;
		end
		else contador<=1540;
		finref<=fin;
		end
		
		else if (contador==1503)
		begin
		ENcinic<=0;
		contador<=contador+1'b1;
		end
		
		
		else if (contador==1539)//se vuelve a obtener los datos si se modifico algo en bloque chcrfolo
			begin
			if (selmuxctr==1)
				begin
				contador<=170;
				contEdatos<=0;
				end
			else contador<=contador+1'b1;
			end
			
		else if (contador==1540)//se reinicia el cronometro en caso de haber un cambio en el switch de activación de el cronometro
			begin
			if(cronoini!=crini2)
				begin
				ENgcrono<=1;
				crini2<=cronoini;
				selmuxctr<=5;
				contador<=contador+1'b1;
				end
			else contador<=1740;
			end
		else if (contador==1542)
			begin
			ENgcrono<=0;
			contador<=contador+1'b1;
			end
		else if(contador==1740)//se comprueba si se desea programar la hora, fecha o cronometro
		begin
			if (Phora==1&&lock==1)
				begin
				ENchora<=1;
				ENccrono<=0;
				selmuxdt<=1;
				contador<=contador+1'b1;
				end
			else if (Pfecha==1&&lock==1)
				begin
				ENcfecha<=1;
				ENccrono<=0;
				selmuxdt<=2;
				contador<=contador+1'b1;
				end
			else if (Pcrono==1)
				begin
				ENccrono<=1;
				selmuxdt<=3;
				contador<=920;
				end
			else contador<=920;
			
		end
			
		else if (contador==1742)//se guardan los cambios en caso de haber cambiado la hora o la fecha
		begin
		if (Phora==0&&selmuxdt==1)
			begin
			ENchora<=0;
			ENghora<=1;
			selmuxctr<=3;
			contador<=contador+1'b1;
			end
		else if(Pfecha==0&&selmuxdt==2)
			begin
			ENcfecha<=0;
			ENgfecha<=1;
			selmuxctr<=4;
			contador<=contador+1'b1;
			end
		
		end
		
		else if (contador==1744)
		begin
			ENghora<=0;
			ENgfecha<=0;
			ENgcrono<=0;
			contador<=contador+1'b1;
		end
		else if (contador==1992)//en caso de terminar de guardar, se vuelven al inicio
			begin
			contador<=920;
			end
		
		else contador<=contador+1'b1;
		if (contEdatos==12500000)contEdatos<=0;
		if(Pcrono==0)
			begin
				ENccrono<=0;
				selmuxdt<=0;
			end
		
	end
	
	end

endmodule
