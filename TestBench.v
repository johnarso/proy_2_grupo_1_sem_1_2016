`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:48:16 04/19/2016
// Design Name:   Sistema
// Module Name:   C:/Users/Johan/Desktop/I semestre 2016/Lab Digitales/Proyecto 2/programacion/beta/proyecto2/TestBench.v
// Project Name:  proyecto2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Sistema
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestBench;

	// Inputs
	reg CLOCK_NEXYS;
	reg [5:0] switch;
	reg [3:0] botones;
	reg [7:0] AD_IN;

	// Outputs
	wire [7:0] AD_OUT;
	wire [11:0] COLORES;
	wire H_syncro;
	wire V_syncro;
	wire R_D;
	wire C_S;
	wire W_R;
	wire A_D;
	wire [5:0] LED;
	wire clknex;

	// Instantiate the Unit Under Test (UUT)
	Sistema uut (
		.CLOCK_NEXYS(CLOCK_NEXYS), 
		.switch(switch), 
		.botones(botones), 
		.AD_IN(AD_IN), 
		.AD_OUT(AD_OUT), 
		.COLORES(COLORES), 
		.H_syncro(H_syncro), 
		.V_syncro(V_syncro), 
		.R_D(R_D), 
		.C_S(C_S), 
		.W_R(W_R), 
		.A_D(A_D), 
		.LED(LED), 
		.clknex(clknex)
	);

	initial begin
		// Initialize Inputs
		CLOCK_NEXYS = 0;
		switch = 0;
		botones = 0;
		AD_IN = 8'h12;

		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here
		
	end
	always 
	begin
		#5 CLOCK_NEXYS=!CLOCK_NEXYS;
	end
      
	initial
	begin
		switch[5]=1;
		#30
		switch[5]=0;
		#2000
		switch[4]=1;
		#25000
		botones[3]=1;
		#25000
		botones[3]=1;
		#25000
		switch[4]=0;
		
	end
endmodule

