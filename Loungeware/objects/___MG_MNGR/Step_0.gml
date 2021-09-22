___state_handler();
step++;

// fade timer bar
if (gbo_timerbar_visible) gbo_timerbar_alpha = min(1, gbo_timerbar_alpha + gbo_timerbar_fadespeed);
else gbo_timerbar_alpha = max(0, gbo_timerbar_alpha - gbo_timerbar_fadespeed);

// handle transition music
if (transition_music_began && !audio_is_playing(transition_music_current)){
	if (!TEST_MODE_ACTIVE && !gallery_mode){
			var _sound = ___sng_microgame_winlose_end;
			transition_music_current  = ___play_song(_sound,  VOL_MSC * VOL_MASTER, false);
			transition_music_began = false;
			audio_sound_pitch(transition_music_current, transition_speed);
	}
}

// --------------------------------------------------------------------------------
// STATE | CART PREVIEW
// --------------------------------------------------------------------------------
if (state == "cart_preview"){
	if (state_begin){
		audio_stop_all();
		cart_float_dir = 0;
	}
	cart_float_dir += 2.5;
	if (cart_float_dir >= 360) cart_float_dir -= 360;
}

// -----------------------------------------------------------
// STATE | intro
// -----------------------------------------------------------
// gameboy zooms up from below the game view, spinning. Then zooms into scale 1
if (state == "intro"){
	
	if (state_begin){
		intro_y_start = (VIEW_H / 2) + 64;
		wait = 30 / transition_speed;
		gb_show = true;
		gb_scale = intro_gb_scale_start;
		gb_spin = 0;
		intro_y = intro_y_start;
		___play_song(___sng_zandy_arcade_intro,  VOL_MSC * VOL_MASTER, false);
	}
	
	// rising spin
	if (substate == 0){
		var _prog = (intro_y - intro_y_start) / (intro_y_target - intro_y_start);
		gb_spin = (360 * 5) * (min(1, _prog+(0.03)));
		intro_y = ___smooth_move(intro_y, intro_y_target, 1, 20);
		if (wait <= 0){
			wait = 30;
			___substate_change(substate+1);
			gb_spin = 0;
		}
		
		if (intro_y == intro_y_target) wait--;
		gb_y_offset = intro_y;
		
		// shake
		if (abs(intro_y - intro_y_target) <= 3){
			var _sv = 1;
			gb_y_offset += random_range(-_sv, _sv);
			gb_x_offset = random_range(-_sv, _sv);
		}
	}
	
	// zoom to scale 1
	if (substate == 1){
		if (substate_begin){
			gb_x_offset = 0;
			gb_y_offset = intro_y;
		}
		
		gb_scale = ___smooth_move(gb_scale, intro_gb_scale_end, 0.01, 6);
		var _prog = (gb_scale - intro_gb_scale_start) / (intro_gb_scale_end - intro_gb_scale_start);
		gb_y_offset = intro_y * (1-_prog);
		
		if (gb_scale >= 1){
			if (wait <= 0){
				___state_change("intro_hearts");
			}
			wait--;
		}
	}
}

// -----------------------------------------------------------
// STATE | intro_hearts
// -----------------------------------------------------------
if (state == "intro_hearts"){
	
	// bring in hearts
	if (state_begin){
		gb_show = true;
		gb_scale = 1;
		heart_dir = 0;
		heart_alpha = 0;
		heart_alpha_done = false;
		heart_scale = 0;
		heart_last_frame = 0;
		heart_image_speed = 0.3 * transition_speed;
		heart_dance_dir = 0;
		
	}
	
	heart_dir += 5 * transition_speed;
		
	// hearts pop-in animtion
	if (!heart_alpha_done){
		heart_scale = -lengthdir_y(1.1, heart_dir);
		if (heart_dir > 90) && (heart_scale <= 1){
			heart_alpha_done = true;
			heart_scale = 1;
		}
	} else {
		var _sway_speed = 7;
		heart_dance_dir += _sway_speed * transition_speed;
	}
	
	// heart fade out animation
	var _heart_fade_speed = (1/15) * transition_speed;
	var _stop_at_dir = 180*4;
	if (heart_alpha_done && heart_dance_dir >= _stop_at_dir){
		heart_dance_dir = 9000;
		heart_alpha = max(0, heart_alpha - _heart_fade_speed);
		heart_scale = heart_alpha;
		if (heart_alpha <= 0){
			___state_change("game_switch");
		}
	} else {
		heart_alpha = min(1, heart_alpha + _heart_fade_speed);
	}
	
}

