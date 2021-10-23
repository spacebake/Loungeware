
___state_handler();

var _key_back_pressed = (KEY_SECONDARY_PRESSED || keyboard_check_pressed(vk_escape));

//----------------------------------------------------------------------------------
// NAME ENTRY
//----------------------------------------------------------------------------------
if (state == "entry"){
	
	if (state_begin){
		draw_input_box = true;
		draw_input_prompt = true;
		input_text_col = c_gbwhite;
		input_y_offset = 0;
		icon_selection_draw_enabled = false;
		draw_confirm_menu = false;
		confirm_icon_alpha = 0;
		confirm_score_alpha = 0;
		icon_selection_scale = 0;
		ignore_next_key_input_timer = 10;
	}
	
	if (substate == 0){

		first_wait = max(0, first_wait - 1);
		if (first_wait == 1) ___play_sfx(___snd_swoosh, 0.1, 0.7);
		if (first_wait <= 0){
			name_zoom_offset = ___smooth_move(name_zoom_offset, 0, 1, 6);
			if (name_zoom_offset == 0) ___substate_change(substate+1);
		}
	}
	
	if (substate == 1){
		
		if (substate_begin){
			button_guide_frame = 1;
			button_guide_show = true;
		}
		if (keyboard_check_pressed(vk_escape)){
			http_error_action_exit();
			exit;
		}
	
		last_letter_timer = max(0, last_letter_timer - 1);
		cursor_flash_timer--;
		if (cursor_flash_timer <= 0) cursor_flash_timer = cursor_flash_timer_max;
	
		ignore_next_key_input_timer = max(0, ignore_next_key_input_timer - 1);
		if (ignore_next_key_input_timer){
			keyboard_string = keyboard_string_prev;
		}

	
		if (keyboard_string != keyboard_string_prev){
		
			letter_count = 0;
			num_count = 0;
			special_count = 0;
		
			// cut string if longer than max
			if (string_length(keyboard_string) > name_max_chars) keyboard_string = string_copy(keyboard_string, 1, name_max_chars);
		
			// disallow dobule specials
			if (!allow_double_specials && string_length(keyboard_string) >= 2){
				var _last_char = string_char_at(keyboard_string, string_length(keyboard_string));
				var _second_to_last_char =  string_char_at(keyboard_string, string_length(keyboard_string)-1);
				if (string_has_char(allowed_special, _last_char) && string_has_char(allowed_special, _second_to_last_char)){
					keyboard_string = string_copy(keyboard_string, 1, string_length(keyboard_string)-1);
				}
			}
		
			// disallow starting with special
			if (!allow_starting_with_special && string_has_char(allowed_special, string_char_at(keyboard_string, 1))){
				keyboard_string = string_copy(keyboard_string, 2,  string_length(keyboard_string)-1);
			}
	
			for (var i = 0; i < string_length(keyboard_string); i++){
				var _index = i+1;
				var _char = string_char_at(keyboard_string, _index);
				var _char_legal = string_has_char(allowed_chars, _char);
				if (!_char_legal){
					keyboard_string = string_delete(keyboard_string, _index, 1);
					i--;
				} else {
					letter_count += string_has_char(allowed_letters, _char);
					num_count += string_has_char(allowed_numbers, _char);
					special_count += string_has_char(allowed_special, _char);
				}
			}
		}
	
		// zoom new letter for a moment
		if (string_length(keyboard_string) > string_length(keyboard_string_prev)){
			last_letter_timer = last_letter_timer_max;
			snd_play_key();
		}
	
		// backspace sound
		if (string_length(keyboard_string) < string_length(keyboard_string_prev)){
			snd_play_key(true);
		}
	
	
		if (string_length(keyboard_string) < string_length(keyboard_string_prev)){
			last_letter_timer = 0;
		}
	
		keyboard_string_prev = keyboard_string;
		name = keyboard_string;
		input_name_validate(name);
	
		if (keyboard_check_pressed(vk_enter) && name_zoom_offset == 0){
		
			if (input_name_validate(name)){
				input_lettershake = 10;
				last_letter_timer = 0;
				___state_change("transition_to_icon_selection");
				___sound_menu_select();
			} else {
				___play_sfx(___snd_bumper, 0.08, 2.2 + random(0.01));
				input_error_show = true;
				input_error_shake = input_error_shake_max;
				input_error_msg = input_error_msg_queued;
			}
		}
	
	
		ee_check();
	}
}

//----------------------------------------------------------------------------------

