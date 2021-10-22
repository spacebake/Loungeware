draw_set_font(fnt_gallery);

var _line_x = 0;

// ----------------------------------------------------------------------------------------------
// title (for name input)
// ----------------------------------------------------------------------------------------------
if (input_prompt_alpha > 0){
	draw_set_color(c_gbyellow);
	draw_set_font(fnt_gallery);
	var _title_x = VIEW_W/2;
	var _title_y = 220 + name_zoom_offset;
	draw_set_halign(fa_center);
	draw_set_alpha(input_prompt_alpha);
	___global.___draw_text_advanced(_title_x, _title_y,16, true, true, title_text, 0.5, 1, 5);
	draw_set_halign(fa_left);
	draw_set_alpha(1);
}



// ----------------------------------------------------------------------------------------------
// NAME INPUT
// ----------------------------------------------------------------------------------------------
if (draw_input_box){

	var _letter_sep_x = 32;
	var _name_w = _letter_sep_x * string_length(name);
	var _name_w_max = _letter_sep_x * name_max_chars;
	var _name_x = ((VIEW_W/2) - (_name_w/2))  + string_width("M");
	var _name_y = (270) + input_y_offset + name_zoom_offset;
	var _char_x = 0;
	var _line_x, _line_y, _line_thickness;
	var _name_margin = 12;
	var _confirmation_y_base = 0;

	draw_set_color(col_bar);
	_line_x = (VIEW_W/2) - (_name_w_max/2);
	_line_y = _name_y - _name_margin;
	_line_thickness = 4;
	draw_rectangle_fix(_line_x, _line_y - (_line_thickness/2), _line_x + _name_w_max, _line_y + (_line_thickness/2));
	_line_y += 30 + _name_margin;
	draw_rectangle_fix(_line_x, _line_y - (_line_thickness/2), _line_x + _name_w_max, _line_y + (_line_thickness/2));

	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	// draw selected icon
	if (confirm_icon_alpha > 0){
		var _ix = (VIEW_W/2) - (isd_icon_w/2);
		var _iy = (_name_y - 74) - 10;
		draw_sprite_ext(___spr_leaderboard_icon_border, 0, _ix, _iy, isd_scale, isd_scale, 0, col_bar, confirm_icon_alpha);
		draw_sprite_ext(isd_icon_spr, isd_cursor_index, _ix, _iy, isd_scale, isd_scale, 0, c_white, confirm_icon_alpha);
	}


	for (var i = 0; i < name_max_chars; i++){
	
		_char_x = ((_name_x) + (i * _letter_sep_x));
		var _last_letter_prog = (i == string_length(name)-1) * (last_letter_timer/last_letter_timer_max);
		var _scale = 1 + (0.5 * _last_letter_prog);
	
		if (i < string_length(name)){
			draw_set_color(input_text_col);
			var _letter = string_char_at(name, i+1);
			var _lx = _char_x;
			var _ly = _name_y + (string_height("M")/2);
			_confirmation_y_base = _ly;


			draw_text_transformed(_lx, _ly, _letter, _scale, _scale, 0);
		} 
	
		if (cursor_flash_timer >= cursor_flash_timer_max/2 && i == string_length(name)){
			draw_set_color(col_bar);
			var _rec_w = 20;
			var _rec_h = 4;
			var _rec_y = _name_y + 16;
			var _rec_x = _char_x - (_rec_w/2);
			if (i == 0) _rec_x -= 10;
			draw_rectangle_fix(_rec_x, _rec_y, _rec_x + _rec_w, _rec_y + _rec_h);
		}

	}
	
	if (input_error_show){
		draw_set_color(c_gbpink);
		var _store_font = draw_get_font();
		draw_set_font(fnt_frogtype);
		var _str_final = "<shake," + string(input_error_shake/2) + ">" +  input_error_msg;
		___global.___draw_text_advanced(VIEW_W/2, _name_y + 57, 30, true, true, _str_final, 1, 1, 2);
		draw_set_font(_store_font);
	}
	
	if (icon_selection_draw_enabled && isd_show_prompt){
		draw_set_alpha(isd_prompt_alpha);
		draw_set_color(c_gbyellow);
		draw_text(VIEW_W/2, _name_y + 57, isd_prompt_text);
		draw_set_alpha(1);
	}
	
	if (confirm_score_alpha > 0){
		
		draw_set_alpha(confirm_score_alpha);
		var _letter_sep_h = 16;
		var _str_w = ___global.___draw_text_advanced_width(score_string, _letter_sep_h);
		var _pad = 16;
		var _bw = _str_w + (_pad*2);
		var _bh = 38;
		var _bx1 = (VIEW_W - _bw) / 2;
		var _bx2 = _bx1 + _bw;
		var _by1 =  _name_y +  33;
		var _by2 = _by1 + _bh;
		var _border_thickness = 4;
		
		draw_set_color(col_bar);
		draw_rectangle_fix(_bx1 - _border_thickness, _by1 - _border_thickness, _bx2 + _border_thickness, _by2 + _border_thickness);

		draw_set_color(c_gbdark);
		draw_rectangle_fix(_bx1, _by1, _bx2, _by2);
		
		draw_set_color(c_gbyellow);
		___global.___draw_text_advanced(VIEW_W/2, _name_y + 43, 16, false, true, score_string, 0, 1, _letter_sep_h);

	}
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	

}

