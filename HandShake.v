`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:35:15 04/15/2016 
// Design Name: 
// Module Name:    HandShake 
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
module HandShake(
	input [7:0] h_oro_a, m_oro_a, s_oro_a, 
	input [7:0] giorno_a, messe_a, agno_a, ora_a, minute_a, secondo_a,
	input [7:0] h_run_a, m_run_a, s_run_a,
	input HS_flag, reset, reloj_nex,
	output wire [7:0] h_oro_o, m_oro_o, s_oro_o, giorno_o, messe_o, agno_o,
	output wire [7:0] ora_o, minute_o, secondo_o, h_run_o, m_run_o, s_run_o
    );
	 
	reg [7:0] h_oro_nx, m_oro_nx, s_oro_nx, giorno_nx, messe_nx;
	reg [7:0] agno_nx, ora_nx, minute_nx, secondo_nx, h_run_nx, m_run_nx, s_run_nx;
	
	always @(posedge reloj_nex)
	begin
		if (reset)
		begin
			h_oro_nx=8'h0;
			m_oro_nx=8'h0;
			s_oro_nx=8'h0;
			giorno_nx=8'h0;
			messe_nx=8'h0;
			agno_nx=8'h0;
			ora_nx=8'h0;
			minute_nx=8'h0;
			secondo_nx=8'h0;
			h_run_nx=8'h0;
			m_run_nx=8'h0;
			s_run_nx=8'h0;
		end
		else if (HS_flag)
		begin
			h_oro_nx=h_oro_a;
			m_oro_nx=m_oro_a;
			s_oro_nx=s_oro_a;
			giorno_nx=giorno_a;
			messe_nx=messe_a;
			agno_nx=agno_a;
			ora_nx=ora_a;
			minute_nx=minute_a;
			secondo_nx=secondo_a;
			h_run_nx=h_run_a;
			m_run_nx=m_run_a;
			s_run_nx=s_run_a;
		end
	end
	assign h_oro_o=h_oro_nx;
	assign m_oro_o=m_oro_nx;
	assign s_oro_o=s_oro_nx;
	assign giorno_o=giorno_nx;
	assign messe_o=messe_nx;
	assign agno_o=agno_nx;
	assign ora_o=ora_nx;
	assign minute_o=minute_nx;
	assign secondo_o=secondo_nx;
	assign h_run_o=h_run_nx;
	assign m_run_o=m_run_nx;
	assign s_run_o=s_run_nx;
	
endmodule
