/// @desc Draw message.
draw_set_font(katsaii_witchwanda_fnt_default);
draw_set_colour(JamCRed.FORREST_FIRE);
draw_set_alpha(1 - lifeTimer);
katsaii_witchwanda_draw_text_wonky(x, y, "REVENGE");
draw_set_alpha(1);