// ----------------------------------------------------------------------------------------------
// confirmation menu
// ----------------------------------------------------------------------------------------------
if (draw_confirm_menu){

	// draw sperator 
	var _cx = VIEW_W/2;
	var _line_margin = 20;
	var _line_w = VIEW_W - (_line_margin * 2);
	var _line_y = VIEW_H/2;
	draw_set_color(col_bar);
	draw_dotted_line(_cx - (_line_w/2), _line_y , _cx + (_line_w/2), _line_y , 2, 2);
	
	// draw error menu
	____menu_text_vertical_draw(
		VIEW_W/2,
		confirm_menu_y,
		confirm_menu,
		confirm_cursor,
		confirm_menu_confirmed,
	);
	

}


// ----------------------------------------------------------------------------------------------
// ICON SELECTION
// ----------------------------------------------------------------------------------------------
if (icon_selection_draw_enabled){
	
	
	var _surf_w = isd_surf_width;
	var _sep = isd_sep;
	var _surf_h = isd_surf_height;
	
	if (!surface_exists(isd_surface)){
		isd_surface = surface_create(_surf_w, _surf_h);
	}
	surface_set_target(isd_surface);
	draw_clear_alpha(c_gbdark, 1);
	
	var _xx = _sep;
	var _yy = isd_scroll_y + _sep;
	for (var i = 0; i < isd_icon_count; i++){
		draw_sprite_ext(___spr_leaderboard_icon_bg, 0, floor(_xx), floor(_yy), isd_scale, isd_scale, 0, c_white, 1);
		draw_sprite_ext(isd_icon_spr, i, floor(_xx), floor(_yy), isd_scale, isd_scale, 0, c_white, 1);
		var _selected = isd_cursor_index == i;
		
		if (_selected){

		}
		
		_xx += isd_icon_w + _sep;
		if (_xx >= _surf_w){
			_xx = _sep;
			_yy += isd_icon_w + _sep;
		}
	}
	
	// draw cursor
	if (isd_cursor_enabled){
		var _cursor_x = isd_cursor_display_x + lengthdir_x(isd_cursor_bounce_rad, isd_cursor_bounce_dir);
		var _cursor_y = isd_scroll_y + isd_cursor_display_y + lengthdir_y(isd_cursor_bounce_rad, isd_cursor_bounce_dir);
		draw_sprite_ext(___spr_leaderboard_icon_border, 0, floor(_cursor_x), floor(_cursor_y), isd_scale, isd_scale, 0, c_gbyellow, 1);
	}
	
	surface_reset_target();
	var _scale  = icon_selection_scale;
	var _surf_x1 = (VIEW_W - (_surf_w*_scale))/2;
	var _surf_y1 = isd_surf_y_base + ((_surf_h - (_surf_h*_scale))/2);

	var _w = _surf_w * _scale;
	var _h = _surf_h * _scale;
	var _surf_x2 = _surf_x1 + _w;
	var _surf_y2 = _surf_y1 + _h;
	var _border_thickness = 4;
	
	draw_set_color(col_bar);
	draw_set_alpha(min(1, _scale));
	draw_rectangle_fix(_surf_x1 - _border_thickness, _surf_y1 - _border_thickness, _surf_x2 + _border_thickness, _surf_y2 + _border_thickness);
	draw_surface_stretched(isd_surface, _surf_x1, _surf_y1, _w, _h);
	draw_set_alpha(1);
	
	
	if (isd_draw_scrollbar){
		var _bar_w = 4;
		var _notch_w = 12;
		var _gap = 7;
		var _total_icon_list_h = (isd_icon_w + isd_sep) * (isd_icon_count div isd_icons_per_row);
		var _sbx_center = _surf_x2 + _border_thickness + _gap + (_notch_w/2);
		var _sby1 = _surf_y1 - _border_thickness;
		var _sby2 = _surf_y2 + _border_thickness;
		var _bar_h = _sby2 - _sby1;
		var _notch_h = (isd_surf_height/_total_icon_list_h) * (_bar_h);
		var _notch_y = _sby1 + ((abs(isd_scroll_y) / isd_record_max_scroll) * (_bar_h - _notch_h));
		var _alpha = min(1, icon_selection_scale);
		
		draw_set_color(col_bar);
		draw_set_alpha(_alpha);
		draw_rectangle_fix(_sbx_center - (_bar_w/2), _sby1, _sbx_center + (_bar_w/2), _sby2);
		draw_rectangle_fix(_sbx_center - (_notch_w/2), _notch_y, _sbx_center + (_notch_w/2), _notch_y + _notch_h);
		draw_set_alpha(1);

	}
}