//----------------------------------------------------------------------------------
if (state == "hide_loader"){
	loader_scale = max(0, loader_scale - (1/10));
	if (loader_scale <= 0){
		___state_change("success");
	}
	loader_dir += 30;
}

//----------------------------------------------------------------------------------

//----------------------------------------------------------------------------------
if (state == "transition_to_icon_selection"){
	if (state_begin){
		ee_show = false;
		cursor_flash_timer = 0;
		draw_input_prompt = false;
		isd_draw_scrollbar = true;
		confirmation_alpha = 0;
		icon_selection_draw_enabled = false;
		icon_selection_scale = 0;
	}
	
	
	if (substate == 0){
		if (input_lettershake <= 0) ___substate_change(substate+1);
	}
	
	if (substate == 1){
		
		if (substate_begin){
			icon_selection_scale_done = false;
			icon_selection_draw_enabled = true;
			icon_selection_scale = 0;
			isd_show_prompt = true;
			isd_prompt_alpha = 0;
			___play_sfx(___snd_swoosh, 0.1);
		}
		var _offset_tar = -210;
		input_y_offset = ___smooth_move(input_y_offset, _offset_tar, 2, 5);
		
		// scale up icon box
		if (!icon_selection_scale_done && input_y_offset == _offset_tar){
			icon_selection_scale = -lengthdir_y(1.05, icon_selection_scale_dir);
			icon_selection_scale_dir += isd_scale_speed;
			if (icon_selection_scale_dir > 90 && icon_selection_scale <= 1){
				icon_selection_scale = 1;
				icon_selection_scale_dir = 0;
				icon_selection_scale_done = true;
				
			}
		}
		
		isd_prompt_alpha = min(1, icon_selection_scale);
		
		if (input_y_offset == _offset_tar && icon_selection_scale_done) ___state_change("icon_selection");
	}
	
}

//----------------------------------------------------------------------------------

//----------------------------------------------------------------------------------
if (state == "icon_selection"){
	if (state_begin){
		isd_cursor_enabled = true;
		confirm_icon_alpha = 0;
		confirmation_alpha = 0;
		draw_confirm_menu = false;
		input_y_offset = -210;
		icon_selection_draw_enabled = true;
		
		isd_prompt_alpha = 1;
		isd_show_prompt = true
		confirm_score_alpha = 0;
		icon_selection_scale = 1;
		
		button_guide_frame = 7;
		button_guide_show = true;
	}
	

	// wait for input
	if (substate == 0){
		
		if (_key_back_pressed){
			___state_change("entry");
			backfade_alpha = 1;
			___sound_menu_back();
		}
		
		
		if (KEY_PRIMARY_PRESSED || keyboard_check_pressed(vk_enter)){
			isd_confirmed = true;
			___substate_change(substate+1);
			___sound_menu_select();
			isd_cursor_enabled = false;
			icon_selection_scale = 1;
			icon_selection_scale_dir = 115;
			icon_selection_scale_done = false;
			icon_selection_scale_done = false;
		}
	}
	
	// close icon selection menu
	if (substate == 1){
		
		if (!icon_selection_scale_done){
			
			icon_selection_scale = -lengthdir_y(1.05, icon_selection_scale_dir);
			isd_prompt_alpha = max(0, isd_prompt_alpha - (1/10));
			icon_selection_scale_dir -= isd_scale_speed;
			if (icon_selection_scale_dir <= 0){
				icon_selection_scale = 0;
				icon_selection_draw_enabled = false;
				icon_selection_scale_done = true;
				isd_prompt_alpha = 0;
				isd_show_prompt = false;
				score_string = string(score_int);
				while (string_length(score_string) < 4) score_string = "0" + score_string;
				___play_sfx(___snd_swoosh, 0.1, 0.8);
				___substate_change(substate+1);
			}
		}
		
	}
	
	// bring name back down
	if (substate == 2){
		confirm_icon_alpha = min(1, confirm_icon_alpha + (1/10));
		confirmation_alpha = confirm_icon_alpha;
		confirm_score_alpha = confirm_icon_alpha;
		draw_confirm_menu = true;
		var _tar = -130;
		input_y_offset = ___smooth_move(input_y_offset, _tar, 1, 5);
		
		if (input_y_offset = _tar && confirm_icon_alpha >= 1){
			___state_change("confirmation_screen");
		}
	}
	
	
}

//----------------------------------------------------------------------------------

