// play the second part of song when intro finishes
if (sng_index == ___snd_gtr_intro && !audio_is_playing(sng_id)){
	main_menu_theme_play(true);
}

// whether or not to skip the intro song
// didnt use track position because of html bug
if (step <= 0){
	if (skip_intro){
		main_menu_theme_play(true);
		wait = 0;
	} else {
		main_menu_theme_play(false);
	}
}

//------------------------------------------------------------------------------------------
// STATE | Begin
//------------------------------------------------------------------------------------------

if (state == "begin"){
	
	// slide in
	var _tar_y = VIEW_H/2;
	if (wait <= 0) menu_y = ___smooth_move(menu_y, _tar_y, 1, 7);
	if (menu_y == _tar_y) menu_active = true;
	
	// move cursor
	var _menu_len = array_length(menu);
	v_move = -KEY_UP + KEY_DOWN;
	if (v_move != last_v_move){
		input_cooldown = 0;
		input_is_scrolling = false;
	}
	last_v_move = v_move;
	if (abs(v_move) && input_cooldown <= 0){
		if (input_is_scrolling){
			input_cooldown = input_cooldown_max;
		} else {
			input_cooldown = input_cooldown_init_max;
			input_is_scrolling = true;
		}
		___sound_menu_tick_vertical();
	} else {
		v_move = 0;
		input_cooldown = max(0, input_cooldown - 1);
	}
	cursor += v_move;
	if (cursor > _menu_len - 1) cursor = 0;
	if (cursor < 0) cursor = _menu_len - 1;
	
	// check for confirm
	var _confirm = (KEY_PRIMARY_PRESSED || ___KEY_PAUSE_PRESSED) && (menu_active);
	if (_confirm){
		if (menu_method[cursor] == noop){
			___noop();
		} else {
			// stop sound
			main_menu_theme_stop();
			
			// play snd
			var _snd_index  = ___snd_cart_insert;
			var _snd_id = ___BUILTIN_AUDIO_PLAY_SOUND(_snd_index, 0, 0);
			var _vol = VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index) * 0.7;
			audio_sound_gain(_snd_id, _vol, 0);
			vsp = 5;
			confirmed = true;
			state = "fadeout";
		}
	}
	wait = max(0, wait-1);
}

//------------------------------------------------------------------------------------------
// STATE | FADEOUT
//------------------------------------------------------------------------------------------
if (state == "fadeout"){
	
	if (menu[cursor] == "EXIT" && goodbye_played == false){
		goodbye_played = true;
		var _snd_index  = ___snd_goodbye;
		var _snd_id = ___BUILTIN_AUDIO_PLAY_SOUND(_snd_index, 0, 0);
		var _vol = VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index) * 0.8;
		audio_sound_gain(_snd_id, _vol, 0);
	}
	
	close_circle_prog = max(0, close_circle_prog - (1/30));
	if (close_wait_before > 0){
		close_wait_before -=1;
	} else {
		if (close_circle_prog <= 0) close_wait--;
	}

	
	if (close_wait <= 0){
		menu_method[cursor]();
		main_menu_theme_stop();
		instance_destroy();
	}
}

step++;