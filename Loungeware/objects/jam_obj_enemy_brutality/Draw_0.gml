/// @desc Draw message.
draw_set_font(jam_fnt_default);
draw_set_colour(JamCRed.FORREST_FIRE);
draw_set_alpha(1 - lifeTimer);
jam_draw_text_wonky(x, y, "REVENGE");
draw_set_alpha(1);