//----------------------------------------------------------------------------------
if (state == "confirmation_screen"){
	
	if (state_begin){
		confirm_menu_navigation_enabled = true;
		confirm_menu_confirmed = false;
		confirm_cursor = 0;
		close_circle_prog = 1;
		button_guide_frame = 6;
		button_guide_show = true;
	}
	
	if (substate == 0){
		
		// back button
		if (_key_back_pressed){
			___state_change("icon_selection");
			backfade_alpha = 1;
			___sound_menu_back();
		}
		
		// confirm button
		if (KEY_PRIMARY_PRESSED || keyboard_check_pressed(vk_enter)){
			confirm_menu_navigation_enabled = false;
			if (confirm_cursor == 1){
				redo_info();
			} else {
				confirm_menu_confirmed = true;
				___sound_menu_select();
				wait = 0;
				___substate_change(substate+1);
				button_guide_show = false;
			}
			confirm_menu_confirmed = false;
		}
	}
		
	// wait
	if (substate == 1){
		wait--;
		if (wait <= 0) ___substate_change(substate+1);
	}
		
	// close circle
	if (substate == 2){
		close_circle_prog = max(0, close_circle_prog - (1/20));
		if (close_circle_prog <= 0){
			
			wait = 20;
			
			___substate_change(substate+1);
		}
	}
	
	// wait, remove menus
	if (substate == 3){
		if (substate_begin){
			draw_confirm_menu = false;
			draw_input_box = false;
		}
		if (wait <= 0){
			close_circle_prog = 1;
			___state_change("submit");
		}
		wait--;
	}
		

}

//----------------------------------------------------------------------------------

//----------------------------------------------------------------------------------
if (state == "submit"){
	if (state_begin){
		sbmt_scr();
		retries = max_retries;
		request_time = request_time_max;
		loader_scale = 0;
		loader_scale_done = false;
		loader_scale_dir = 0;
		button_guide_show = false;
	}
	
	show_loader_timer = max(0, show_loader_timer - 1);
	if (show_loader_timer <= 0){
		button_guide_show = true;
		
		if (!loader_scale_done){
			loader_scale = -lengthdir_y(1.1, loader_scale_dir);
			loader_scale_dir += 5;
			if (loader_scale_dir > 90 && loader_scale <= 1){
				loader_scale_done = true;
				loader_scale = 1;
			}
		}
	}
	
	var _loader_speed = 5 + abs(lengthdir_y(12, loader_dir_speed_dir));
	loader_dir_speed_dir += 2;
	if (loader_dir_speed_dir >= 360) loader_dir_speed_dir -= 360;
	loader_dir += _loader_speed;
	
	if (request_time <= 0){
		request_time = request_time_max;
		if (retries <= 0){
			throw_http_error("server is not responding");
		} else {
			sbmt_scr();
		}
		retries -= 1;
	}
	request_time--;
	
	if (submission_successful){
		___state_change("hide_loader");
	}

}

//----------------------------------------------------------------------------------

//----------------------------------------------------------------------------------
if (state == "error_screen"){
	if (state_begin){
		http_error_show = true;
		http_error_menu_confirmed = false;
		http_error_menu_cursor = 0;
		button_guide_frame = 3;
		button_guide_show = true;
		http_error_menu_y_offset = http_error_menu_y_offset_max;
	}
	
	http_error_menu_y_offset = ___smooth_move(http_error_menu_y_offset, 0, 1, 5);
	
	// navigate menu
	if (!http_error_menu_confirmed){
		var _vmove = ___menu_sign_timed_input_vertical(-KEY_UP + KEY_DOWN);
		var _store_pos = http_error_menu_cursor;
		http_error_menu_cursor += _vmove;
		if (http_error_menu_cursor > array_length(http_error_menu)-1) http_error_menu_cursor = 0;
		if (http_error_menu_cursor < 0) http_error_menu_cursor = array_length(http_error_menu)-1;
		if (_store_pos != http_error_menu_cursor){
			___sound_menu_tick_vertical();
		}
		if (KEY_PRIMARY){
			http_error_menu_confirmed = true;
			http_error_show = false;
			___sound_menu_select();
		}
	} else {
		if (http_error_alpha <= 0){
			var _action = variable_struct_get(http_error_menu[http_error_menu_cursor], "action");
			_action();
		}
	}
}

