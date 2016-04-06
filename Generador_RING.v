`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:33:02 03/31/2016 
// Design Name: 
// Module Name:    Generador_RING 
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
module Generador_RING(
    input CLK_Ring, reset,
	 input wire fin_crono,
	 output reg band_parp
	 );
	 
	 reg [5:0] contador;
	 reg estado;
	 reg estado_sig;
			
	 
	 always @(posedge CLK_Ring, posedge reset)
	 begin
		if (reset)
		begin
			contador=6'd0;
			estado<=0;
			estado_sig<=1;
		end
		else
		begin
		if (fin_crono)
		 begin
			estado<=1;
		 end
		 else estado_sig<=0;
		 
			if (estado)
			begin
				if (contador<40)
				begin
					contador=contador+6'd1;		
				end
				else 
				begin
					contador=6'd0;
					estado<=0;
				end
				band_parp=contador[0];				
			end
			else band_parp=estado_sig;
				
		end
	 end
endmodule
