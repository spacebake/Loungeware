


if (show_board){
	
	var _score_count = array_length(leaderboard_data);
	var _board_margin = 64;
	var _surf_w = VIEW_W - (_board_margin);
	var _surf_h = VIEW_H - (_board_margin*2);
	
	var _icon_size  = sprite_get_height(___spr_leaderboard_icons);

	if (!surface_exists(surf_board)){
		surf_board = surface_create(_surf_w, _surf_h);
	}
	
	surface_set_target(surf_board);
	draw_clear_alpha(c_white, 0);

	var _xx_base = _board_margin;
	var _xx = _xx_base;
	var _yy = 2 + scroll_offset;
	var _scale = 2;
	var _vsep = 6;
	var _hsep = 6;
	var _letter_sep = 6;
	var _this, _icon_sprite, _icon_frame, _line_y, _player_name, _name_y, _name_x, _score,
	_score_x, _score_y, _position_str, _pos_x, _pos_y, _vs_x, _vs_y1, _vs_y2, _icon_scale, 
	_icon_x, _icon_y, _bar_alpha, _record_y, _is_blank;
	var _position = 0;
	var _prev_score = infinity;
	var _position_store = 0;

	// DRAW TOP SCORES ---------------------------------------------------------------
	draw_set_font(fnt_gallery);
	draw_set_color(col_bar);
	draw_dotted_line(_xx, _yy, _xx + _surf_w, _yy, 4, 4);

	_yy += 6;
	for (var i = 0; i < min(_score_count, max_highlighted_score_count); i++){
		 _this = leaderboard_data[i];
		 _score = string(_this.score);
		 _bar_alpha = min(1, _this.scale);
		 _player_name = string_upper(string_copy(_this.name, 1, floor(string_length(_this.name)) * _bar_alpha));
		 _xx = _xx_base;
		 _is_blank = (_this.name == "----");
		 if (_is_blank){
			_score = "----";
			_player_name = "----";
		}
		 
		 // get position
		 if (_is_blank || _this.score < _prev_score){
			 _position = _position + 1 + _position_store;
			 _position_store = 0;
		 } else {
			 _position_store += 1;
		 }
		 _prev_score = _this.score;
		 
		 // draw horizontal seperator line
		draw_set_color(col_bar);
		draw_set_alpha(_bar_alpha);
		_line_y = _yy + (_icon_size + (_vsep / 2)) * _scale;
		draw_dotted_line(_xx, _line_y, _xx + _surf_w, _line_y, 4, 4);
		
		// draw pointer (if most recent score)
		if (is_latest_score(_this)){
			var _pointer_x = (_xx - 20) + lengthdir_x(2, latest_arrow_dir);
			draw_sprite(___spr_leaderboard_arrows, 2, _pointer_x, _yy + 28);
			_player_name = "<wave,1>" + _player_name;
		}
		 
		// draw position
		_position_str = stringify_position(_position);
		draw_set_color(col_pos);
		_pos_x = _xx;
		_pos_y = _yy + 20;
		draw_text_transformed(_pos_x, _pos_y, _position_str, 1, 1, 0);
		_xx += 52;
		
		
		// draw vertical seperator
		_vs_x = _xx + 4;
		_vs_y1 = _yy + 4;
		draw_set_color(col_bar);
		_vs_y2 = (_yy+(_icon_size*_scale)) - 8;
		draw_dotted_line(_vs_x, _vs_y1+2, _vs_x, _vs_y2+2, 4, 4);
		_xx += 16;
		draw_set_alpha(1);
		
		// draw icon
		_icon_sprite = asset_get_index(_this.sprite);
		_icon_frame = _this.frame;
		_icon_scale = _scale * _this.scale;
		_icon_x = _xx + ((_icon_size * _scale) - (_icon_size * _icon_scale)) / 2;
		_icon_y = _yy  + ((_icon_size * _scale) - (_icon_size * _icon_scale)) / 2;
		
		draw_sprite_ext(_icon_sprite, _icon_frame, _icon_x, _icon_y, _icon_scale, _icon_scale, 0, c_white, 1);
		
		// draw name
		_name_y = _yy + 6; 
		_name_x = _xx + ((_icon_size + _hsep) * _scale) + 4;

		draw_set_color(c_gbwhite);
		if (is_player(_this)){
			draw_set_color(c_gbyellow);
		}
		
		if (_is_blank) draw_set_color(col_pos);
		___global.___draw_text_advanced(_name_x, _name_y, 30, true, true, _player_name, 1, 1, _letter_sep);
		
		// draw score
		_score_x = _name_x;
		_score_y = _name_y + 30;
		while (string_length(_score) < 4) _score = "0" + _score;
		 _score = string_upper(string_copy(_score, 1, floor(string_length(_score)) * _bar_alpha));
		draw_set_color(c_gbpink);
		if (_is_blank) draw_set_color(col_pos);
		___global.___draw_text_advanced(_score_x, _score_y, 30, true, true, _score, 1, 1, _letter_sep);
		
		_yy += (_icon_size + _vsep) * _scale;
	}
	
	
	// draw the rest --------------------------------------------------------------------
	_scale = 1;
	_yy -= 10;
	_letter_sep /= 2;
	var _draw_this;
	_xx = _xx_base;
	_line_y = _yy +36;
	draw_set_color(col_bar);
	draw_dotted_line(_xx, _line_y, _xx + _surf_w, _line_y, 2, 4);
	
	for (var i = max_highlighted_score_count; i < min(_score_count, max_score_count); i++){
		 
		 _record_y = _yy;
		 _draw_this = !(_yy > _surf_h + 50 || _yy < -80);
		
		_xx = _xx_base;
		_this = leaderboard_data[i]; 
		_score = string(_this.score);

		while (string_length(_score) < 4) _score = "0" + _score;
		_score = string_upper(string_copy(_score, 1, floor(string_length(_score)) * _bar_alpha));
		_player_name = string_upper(string_copy(_this.name, 1, floor(string_length(_this.name)) * min(1, _this.scale)));
		_icon_sprite = asset_get_index(_this.sprite);
		_icon_frame = _this.frame;
		_bar_alpha = min(1, _this.scale);
		

		_is_blank = (_this.name == "----");
		if (_is_blank){
			_score = "----";
			_player_name = "----";
		}
		
		// get position
		if (_is_blank || _this.score < _prev_score){
			_position = _position + 1 + _position_store;
			_position_store = 0;
		} else {
			_position_store += 1;
		}
		_prev_score = _this.score;
		

		draw_set_alpha(_bar_alpha);
		
		// draw horizontal seperator
		_yy += _icon_size + _vsep + 5;
		_line_y = _yy +35;
		draw_set_color(col_bar);
		if (_draw_this) draw_dotted_line(_xx, _line_y, _xx + _surf_w, _line_y, 2, 4);
		
		// draw pointer (if most recent score)
		if (is_latest_score(_this)){
			var _pointer_x = (_xx - 20) + lengthdir_x(2, latest_arrow_dir);
			draw_sprite(___spr_leaderboard_arrows, 2, _pointer_x, _yy + 13);
			_player_name = "<wave,1>" + _player_name;
		}
		
		// draw position
		draw_set_font(fnt_frogtype);
		_position_str = stringify_position(_position);
		draw_set_color(col_pos);
		_pos_x = _xx + 8;
		_pos_y = _yy + 8;
		if (_draw_this) draw_text_transformed(_pos_x, _pos_y, _position_str, _scale, _scale, 0);
		_xx += 46;
		
		// draw vertical seperator
		_vs_x = _xx + 9;
		_vs_y1 = _yy + 6;
		draw_set_color(col_bar);
		_vs_y2 = (_yy+(_icon_size*_scale)) - 13;
		if (_draw_this) draw_dotted_line(_vs_x, _vs_y1+2, _vs_x, _vs_y2+2, 2, 4);
		_xx += 30;
		
		draw_set_alpha(1);
		
		// draw icon
		_icon_scale = _scale * _this.scale;
		_icon_x = _xx + (((_icon_size)/2) * (1-_this.scale)) + 6;
		_icon_y = _yy + (((_icon_size)/2) * (1-_this.scale));

		if (_draw_this) draw_sprite_ext(_icon_sprite, _icon_frame, _icon_x, _icon_y, _icon_scale, _icon_scale, 0, c_white, 1);
		
		// draw name
		_name_y = _yy + 8; 
		_name_x = _xx + ((_icon_size + _hsep) * _scale) + 32;
		
		draw_set_color(c_gbwhite);
		if (is_player(_this)){
			draw_set_color(c_gbyellow);
		}
		if (_is_blank) draw_set_color(col_pos);
		if (_draw_this) ___global.___draw_text_advanced(_name_x, _name_y, 30, true, true, _player_name, 1, 1, _letter_sep);
		
		// draw score
		_score_y = _name_y;
		_score_x = _surf_w;
		draw_set_color(c_gbpink);
		if (_is_blank) draw_set_color(col_pos);
		draw_set_halign(fa_right);
		if (_draw_this) ___global.___draw_text_advanced(_score_x, _score_y, 30, true, true, _score, 1, 1, _letter_sep);
		draw_set_halign(fa_left);
		
		score_height_minor = _yy - _record_y;
	}
	
	if (total_scoreboard_height == -1){
		total_scoreboard_height = _yy;
		scroll_max = (total_scoreboard_height - _surf_h) + _board_margin;
		scrolling_enabled = true;
	}
	
	surface_reset_target();
	draw_surface(surf_board, 0, _board_margin);
	
	// draw scrollbar
	draw_set_color(col_bar);
	var _bar_margin_left = 22;
	var _bar_thickness = 4;
	var _sbx1 =  _surf_w + _bar_margin_left;
	var _sbx2 = _sbx1 + _bar_thickness;
	var _sby1 = _board_margin;
	var _sby2 = _sby1 + _surf_h;
	var _sb_h = _sby2 - _sby1;
	draw_set_color(col_bar);
	draw_rectangle_fix(_sbx1, _sby1, _sbx2, _sby2);
	
	// draw scrollbar notch
	var _notch_w = 14;
	var _notch_h = (_surf_h / scroll_max) * _sb_h;
	var _nx1 = ((_sbx1 + _sbx2)/2) - (_notch_w/2);
	var _nx2 = _nx1 + _notch_w;
	var _scroll_pos = abs(scroll_offset) / scroll_max;
	var _ny1 = _sby1 + ((_sb_h - _notch_h) * _scroll_pos);
	var _ny2 = _ny1 + _notch_h;
	draw_rectangle_fix(_nx1, _ny1, _nx2, _ny2);
	
	// draw arrow prompts
	var _at_top = (_scroll_pos <= 0);
	var _at_bottom = (_scroll_pos >= 1);
	var _a_margin = 20;
	var _ax = VIEW_W/2;
	var _float_rad = 2;
	var _a1y = (_sby1 - _a_margin) + lengthdir_y(_float_rad, arrow_float_dir);
	var _a2y = (_sby2 + _a_margin) + lengthdir_y(_float_rad, arrow_float_dir+180);
	var _fade_steps = 6;
	arrow_1_alpha = ___toggle_fade(arrow_1_alpha, !_at_top, _fade_steps);
	arrow_2_alpha = ___toggle_fade(arrow_2_alpha, !_at_bottom, _fade_steps);
	
	draw_set_alpha(arrow_1_alpha);
	draw_sprite(___spr_leaderboard_arrows, 0, _ax, _a1y);
	draw_set_alpha(arrow_2_alpha);
	draw_sprite(___spr_leaderboard_arrows, 1, _ax, _a2y);
	draw_set_alpha(1);
}

// draw button guide
if (button_guide_show){
	draw_set_alpha(button_guide_alpha);
	draw_sprite(___spr_back_prompt, button_guide_frame, 0, 0);
	draw_set_alpha(1);
}


// draw loader
if ((state == "load" || state == "hide_loader") && show_loader_timer <= 0){
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
	var _error_title = http_error_title;
	
	var _str = string_upper(http_error_msg);
	if (http_error_shake_timer > 0){
		var _sv = 2;
		_sx = random_range(-_sv, _sv);
		_sy = random_range(-_sv, _sv);
		var _wavetxt = "<shake," + string(http_error_shake_timer/3) + ">";
		var _error_title = _wavetxt + _error_title;
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


// closing circle
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