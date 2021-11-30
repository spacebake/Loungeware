___state_handler();

// play the second part of song when intro finishes
if (sng_index == ___snd_gtr_intro && !audio_is_playing(sng_id)){
	main_menu_theme_play(true);
}

// whether or not to skip the intro song
// didnt use track position because of html bug
if (step <= 0){
	if (skip_intro){
		if (logo_disable_zoom_intro) logo_shake_timer = 10;
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
	if (wait <= 0 && menu_y != menu_y_target){
		menu_y = ___smooth_move(menu_y, menu_y_target, 0.5, 8);
	}
	
	if (menu_y == menu_y_target){
		menu_active = true;
		show_button_prompt = true;
		bg_show = true;
	}
	
	// move cursor
	if (!menu_confirmed && menu_active){
		var _menu_len = array_length(menu);
		var _store_pos = cursor;
		var _v_move = ___menu_sign_timed_input_vertical(-KEY_UP + KEY_DOWN);
		cursor += _v_move;
		if (cursor < 0) cursor = _menu_len-1;
		if (cursor >= _menu_len) cursor = 0;
		if (_store_pos != cursor){
			___sound_menu_tick_vertical();
		}
	}
	
	// check for confirm
	var _confirm = (KEY_PRIMARY_PRESSED || ___KEY_PAUSE_PRESSED) && (menu_active);
	if (_confirm){
		if (menu[cursor].action != ___noop){
			// stop sound
			if (sng_id != noone) audio_sound_gain(sng_id, 0, 200);
			// play snd
			menu_confirmed = true;
			___sound_menu_select();
			___state_change("fadeout");
		} else {
			___play_sfx(___snd_bumper, 0.5, 2);
		}
		
	}
	wait = max(0, wait-1);
}

//------------------------------------------------------------------------------------------
// STATE | FADEOUT
//------------------------------------------------------------------------------------------
if (state == "fadeout"){
	
	if (menu[cursor].text == "EXIT" && goodbye_played == false){
		goodbye_played = true;
		var _snd_index  = ___snd_goodbye;
		var _snd_id = audio_play_sound(_snd_index, 0, 0);
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
		menu[cursor].action();
		main_menu_theme_stop();
		instance_destroy();
	}
}


if (!logo_disable_zoom_intro && skip_intro && !logo_scale_done){
	logo_scale = abs(lengthdir_y(1.1, logo_scale_dir));
	logo_scale_dir += 5;
	if (logo_scale_dir > 90 && logo_scale <= 1){
		logo_scale = 1;
		logo_scale_done = true;
	}
}


logo_shake_timer = max(0, logo_shake_timer-1);
if (bg_show) bg_scale = ___smooth_move(bg_scale, 1, 0.001, 40);
button_prompt_alpha = ___toggle_fade(button_prompt_alpha, show_button_prompt, 20);
step++;

