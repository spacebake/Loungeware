draw_set_font(___fnt_options_title);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

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
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_text(xpos, prompt_ypos, menu[cursor].prompt);
	
	____menu_text_vertical_draw(rebind_left_xpos, rebind_y, rebinds_menu_left, rebind_index, false, undefined, undefined, undefined, fa_left);
	____menu_text_vertical_draw(rebind_right_xpos, rebind_y, rebinds_menu_right(), rebind_index, false, undefined, undefined, undefined, fa_right);
	
	if (listening) {
		___global.___draw_text_advanced(xpos, listening_ypos, 35, false, true, "<wave,3>Listening...");	
	}
	
	
	if (true) {} else {
		
		
		
		//var curr_rebind = rebinds[rebind_index];
		
		//draw_text(xpos, rebind_y, string_upper(curr_rebind));	
		
		
		//draw_set_halign(fa_left);
		
		//var keyboard_curr = ___global.curr_input_keys[$ curr_rebind];
		//var keystrs_curr = array_create(array_length(keyboard_curr));
		//var total_width = 0;
		
		//for (var i = 0; i < array_length(keyboard_curr); i++) {
		//	keystrs_curr[i] = ___global.keycode_to_str[keyboard_curr[i]];
		//	total_width += string_width(___global.keycode_to_str[keyboard_curr[i]]);
		//}
		
		//var xx = xpos - total_width/2;
		
		//for (var i = 0; i < array_length(keyboard_curr); i++) {
		//	draw_text(xx, rebind_curr_y, keystrs_curr[i]);
			
		//	xx += string_width(keystrs_curr[i]);
		//}
		
		////no bindings
		//if (array_length(keyboard_curr) == 0) {
		//	draw_set_halign(fa_center);
		//	draw_text(xpos, rebind_curr_y, "---");
			
		//}
		
	}
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