// ----------------------------------------------------------------------------------------------
// E E
// ----------------------------------------------------------------------------------------------
if (ee_alpha > 0){
	draw_set_alpha(ee_alpha);
	draw_sprite(___spr_ee, ee_frame, VIEW_W/2, 50);
	draw_set_alpha(1);
}

// ----------------------------------------------------------------------------------------------

// ----------------------------------------------------------------------------------------------
if (backfade_alpha > 0){
	draw_set_color(c_gbdark);
	draw_set_alpha(backfade_alpha);
	draw_rectangle_fix(-1, -1, VIEW_W+1, VIEW_H+1);
	draw_set_alpha(1);
}




// ----------------------------------------------------------------------------------------------
// draw loader
// ----------------------------------------------------------------------------------------------
if ((state == "submit" || state == "hide_loader") && show_loader_timer <= 0){
	var _lx = VIEW_W/2;
	var _ly = VIEW_H/2;
	draw_sprite_ext(___spr_leaderboard_spinner, 0, _lx, _ly, loader_scale, loader_scale, loader_dir, c_white, 1);
}

// ----------------------------------------------------------------------------------------------
// draw error
// ----------------------------------------------------------------------------------------------
if (http_error_alpha > 0){
	

	
	draw_set_font(fnt_frogtype);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_gbpink);
	draw_set_alpha(http_error_alpha);
	var _y_os = -40;
	var _ex = VIEW_W/2;
	var _ey = (VIEW_H/2) + _y_os;
	var _sx = 0, _sy = 0;
	var _error_title = "ERROR";
	var _str = string_upper(http_error_msg);
	if (http_error_shake_timer > 0){
		var _sv = 2;
		_sx = random_range(-_sv, _sv);
		_sy = random_range(-_sv, _sv);
		var _wavetxt = "<shake," + string(http_error_shake_timer/3) + ">";
		_error_title = _wavetxt + _error_title;
		_str = _wavetxt + _str;
	}

	
	___global.___draw_text_advanced(_ex-1, _ey + 12, 32, true, true, _str, 1, 1, 1, 4);
	draw_set_font(fnt_gallery);
	___global.___draw_text_advanced(_ex, _ey - 38, 32, true, true, _error_title, 1, 2, 2 , 4);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_sprite(___spr_http_errors, 0, _sx, _y_os + _sy);

	
	// draw error menu
	____menu_text_vertical_draw(
		VIEW_W/2,
		(VIEW_H/2) + 75 + http_error_menu_y_offset,
		http_error_menu,
		http_error_menu_cursor,
		http_error_menu_confirmed,
	)
	
	
	draw_set_alpha(1);
}

