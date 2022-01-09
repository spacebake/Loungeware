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
	
} else if (state == "key_controls") {
	draw_set_font(___fnt_gallery_elipses);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_text(xpos, prompt_ypos, menu[cursor].prompt);
	
	____menu_text_vertical_draw(rebind_left_xpos, rebind_y, keyboard_rebinds_menu_left, rebind_index, false, undefined, undefined, undefined, fa_left);
	//____menu_text_vertical_draw(rebind_right_xpos, rebind_y, empty_rebinds, rebind_index, false, undefined, undefined, undefined, fa_right);
	draw_rebinds(keyboard_rebinds_values_right(0), 0, 100);
	
	if (listening) {
		___global.___draw_text_advanced(xpos, listening_ypos, 35, false, true, "<wave,3>Listening...");	
	}
	
} else if (state == "gamepad_controls") {
	
	//var last_gamepad_button = undefined;
	//var last_gamepad_axis = undefined;
	
	//for (var i=0;i<array_length(___global.controller_values);i++) {
	//	for ( var j = gp_face1; j < gp_axisrv; j++ ) {
	//	    if ( gamepad_button_check( i, j ) ) {
	//			last_gamepad_button = i;
	//			break;
	//		}
	//	}
		
	//	for (var j = 0; j < gamepad_axis_count(i); j++) {
	//		if (gamepad_axis_value(i, j) != 0) {
	//			last_gamepad_axis = j;
	//			break;
	//		}
	//	}
		
		
	//}
	
	//draw_set_font(-1);
	//draw_set_halign(fa_left);
	//draw_text(10, 10, [gamepad_axis_count(i), last_gamepad_button, last_gamepad_axis,]);
	
	//TODO: METHODS
	draw_set_font(___fnt_gallery_elipses);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_text(xpos, prompt_ypos, menu[cursor].prompt);
	
	____menu_text_vertical_draw(rebind_left_xpos, rebind_y, gamepad_rebinds_menu_left, rebind_index, false, undefined, undefined, undefined, fa_left);
	____menu_text_vertical_draw(rebind_right_xpos, rebind_y, gamepad_rebinds_menu_right(), rebind_index, false, undefined, undefined, undefined, fa_right);
	
	if (listening) {
		___global.___draw_text_advanced(xpos, listening_ypos, 35, false, true, "<wave,3>Listening...");	
	}
	
} 

if (state == "gamepad_controls" || state == "key_controls") {
	
	draw_set_font(___fnt_gallery_elipses);
	var xx = xpos - string_width(menu[cursor].prompt) / 2 //left
		+ string_width("Press") + string_width(" ")*1.5 //adjust right
		- 9; //half width of button
		
	var yy = prompt_ypos - 10; //half height of button
	
	draw_sprite(spr_button_a, 0, xx, yy);
	
	xx = xpos - string_width(menu[cursor].prompt) / 2 //left
		+ string_width("Press   to add a key, or") + string_width(" ")*1.5 //adjust right
		- 9; //half width of button
		
	draw_sprite(spr_button_b, 0, xx, yy);
	
	
	draw_set_font(___fnt_lw)
	log(string_height("M"));
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
