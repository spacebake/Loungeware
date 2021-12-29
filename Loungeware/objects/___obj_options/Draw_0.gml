draw_set_font(___fnt_options_title);
draw_set_halign(fa_center);

//black outline
draw_set_colour(c_gbblack);
for (var i = -1; i < 4; i++) {
	draw_text(xpos+1, ypos+i, title_txt[$ state]);
	draw_text(xpos-1, ypos+i, title_txt[$ state]);
}

//draw yellow under
draw_set_colour(c_gbyellow);
for (var i = 0; i < 4; i++)
	draw_text(xpos, ypos + i, title_txt[$ state]);

//first big text
draw_set_colour(c_gbwhite);
draw_text(xpos, ypos, title_txt[$ state]);


if (state == "normal") {
	____menu_text_vertical_draw(
		xpos,
		menu_y,
		menu,
		cursor,
		confirmed
	);
} else if (state == "controls") {
	draw_set_font(___fnt_gallery_elipses);
	draw_text(xpos, menu_ypos, );
}

//draw_set_font(___fnt_gallery_elipses);
//for (var i = 0; i < array_length(options); i++) {
//	var option = options[i];
//	var txt = option.txt;
	
//	var c = c_gbwhite;
//	if (cursor == i) {
//		c = c_gbyellow;
//		txt = "<wave>" + txt;
//	}
	
//	___draw_text_advanced(xpos, menu_y + i*menu_ystep, option.txt, c, c, c, c, 1);
//}
