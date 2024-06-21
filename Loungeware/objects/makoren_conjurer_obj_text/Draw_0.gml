draw_set_font(makoren_conjurer_fnt_main);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (appear_delay <= 0) {
	// the text you need to copy
	draw_text_ext_color(x, y, target_text_label, 8, 110, c_yellow, c_yellow, c_yellow, c_yellow, 1);

	if (should_draw) {
		// the text you control
		draw_text_color(x, y + 16, string(selected_text[0]) + " of", c_white, c_white, c_white, c_white, 1);
		draw_text_color(x, y + 24, selected_text[1], c_white, c_white, c_white, c_white, 1);
		draw_text_color(x, y + 32, selected_text[2], c_white, c_white, c_white, c_white, 1);

		// arrows appear on currently selected section
		draw_sprite_ext(makoren_conjurer_spr_arrows, 0, x, y + 16 + (8 * selected_section_index), arrow_scale, arrow_scale, 0, c_white, 1);
	}
}

if (check_if_won() && !MICROGAME_WON) {
	draw_sprite(spr_button_a, floor(t / 15) % 2 == 0, x + 25, y + 38);	
}

draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
