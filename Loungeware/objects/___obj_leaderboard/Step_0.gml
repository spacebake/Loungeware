

___state_handler();

// exit
if (button_guide_show){
	var _key_exit = KEY_SECONDARY_PRESSED || keyboard_check_pressed(vk_escape);
	
	if (_key_exit){
		exit_leaderboard();
	}
}

if (state == "error_screen"){
	if (state_begin){
		http_error_show = true;
		http_error_menu_confirmed = false;
		http_error_menu_cursor = 0;
		http_error_menu_y_offset = http_error_menu_y_offset_max;
		button_guide_show = true;
		button_guide_frame = 3;

	}
	
	http_error_menu_y_offset = ___smooth_move(http_error_menu_y_offset, 0, 1, 5);
	
	// navigate menu
	if (!http_error_menu_confirmed){
		var _store_pos = http_error_menu_cursor;
		var _vmove = ___menu_sign_timed_input_vertical(-KEY_UP + KEY_DOWN);
		http_error_menu_cursor += _vmove;
		if (http_error_menu_cursor > array_length(http_error_menu) - 1) http_error_menu_cursor = 0;
		if (http_error_menu_cursor < 0) http_error_menu_cursor = array_length(http_error_menu)-1;
	
		if (_store_pos != http_error_menu_cursor){
			___sound_menu_tick_vertical();
		}
	}
	
	if (KEY_PRIMARY_PRESSED){
		http_error_menu_confirmed = true;
		___sound_menu_select();
		var _action = variable_struct_get(http_error_menu[http_error_menu_cursor], "action");
		_action();
		http_error_show = false;
	}
}

if (state == "load"){
	if (state_begin){
		get_scores();
		retries = max_retries;
		request_time = request_time_max;
		loader_scale = 0;
		loader_scale_done = false;
		loader_scale_dir = 0;
		button_guide_show = true;
		button_guide_frame = 8;
		
		//if (false){
		//	throw_http_error("ONLINE FEATURES ARE CURRENTLY ONLY AVAILABLE\nIN THE WINDOWS VERSION OF THE GAME, SORRY.");
		//	array_delete(http_error_menu, 0, 1);
		//	var _str = http_error_menu[0];
		//	_str.text = "RETURN";
		//	exit;
		//}
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
			___state_change("error_screen");
		} else {
			get_scores();
		}
		retries -= 1;
	}
	request_time--;
}

if (state == "hide_loader"){
	loader_scale = max(0, loader_scale - (1/10));
	if (loader_scale <= 0){
		___state_change("board_display");
	}
	loader_dir += 30;
}

if (state == "board_display"){
	if (state_begin){
		show_board = true;
		button_guide_show = true;
		button_guide_frame = 8;
		if (HTML_MODE) button_guide_frame = 9;
		if (song_id != noone && audio_is_playing(song_id)) audio_stop_sound(song_id);
		song_id = ___play_song(___sng_zandy_bakunova);
	}
	

	
	// scale bounce effect
	for (var i = 0; i < array_length(leaderboard_data); i++){
		var _this = leaderboard_data[i];
		if (!_this.scale_done) _this.scale_wait = max(0, _this.scale_wait - 1);
		if (_this.scale_wait <= 0 && !_this.scale_done){
			
			_this.scale =  -lengthdir_y(1.2, _this.scale_dir);
			_this.scale_dir += 5;
			
			if (_this.scale <= 1 && _this.scale_dir > 90){
				_this.scale_done = true;
				_this.scale_dir = 0;
				_this.scale = 1;
				
				_this.scale_wait = _this.scale_wait_max;
			}
		}
	}
	
	
	// scrolling
	if (scrolling_enabled){
		

		var _vmove = ___menu_sign_timed_input_vertical((KEY_UP + -KEY_DOWN));
		
		var _mouse_wheel_move = -mouse_wheel_down() + mouse_wheel_up();
		if (!HTML_MODE && _mouse_wheel_move != 0){
			_vmove = _mouse_wheel_move;
		}

		scroll_offset_target += (score_height_minor*5) * _vmove;
		if (scroll_offset_target > 0){
			scroll_offset_target = 0;
		}
		if (scroll_offset_target < -scroll_max){
			scroll_offset_target = -(scroll_max);
		}
		scroll_offset = ___smooth_move(scroll_offset, scroll_offset_target, 0.5, 3);
	}
}

if (state == "exit_leaderboard"){

	if (state_begin){
		wait = 40;
		audio_sound_gain(song_id, 0, 60);
	}
	close_circle_prog = max(0, close_circle_prog - (1/20));
	
	if (close_circle_prog <= 0) wait--;
	
	if (wait <= 0){
		room_goto(exit_goto_room);
		instance_create_layer(0, 0, layer, exit_goto_object);
		if (exit_goto_object == ___obj_main_menu) ___obj_main_menu.skip_intro = true;
		if (song_id != noone && audio_is_playing(song_id)) audio_stop_sound(song_id);
		instance_destroy();
	}
}



button_guide_alpha = ___toggle_fade(button_guide_alpha, button_guide_show, 24);
http_error_alpha = ___toggle_fade(http_error_alpha, http_error_show, 10);
http_error_shake_timer = max(0, http_error_shake_timer - 1);
arrow_float_dir += 5;
if (arrow_float_dir >= 360) arrow_float_dir -= 360;
latest_arrow_dir += 10;
if (latest_arrow_dir >= 360) latest_arrow_dir -= 360;