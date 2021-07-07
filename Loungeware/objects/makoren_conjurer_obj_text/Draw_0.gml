draw_set_font(font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// the text you need to copy
draw_text_ext_color(x, y, target_text, 8, 110, c_white, c_white, c_white, c_white, 1);

// the text you control


draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);
