/// @desc Draw message.
draw_set_font(jam_fnt_tiny);
draw_set_colour(JamCPink.WILD_STRAWBERRY);
draw_set_alpha(1 - lifeTimer);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
jam_draw_text_wonky(x, y, "CRIT");
draw_set_alpha(1);