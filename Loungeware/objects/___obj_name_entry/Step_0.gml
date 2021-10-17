if (keyboard_check_pressed(vk_space)){
		

	var _url = ___BASE_URL + "/loungeware_leaderboard/get_scores.php";
	//post_id = http_get(_url);
}


if (!CONFIG_IS_SHIPPING && keyboard_check_pressed(ord("R"))){
	instance_create_depth(0, 0, depth, object_index);
	instance_destroy();
}

___state_handler();

var _key_back_pressed = (KEY_SECONDARY_PRESSED || keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_backspace));


var _input_fade_time = 5;
input_prompt_alpha = (draw_input_prompt)? min(1, input_prompt_alpha + (1/_input_fade_time)) : max(0, input_prompt_alpha - (1/_input_fade_time));




if (state == "entry"){
	
	if (state_begin){
		draw_input_box = true;
		draw_input_prompt = true;
		input_text_col = c_gbwhite;
		input_y_offset = 0;
		icon_selection_draw_enabled = false;
		icon_selection_scale = 0;
		ignore_next_key_input_timer = 10;
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
	
	if (keyboard_check_pressed(vk_enter)){
		
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

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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

		
	}
	

	// wait for input
	if (substate == 0){
		
		if (_key_back_pressed){
			___state_change("entry");
			backfade_alpha = 1;
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

if (state == "confirmation_screen"){
	
	if (state_begin){
		confirm_menu_navigation_enabled = true;
		confirm_cursor = 0;
	}
	
	if (substate == 0){
		
		var _goback = function(){
			___state_change("icon_selection");
			backfade_alpha = 1;
		}
		
		// back button
		if (_key_back_pressed){
			_goback();
		}
		
		// confirm button
		if (KEY_PRIMARY_PRESSED || keyboard_check_pressed(vk_enter)){
			confirm_menu_navigation_enabled = false;
			if (confirm_cursor == 1){
				_goback();
			} else {
				confirm_menu_confirmed = true;
				confirm_shake_time = 15;
				___sound_menu_select();
				wait = 20;
				___substate_change(substate+1);
			}
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
			___substate_change(substate+1);
		}
		wait--;
	}
	
	// show loader, wait for response
	if (substate == 4){
		if (substate_begin){

			// send score
			// begin a timer, if no response in recieved before timer runs out, go to timeout page
		}
	}
		

}




// icon menu navigation
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

input_lettershake = max(0, input_lettershake - 1);

ee_alpha = toggle_fade(ee_alpha,  ee_show, 6);
backfade_alpha = max(0, backfade_alpha - (1/backfade_alpha_time));


confirm_menu_y_target = (draw_confirm_menu) ? confirm_menu_y_show : confirm_menu_y_hidden;
confirm_menu_y = ___smooth_move(confirm_menu_y, confirm_menu_y_target, 2, 5);
input_error_shake = max(input_error_shake - 1, 0);
input_error_alpha = toggle_fade(input_error_alpha,  input_error_show, 5);