// -----------------------------------------------------------
// STATE | MICROGAME RESULT
// -----------------------------------------------------------
if (state == "microgame_result"){
	
	if (state_begin){
		gb_show = true;
		var _sound = (microgame_won) ? ___sng_microgame_win : ___sng_microgame_lose;
		if (!TEST_MODE_ACTIVE){
			transition_music_current  = ___play_song(_sound,  VOL_MSC * VOL_MASTER, 0);
			transition_music_began = true;
			audio_sound_pitch(transition_music_current, transition_speed);
		}
		wait = 30 / transition_speed;
	}
	
	if (wait <= 0){
		if (TEST_MODE_ACTIVE){ 
			microgame_start(microgame_next_name);
			___state_change("playing_microgame"); 
			exit;
		} else {
			var _state_goto = (microgame_won || gallery_mode) ? "game_switch" : "life_lose";
			___state_change(_state_goto);
			exit;
		}
	}
	
	wait--;
}

// -----------------------------------------------------------
// STATE | LIFE_LOSE
// -----------------------------------------------------------
if (state == "life_lose"){

	if (state_begin){
		gb_show = true;
		life = max(0, life-1);
		heart_dir = 0;
		heart_alpha = 0;
		heart_alpha_done = false;
		heart_scale = 0;
		heart_last_frame = 0;
		heart_image_speed = 0.3 * transition_speed;
		heart_shake_timer_max = 30 / transition_speed;
		heart_shake_timer = heart_shake_timer_max;
		heart_sound_played = false;
		heart_hover_speed = 5;
		wait = 20 / transition_speed;
	}
	
	// hover heart
	heart_dir += (heart_hover_speed * transition_speed);
	
	// hearts pop-in animtion
	if (!heart_alpha_done){
		heart_scale = -lengthdir_y(1.1, heart_dir);
		if (heart_dir > 90) && (heart_scale <= 1){
			heart_alpha_done = true;
			heart_scale = 1;
		}
	} else { 
	// hearts shake after pop-in
		if (heart_shake_timer <= 0) heart_last_frame = min(heart_last_frame + heart_image_speed, sprite_get_number(___spr_life_lose)-1);
		heart_shake_timer = max(0, heart_shake_timer - transition_speed);
	}
	
	// play sound when exploding heart reaches frame 4
	if (heart_last_frame >= 4 && !heart_sound_played){
		heart_sound_played = true;
		sfx_play(___snd_microgame_heart_pop, 1, 0);
	}
	
	// heart fade
	var _heart_fade_speed = (1/10) * transition_speed;
	if (heart_alpha_done && heart_last_frame >= sprite_get_number(___spr_life_lose) -1){
		heart_alpha = max(0, heart_alpha - _heart_fade_speed);
		heart_scale = heart_alpha;
	} else {
		heart_alpha = min(1, heart_alpha + _heart_fade_speed);
	}
		
	if (wait <= 0){
		___state_change("game_switch");
	}
	if (heart_alpha <= 0 &&  heart_alpha_done) wait--;
	
}

// -----------------------------------------------------------
// STATE | PLAYING_MICROGAME
// -----------------------------------------------------------
if (state == "playing_microgame"){
	
	if (state_begin){
		gbo_timerbar_visible = true;
		transition_circle_rad = 0;
		prompt_alpha = 1;
		prompt_sprite = ___prompt_sprite_create(prompt);
		substate = 0;
	}
	
	// animate circle intro
	if (substate == 0){
		transition_circle_rad = min(transition_circle_rad_max, transition_circle_rad + (transition_circle_speed*2));
		if (transition_circle_rad >= transition_circle_rad_max){
			___substate_change(substate+1);
			exit;
		}
	}
	
	if (substate == 1){
		if (microgame_timer <= 0 || microgame_timer_skip){
			
			if (!microgame_won){
				larold_index = 2;
			} else {
				larold_index = 1;
			}
		
			if (!microgame_music_auto_stopped){
				microgame_music_auto_stopped = true;
				audio_pause_all();
				audio_resume_sound(microgame_music);
				var _fadeout_time = (transition_end_microgame_time/2);
				microgame_music_stop(_fadeout_time * 16.66);
			}
			gbo_timerbar_visible = false;
			larold_alpha = 1;//; - gbo_timerbar_alpha;
			// pixelate
			transition_appsurf_zoomscale = max(0.1, transition_appsurf_zoomscale - (1/transition_end_microgame_time));
			// close circle animation (loony tunes am i right)
			transition_circle_rad = max(0, transition_circle_rad - transition_circle_speed);
			
			if ((transition_circle_rad <= 0) && (gbo_timerbar_alpha <= 0)){
				___state_change("microgame_result");
				microgame_end();
			
			}
		}
	}
	
	microgame_timer = max(microgame_timer - 1, 0);
	
}