// ----------------------------------------------------------------------------------------------
// exit confirmation
// ----------------------------------------------------------------------------------------------
if (ec_alpha > 0){
	draw_set_alpha(ec_alpha);
	draw_set_font(fnt_gallery);
	draw_set_halign(fa_center);
	draw_set_color(c_gbpink);
	var _ecx = VIEW_W/2;
	var _ecy = (VIEW_H/2) - 80;
	if (ec_shake){
		var _sv = min(3, ec_shake/2);
		_ecx += random_range(-_sv, _sv);
		_ecy += random_range(-_sv, _sv);
	}
	___global.___draw_text_advanced(_ecx, _ecy, 24, true, true, ec_menu_title, 1, 1, 4);
	
	____menu_text_vertical_draw(
		_ecx, 
		_ecy + 200,
		ec_menu, 
		ec_menu_cursor,
		ec_menu_confirmed
	);
	
	// draw warning sprite
	draw_sprite(___spr_warning, 0, _ecx, _ecy - 80);

	draw_set_alpha(1);
	draw_set_halign(fa_left);
}

// ----------------------------------------------------------------------------------------------
// SUCCESS SCREEN
// ----------------------------------------------------------------------------------------------
if (ss_alpha > 0){
	
	draw_set_alpha(ss_alpha);
	
	var _y_shift = 20;
	
	draw_set_color(col_green);
	draw_set_halign(fa_center);
	var _title = ss_title;
	if (ss_title_scale > 1){
		_title = "<shake," + string((ss_title_scale-1)*50) + ">" + _title;
	}
	___global.___draw_text_advanced(
		VIEW_W/2,
		((VIEW_H/2) - 30) + _y_shift,
		32, 
		true,
		true, 
		ss_title,
		1,
		ss_title_scale
	);
	
	____menu_text_vertical_draw(
		VIEW_W/2,
		((VIEW_H/2) + 80 + ss_menu_offset) + _y_shift,
		ss_menu, 
		ss_menu_cursor,
		ss_menu_confirmed
	)
	
	draw_sprite_ext(
		___spr_success, 
		0, 
		VIEW_W/2, 
		(VIEW_H/2 - 120) + _y_shift,
		ss_title_scale,
		ss_title_scale,
		0,
		c_white, 
		draw_get_alpha()
	);
	
	draw_set_halign(fa_left);
	draw_set_alpha(1);
}

// ----------------------------------------------------------------------------------------------
// draw button guide
// ----------------------------------------------------------------------------------------------
if (button_guide_alpha > 0 && ___global.show_button_prompts_menu){
	draw_set_alpha(button_guide_alpha);
	draw_sprite(___spr_back_prompt, button_guide_frame, 0, 0);
	draw_set_alpha(1);
}

// ----------------------------------------------------------------------------------------------
// closing circle
// ----------------------------------------------------------------------------------------------
if (close_circle_prog < 1){
	var _size = WINDOW_BASE_SIZE/2;
	if (!surface_exists(surf_circle)){
		surf_circle = surface_create(_size, _size);
	}
	
	surface_set_target(surf_circle);
	draw_clear(c_gbdark);
	gpu_set_blendmode(bm_subtract);
	draw_circle(_size/2, (_size/2), close_circle_prog * ( _size*0.8), 0);
	gpu_set_blendmode(bm_normal);

	surface_reset_target();
	draw_surface_stretched(surf_circle, 0, 0, VIEW_W, VIEW_H);
}