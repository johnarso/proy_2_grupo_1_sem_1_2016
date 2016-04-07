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
module TODO(
	input [2:0] sw,
	input relojsito, resetito,
	output [11:0] colorsito,
	output hsito, vsito
    );
	 
	 wire relojsita, resetita;
	 assign relojsita=relojsito;
	 assign resetita=resetito;
	 
	 wire finale, tempo, formaggio;
	 wire [7:0] h_oro, m_oro, s_oro, giorno, messe, agno, ora, minute, secondo, h_run, m_run, s_run;
	 
	 wire PT;
	 wire [11:0] rgb_next;
	 reg [11:0] rgb_reg;
	 wire ON_VID;
	 wire [11:0] colour;
	 
	 wire [9:0] x_p, y_p;
	 
	 wire [2:0] swit;
	 assign swit=sw;
	 wire medio_seg;
	 
	 wire [1:0] direc_prog;
	 wire [2:0] prog_crono, prog_fecha, prog_hora;
	 
	Prueba inst_prueba(
	.SW(swit),
	.d_pg(direc_prog),
	.p_cr(prog_crono), .p_fe(prog_fecha),.p_ho(prog_hora),
	.CRONO_FIN(finale), .AMPM(tempo), .FORMATO(formaggio),
	.HREL(h_oro), .MREL(m_oro), .SREL(s_oro), .DIA(giorno), .MES(messe), .ANIO(agno), 
	.HRUN(h_run), .MRUN(m_run), .SRUN(s_run),
	.HCRON(ora), .MCRON(minute),.SCRON(secondo)
    );
	 
	 Caracter_selector inst_selector_char(
    .NEXYS_CLOCK(relojsita), .clk_parp(medio_seg),
	 .dir_prog(direc_prog),
	 .p_crono(prog_crono), .p_fecha(prog_fecha), .p_hora(prog_hora),
	 .crono_end(parpa_parpa), .am_pm(tempo), .formato(formaggio),
	 .hora(h_oro), .min(m_oro), .seg(s_oro), .dia(giorno), .mes(messe), .year(agno), 
	 .hcrono_run(h_run), .mcrono_run(m_run), .scrono_run(s_run), 
	 .hcrono(ora), .mcrono(minute), .scrono(secondo),
	 .pix_x(x_p),
	 .pix_y(y_p),
	 .color(colour)
	 );
	 
	 Contador inst_25MHz(
    .CLK_NX(relojsita),
	 .reset(resetita),
	 .pixel_rate(PT),
	 .clk_RING(medio_seg)
	 );
	 
	 Sincronizador inst_sync(
    .reset(resetita), .CLK_pix_rate(PT),
	 .h_sync(hsito), .v_sync(vsito), .video_on(ON_VID),
	 .pixel_x(x_p), .pixel_y(y_p)
	 );
	 
	 RGB_MUX inst_mux_color(
    .video_on(ON_VID),
	 .color(colour),
	 .RGB(rgb_next)
	 );
	 
	 Generador_RING inst_parpadeo(
    .CLK_Ring(medio_seg), .reset(resetita),
	 .fin_crono(finale),
	 .band_parp(parpa_parpa)
	 );
	 
		always @(posedge relojsita, posedge resetita)
		 begin
			 if(resetita)
				rgb_reg<=12'hfff;
			 else
			 begin
				if (PT)
					rgb_reg<=rgb_next;
			 end
		 end
		 assign colorsito=rgb_reg;
	 
	 
endmodule
