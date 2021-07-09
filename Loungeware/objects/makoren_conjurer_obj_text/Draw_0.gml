draw_set_font(font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// the text you need to copy
draw_text_ext_color(x, y, target_text_label, 8, 110, c_white, c_white, c_white, c_white, 1);

if (should_draw)
{
	// the text you control
	draw_text_color(x, y + 16, string(selected_text[0]) + " of", c_white, c_white, c_white, c_white, 1);
	draw_text_color(x, y + 24, selected_text[1], c_white, c_white, c_white, c_white, 1);
	draw_text_color(x, y + 32, selected_text[2], c_white, c_white, c_white, c_white, 1);

	// arrows appear on currently selected section
	draw_sprite_ext(makoren_conjurer_spr_arrows, 0, x, y + 16 + (8 * selected_section_index), arrow_scale, arrow_scale, 0, c_white, 1);
}

draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