//----------------------------------------------------------------------------------
// exit confirmation
//----------------------------------------------------------------------------------
if (state == "exit_confirmation"){
	if (state_begin){
		ec_show = true;
		ec_menu_y_offset = ec_menu_y_offset_max;
		ec_menu_confirmed = false;
		button_guide_frame = 3;
		if (state_previous == "error_screen") button_guide_frame = 6;
		button_guide_show = true;
		ec_menu_cursor = 0;
		draw_input_prompt = false;
		draw_input_box = false;
		ec_shake = ec_shake_max;
	}
	
	ec_menu_y_offset = ___smooth_move(ec_menu_y_offset, 0, 0.5, 5);
	
	// back button
	if (_key_back_pressed){
		ec_shake = ec_shake_max;
		___sound_menu_back();
		
		if (state_previous == "error_screen"){
			___state_change(state_previous);
			backfade_alpha = 1;
			ec_show = false;
			ec_alpha = 0;
			___sound_menu_back();
		}
	}
	
	// navigate menu
	if (!ec_menu_confirmed){
		var _vmove = ___menu_sign_timed_input_vertical(-KEY_UP + KEY_DOWN);
		var _store_pos = ec_menu_cursor;
		ec_menu_cursor += _vmove;
		if (ec_menu_cursor > array_length(ec_menu)-1) ec_menu_cursor = 0;
		if (ec_menu_cursor < 0) ec_menu_cursor = array_length(ec_menu)-1;
		if (_store_pos != ec_menu_cursor){
			___sound_menu_tick_vertical();
		}
		if (KEY_PRIMARY){
			ec_menu_confirmed = true;
			ec_show = false;
			___sound_menu_select();
		}
	} else {
		
		if (ec_alpha <= 0){
			ec_menu_confirmed = false;
			var _action = variable_struct_get(ec_menu[ec_menu_cursor], "action");
			_action();
		}
	}
}
//----------------------------------------------------------------------------------
// exit menu
//----------------------------------------------------------------------------------
if (state == "exit_menu"){
	if (state_begin){
		close_circle_prog = 1;
		button_guide_show = false;
		wait = 40;
	}
	close_circle_prog = max(0, close_circle_prog - (1/20));
	if (close_circle_prog <= 0) wait--;
	
	if (wait <= 0){
		room_goto(exit_goto_room);
		exit_goto_object = instance_create_layer(0, 0, layer, exit_goto_object);
		exit_goto_object.skip_intro = true;
		if (song_id != noone && audio_is_playing(song_id)) audio_stop_sound(song_id);
		instance_destroy();
	}
}

//----------------------------------------------------------------------------------
// icon menu navigation
//----------------------------------------------------------------------------------
if (isd_cursor_enabled){
	
	var _store_cursor_index = isd_cursor_index ;
	
	isd_scroll_y_target = -((max(isd_cursor_ypos-4, 0) * (isd_icon_size_with_sep)));
	isd_scroll_y = ___smooth_move(isd_scroll_y, isd_scroll_y_target, 0.5, 3)
	isd_cursor_bounce_rad = max(0, isd_cursor_bounce_rad - 1);
	
	
	var _hmove = (-KEY_LEFT + KEY_RIGHT);
	var _vmove = (-KEY_UP + KEY_DOWN);
	if (!abs(_hmove) && !abs(_vmove)) isd_cursor_bounce_dir = -1;
	_hmove =  ___menu_sign_timed_input_horizontal(_hmove);
	_vmove =  ___menu_sign_timed_input_vertical(_vmove);
	
	var _current_line_icon_count = min(isd_icon_count - (isd_cursor_ypos * isd_icons_per_row), isd_icons_per_row);
	

	isd_cursor_xpos += _hmove;
	isd_cursor_ypos += _vmove;
	var _tmp_index = (isd_cursor_ypos * isd_icons_per_row) + (isd_cursor_xpos);
	
	var _is_rebounding = false;
	
	// attempting to out of bounds left
	if (isd_cursor_xpos < 0 && isd_cursor_bounce_dir != 180){
		 _is_rebounding = true;
		isd_cursor_bounce_dir = 180;
	}
	// attempting to out of bounds right 
	if (isd_cursor_xpos >= _current_line_icon_count && _tmp_index <= isd_icon_count  && isd_cursor_bounce_dir != 0){
		_is_rebounding = true;
		isd_cursor_bounce_dir = 0;
	}
	
	// attempting to out of bounds up
	if (isd_cursor_ypos < 0 && isd_cursor_bounce_dir != 90){
		_is_rebounding = true;
		isd_cursor_bounce_dir = 90;
	}
	// attempting to out of bounds down
	if (isd_cursor_ypos >= isd_line_count && isd_cursor_bounce_dir != 270){
		_is_rebounding = true;
		isd_cursor_bounce_dir = 270;
	}

	
	if (_is_rebounding){
		isd_cursor_bounce_rad = isd_cursor_bounce_rad_max;
		___play_sfx(___snd_bumper, 0.04, 2.2 + random(0.01));
	}
	
	isd_cursor_xpos = clamp(isd_cursor_xpos, 0, _current_line_icon_count-1)
	
	
	if (isd_cursor_ypos < 0) isd_cursor_ypos = 0;
	if (isd_cursor_ypos >= isd_line_count) isd_cursor_ypos = isd_line_count-1 ;

	isd_cursor_index = (isd_cursor_ypos * isd_icons_per_row) + isd_cursor_xpos;
	isd_cursor_index = min(isd_cursor_index, isd_icon_count-1);
	
	
	var _isd_cursor_display_x_target = isd_sep + (isd_cursor_xpos * isd_icon_size_with_sep);
	var _isd_cursor_display_y_target = isd_sep + (isd_cursor_ypos * isd_icon_size_with_sep);
	var _cursor_div = 1.5;
	var _cursor_min = 1;
	isd_cursor_display_x = ___smooth_move(isd_cursor_display_x, _isd_cursor_display_x_target, _cursor_min, _cursor_div);
	isd_cursor_display_y = ___smooth_move(isd_cursor_display_y, _isd_cursor_display_y_target, _cursor_min, _cursor_div);
	
	if (isd_cursor_index != _store_cursor_index){
		___sound_menu_tick_vertical();
	}
	
}