// --------------------------------------------------------------------------------
// STATE | GAME SWITCH TRANSITION 
// --------------------------------------------------------------------------------
if (state == "game_switch"){
	
	
	if (state_begin){
		//if (games_played > 0 && games_played mod 3 == 0) show_message(DIFF UP!);
		gb_show = true;
		gb_scale = gb_scale_max;
		gb_spin = 0;
		gb_y_offset = 0;
		gb_cover_cartridge = false;
		cart_angle = 0;
		cart_x = 81;
		cart_y = 109;
		gb_spin_speed = 9 * transition_speed;
		
		if (intro_first_game_switch && !gallery_mode && !TEST_MODE_ACTIVE){
			intro_first_game_switch = false;
		}
	}
	
	// zoom out gameboy - - - - - - - - - - - - - - - - - - - - - - - - 
	if (substate == 0){
		gb_scale = ___smooth_move(gb_scale, gb_scale_min, 0.005, 5);
		if (gb_scale <= gb_scale_min){
			gb_scale = gb_scale_min;
			___substate_change(substate+1);
			exit;
		}
	}
	
	// flip the gameboy - - - - - - - - - - - - - - - - - - - - - - - - 
	if (substate == 1){
		
		if (substate_begin) wait = 0 / transition_speed;
		var _max_spin = (!gallery_mode) ? 180 : 360;

		if (wait <= 0){
			gb_spin = min(gb_spin + gb_spin_speed, _max_spin);
			if (gb_spin >= _max_spin){
				___substate_change(substate+2);
				if (gallery_mode) ___substate_change(8);
			}
		}
		wait--;
	}
	
	// substate 2 no longer needed, goes straight from 1 to 3
	
	// eject old cart - - - - - - - - - - - - - - - - - - - - - - - - 
	if (substate == 3){
		if (substate_begin){
			cart_vsp = -10;
			cart_scale = 1;
			cart_show = true;
			gb_store_y_offset = gb_y_offset;
			gb_slot_is_empty = true;
			gb_cover_cartridge = true;
			snapback_dir = 250;
			snapback_rad = 3;
			sfx_play(___snd_cart_remove, 1, 0);
		}
		
		var _grav = 0.75 * transition_speed;
		var _grav_max = 100 * transition_speed;
		var _cart_scale_max = 1.05;
		
		cart_y += cart_vsp;
		cart_vsp = min(cart_vsp + _grav, _grav_max);
		
		gb_y_offset =  lengthdir_y(snapback_rad, snapback_dir);
		snapback_dir += 10 * transition_speed;
		snapback_rad = max(0, snapback_rad - (3/10));

		if (cart_vsp > 0){
			gb_cover_cartridge = false;
			cart_angle += (cart_vsp/10) * transition_speed;
			if (cart_scale < _cart_scale_max) cart_scale += (0.0025 * transition_speed);
		}
		
		if (cart_y >= 270){
			gb_y_offset = 0;
			___substate_change(substate+1);
			exit;
		}
	}
	
	// slide in new game from right - - - - - - - - - - - - - - - - - - 
	if (substate == 4){
		if (substate_begin){
			cart_change(microgame_next_metadata);
			cart_x = cart_offscreen_x;
			cart_y = cart_offscreen_y;
			cart_angle = 0;
			cart_scale = 1;
		}
		
		cart_x = ___smooth_move(cart_x, cart_in_slot_x, 0.5, 9);
		if (cart_x == cart_in_slot_x){
			___substate_change(substate+1);
			exit;
		}
	}
	
	// wait, then move down - - - - - - - - - - - - - - - - - - - - - 
	if (substate == 5){

		if (substate_begin){
			gb_scale = gb_scale_min;
			gb_cover_cartridge = true;
			gb_spin = 180;
			gb_slot_is_empty = true;
			cart_x = cart_in_slot_x;
			cart_y = cart_offscreen_y;
			cart_show = true;
			cart_scale = 1;
			cart_vsp = 0.5;
			wait = 20 / transition_speed;	
		}
		
		if (wait <= 0){
			cart_y += cart_vsp * transition_speed;
			cart_vsp = min(8, cart_vsp * (1.3)) * transition_speed;
			if (cart_y + cart_vsp >= cart_in_slot_y){
				gb_slot_is_empty = false;
				cart_vsp = 0;
				___substate_change(substate+1);
				exit;
			}
		}
		
		var _fall_dist_max = (cart_in_slot_y - cart_offscreen_y);
		var _fall_dist_current = (cart_y - cart_offscreen_y);
		title_alpha = _fall_dist_current / _fall_dist_max;
		wait--;
	}
	
	// catch cart / bounce - - - - - - - - - - - - - - - - - - - - - 
	if (substate == 6){
		if (substate_begin){
			gb_scale = gb_scale_min;
			gb_cover_cartridge = false;
			gb_slot_is_empty = false;
			cart_show = false;
			title_alpha = 1;
			snapback_dir = 250;
			snapback_rad = 5;
			sfx_play(___snd_cart_insert, 1, 0);
			
		}
		
		var _snapback_dir_speed = 10;
		var _snapback_rad_reduction_speed = 0.3;
		gb_y_offset = lengthdir_y(snapback_rad, snapback_dir);
		snapback_dir += _snapback_dir_speed  * transition_speed;
		snapback_rad = max(0, snapback_rad - (_snapback_rad_reduction_speed  * transition_speed));
		if (snapback_rad <= 0){
			gb_y_offset = 0;
			___substate_change(substate+1);
			exit;
		}
	}
	
	// spin back - - - - - - - - - - - - - - - - - - - - - - - - - - 
	if (substate == 7){
		if (substate_begin){
			gb_scale = 0.4;
			gb_x_offset = 0;
			gb_y_offset = 0;
			title_alpha = 1;
			wait = 30;
		}
		
		if (wait <= 0) gb_spin += gb_spin_speed;
		wait--;
		
		if (gb_spin >= 360){
			gb_spin = 0;
			___substate_change(substate+1);
			exit;
		}
	}
	
	// zoom back in - - - - - - - - - - - - - - - - - - - - - - -
	if (substate == 8){
		
		if (substate_begin){
			title_alpha = 1;
			if (gallery_mode && !gallery_first_pass) title_alpha = 0;
			title_fade_time = 10 / transition_speed;
			wait = 10 / transition_speed;
			larold_index = 1;
		}
		
		if (gallery_mode && wait > 0) title_alpha = min(1, title_alpha + ((1/10)*transition_speed));
		if (wait <= 0) title_alpha = max(0, title_alpha - (1/title_fade_time));
		
		if (title_alpha <= 0) gb_scale = ___smooth_move(gb_scale, gb_scale_max, 0.01, 8);
		if (gb_scale >= gb_scale_max){
			___substate_change(substate+1);
			exit;
		}
		wait--;
		
	}
	
	// draw prompt and reflection - - - - - - - - - - - - - - - -
	if (substate == 9){
		if (substate_begin){
			prompt_timer = prompt_timer_max;
			prompt_scale_dir = 45;
			prompt_scale = 0;
			prompt_scale_done = false;
			prompt = microgame_get_prompt(microgame_next_name);
			prompt_sprite = ___prompt_sprite_create(prompt);
			wait = 5/transition_speed;
		}
		
		if (wait <= 0){
			gallery_first_pass = false;
			gb_show = false;
			title_alpha = 0;
			cart_show = false;
			gb_cover_cartridge = false;
			microgame_start(microgame_next_name);
			___state_change("playing_microgame");
			exit;
		}
		
		if (prompt_scale_done) wait--;
		
	}
	
}

