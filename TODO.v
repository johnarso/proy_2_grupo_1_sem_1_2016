`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:24:25 04/02/2016 
// Design Name: 
// Module Name:    TODO 
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
module VGA(
	input reloj_nexys, reset_total,
	input [1:0] direc_prog,
	input [2:0] prog_crono, prog_fecha, prog_hora,
	input finale, tempo, formatto, handshake,
	input [7:0] h_oro_act, m_oro_act, s_oro_act, 
	input [7:0] giorno_act, messe_act, agno_act, ora_act, minute_act, secondo_act,
	input [7:0] h_run_act, m_run_act, s_run_act,
	output [11:0] color_salida,
	output hsincro, vsincro
    );
	 
	 wire reloj_interno, reset_interno;
	 assign reloj_interno=reloj_nexys;
	 assign reset_interno=reset_total;
	 
	 wire PT;
	 wire [11:0] rgb_next;
	 reg [11:0] rgb_reg;
	 wire ON_VID;
	 wire [11:0] colour;
	 wire [9:0] x_p, y_p;
	 wire medio_seg;
	 wire [7:0] h_oro, m_oro, s_oro, giorno, messe, agno, ora, minute, secondo, h_run, m_run, s_run;
	 
	 

	 HandShake inst_handshake(
	 .h_oro_a(h_oro_act), .m_oro_a(m_oro_act), .s_oro_a(s_oro_act), 
	 .giorno_a(giorno_act), .messe_a(messe_act), .agno_a(agno_act), 
	 .ora_a(ora_act), .minute_a(minute_act), .secondo_a(secondo_act),
	 .h_run_a(h_run_act), .m_run_a(m_run_act), .s_run_a(s_run_act),
	 .HS_flag(handshake), .reset(reset_interno), .reloj_nex(reloj_interno),
	 .h_oro_o(h_oro), .m_oro_o(m_oro), .s_oro_o(s_oro), .giorno_o(giorno), .messe_o(messe), .agno_o(agno),
	 .ora_o(ora), .minute_o(minute), .secondo_o(secondo), .h_run_o(h_run), .m_run_o(m_run), .s_run_o(s_run)
    );
	 
	 Caracter_selector inst_selector_char(
    .NEXYS_CLOCK(reloj_interno), .clk_parp(medio_seg),
	 .dir_prog(direc_prog),
	 .p_crono(prog_crono), .p_fecha(prog_fecha), .p_hora(prog_hora),
	 .crono_end(parpadeo), .am_pm(tempo), .formato(formatto),
	 .hora(h_oro), .min(m_oro), .seg(s_oro), .dia(giorno), .mes(messe), .year(agno), 
	 .hcrono_run(h_run), .mcrono_run(m_run), .scrono_run(s_run), 
	 .hcrono(ora), .mcrono(minute), .scrono(secondo),
	 .pix_x(x_p),
	 .pix_y(y_p),
	 .color(colour)
	 );
	 
	 Contador inst_25MHz(
    .CLK_NX(reloj_interno),
	 .reset(reset_interno),
	 .pixel_rate(PT),
	 .clk_RING(medio_seg)
	 );
	 
	 Sincronizador inst_sync(
    .reset(reset_interno), .CLK_pix_rate(PT),
	 .h_sync(hsincro), .v_sync(vsincro), .video_on(ON_VID),
	 .pixel_x(x_p), .pixel_y(y_p)
	 );
	 
	 RGB_MUX inst_mux_color(
    .video_on(ON_VID),
	 .color(colour),
	 .RGB(rgb_next)
	 );
	 
	 Generador_RING inst_parpadeo(
    .CLK_Ring(medio_seg), .reset(reset_interno),
	 .fin_crono(finale),
	 .band_parp(parpadeo)
	 );
	 
		always @(posedge reloj_interno, posedge reset_interno)
		 begin
			 if(reset_interno)
				rgb_reg<=12'hfff;
			 else
			 begin
				if (PT)
					rgb_reg<=rgb_next;
			 end
		 end
		 assign color_salida=rgb_reg;
		
	 
	 
endmodule