//----------------------------------------------------------------------------------

//----------------------------------------------------------------------------------
if (state == "success"){
	if (state_begin){
		___sound_menu_success();
		ss_menu_offset = ss_menu_offset_max;
		ss_menu_confirmed = false;
		ss_menu_cursor = 0;
		ss_show = true;
	}
	
	ss_menu_offset = ___smooth_move(ss_menu_offset, 0, 0.5, 5);
	if (!ss_title_scale_done){
		
		ss_title_scale = abs(lengthdir_y(1.1, ss_title_scale_dir));
		ss_title_scale_dir += 15;
		if (ss_title_scale <= 1 && ss_title_scale_dir > 90){
			ss_title_scale_done = true;
			ss_title_scale = 1;
		}
	}
	
	if (!ss_menu_confirmed){
		var _vmove = ___menu_sign_timed_input_vertical(-KEY_UP + KEY_DOWN);
		var _store_pos = ss_menu_cursor;
		ss_menu_cursor += _vmove;
		if (ss_menu_cursor > array_length(ss_menu)-1) ss_menu_cursor = 0;
		if (ss_menu_cursor < 0) ss_menu_cursor = array_length(ss_menu)-1;
		if (_store_pos != ss_menu_cursor){
			___sound_menu_tick_vertical();
		}
		if (KEY_PRIMARY_PRESSED){
			ss_menu_confirmed = true;
			var _action = variable_struct_get(ss_menu[ss_menu_cursor], "action");
			_action();
			___sound_menu_select();
		}
	} 


}


//----------------------------------------------------------------------------------

//----------------------------------------------------------------------------------
if (confirm_menu_navigation_enabled){
	var _store_cursor = confirm_cursor;
	var _vmove =  ___menu_sign_timed_input_vertical(-KEY_UP + KEY_DOWN);
	var _men_len = array_length(confirm_menu);
	confirm_cursor += _vmove;
	if (confirm_cursor >= _men_len) confirm_cursor -= _men_len;
	if (confirm_cursor < 0) confirm_cursor += _men_len;
	if (_store_cursor != confirm_cursor){
		___sound_menu_tick_vertical();
	}
	
}

//----------------------------------------------------------------------------------

//----------------------------------------------------------------------------------
input_prompt_alpha = ___toggle_fade(input_prompt_alpha, draw_input_prompt, 5);
input_lettershake = max(0, input_lettershake - 1);
ee_alpha = ___toggle_fade(ee_alpha,  ee_show, 6);
backfade_alpha = max(0, backfade_alpha - (1/backfade_alpha_time));
confirm_menu_y_target = (draw_confirm_menu) ? confirm_menu_y_show : confirm_menu_y_hidden;
confirm_menu_y = ___smooth_move(confirm_menu_y, confirm_menu_y_target, 2, 5);
input_error_shake = max(input_error_shake - 1, 0);
input_error_alpha = ___toggle_fade(input_error_alpha,  input_error_show, 5);
http_error_alpha = ___toggle_fade(http_error_alpha,  http_error_show, 10);
http_error_shake_timer = max(0, http_error_shake_timer - 1);
ec_alpha = ___toggle_fade(ec_alpha, ec_show, 10);
ec_shake = max(0, ec_shake-1);
button_guide_alpha = ___toggle_fade(button_guide_alpha, button_guide_show, 24);
ss_alpha = ___toggle_fade(ss_alpha, ss_show, 10);
