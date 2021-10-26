___state_handler();
step++;

if (intro_first_game_switch) && (gallery_mode || TEST_MODE_ACTIVE){
	intro_first_game_switch = false;
}


if (state =="dev_test"){
	
	//games_until_next_diff_up_max = 1;
	//games_until_next_diff_up = games_until_next_diff_up_max;
	//___global.difficulty_level = 5;
	//tsd_draw_diff = DIFFICULTY;
	//___state_change("game_switch");
}

// --------------------------------------------------------------------------------
// fade bg in/out
// --------------------------------------------------------------------------------

df_bg_alpha = ___toggle_fade(df_bg_alpha, df_bg_show, 20);
dd_bg_alpha = ___toggle_fade(dd_bg_alpha, dd_bg_show, 5);


// --------------------------------------------------------------------------------
// fade timer bar
// --------------------------------------------------------------------------------
if (gbo_timerbar_visible) gbo_timerbar_alpha = min(1, gbo_timerbar_alpha + gbo_timerbar_fadespeed);
else gbo_timerbar_alpha = max(0, gbo_timerbar_alpha - gbo_timerbar_fadespeed);

// --------------------------------------------------------------------------------
// handle transition music
// --------------------------------------------------------------------------------
if (transition_music_began && !audio_is_playing(transition_music_current)){
	if (!TEST_MODE_ACTIVE && !gallery_mode){
			var _sound = ___sng_microgame_winlose_end;
			if (transition_difficulty_up){
				_sound = ___sng_zandy_difficulty_up;
				df_bg_show = true;
				dft_play();
				transition_difficulty_up = false;
				gb_shake = 15;
			}
			
			transition_music_current  = ___play_song(_sound,  VOL_MSC * VOL_MASTER, false);
			transition_music_began = false;
			audio_sound_pitch(transition_music_current, transition_speed);
	}
}


// --------------------------------------------------------------------------------
// difficulty up text
// --------------------------------------------------------------------------------
if (dft_state > -1){
	
	// wait 
	if (dft_state == 0){
		dft_wait--;
		if (dft_wait <= 0){
			dft_wait = 30;
			dft_state++;
			tsd_draw_diff = DIFFICULTY;
			tsd_shake_timer = dft_shake_max;
			
		}
	}
	
	// slide in
	if (dft_state == 1){
		dft_x = ___smooth_move(dft_x, dft_x_center, 1, 5);
		if (dft_x >= dft_x_center){
			dft_shake = dft_shake_max / transition_speed;
			dft_state++;
		}
	}
	
	// shake and wait
	if (dft_state == 2){
		if (dft_wait <= 0){
			dft_shake = 0;
			dft_state++;
		}
		dft_wait--;
		dft_shake = max(0, dft_shake-1);
	}
	
	// slide out
	if (dft_state == 3){
		dft_scale_hard = max(0, dft_scale_hard - ((1/10) * transition_speed));
		if (dft_scale_hard <= 0) dft_state = -1;

	}
	
}

// -----------------------------------------------------------
// show life lost animation
// -----------------------------------------------------------
if (heart_show_lose_seq){

	if (heart_begin){
		
		if (transition_difficulty_down){
			transition_difficulty_down = false;
			dd_bg_show = true;
			
		}
		
		heart_begin = false;
		gb_show = true;
		
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
		heart_wait = 20 / transition_speed;
		heart_y = heart_y_lose;
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
		tsd_draw_diff = DIFFICULTY;
		if (dd_trigger_shake_diff_down){
			tsd_shake_timer = tsd_shake_max;
			dd_trigger_shake_diff_down = false;
		}
	}
	
	// heart fade
	var _heart_fade_speed = (1/10) * transition_speed;
	if (heart_alpha_done && heart_last_frame >= sprite_get_number(___spr_life_lose) -1){
		heart_alpha = max(0, heart_alpha - _heart_fade_speed);
		heart_scale = heart_alpha;
	} else {
		heart_alpha = min(1, heart_alpha + _heart_fade_speed);
	}
		
	if (heart_wait <= 0){
		heart_show_lose_seq = false;
	}
	if (heart_alpha <= 0 &&  heart_alpha_done) heart_wait--;
	
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
		wait = 25 / transition_speed;
		gb_show = true;
		gb_scale = intro_gb_scale_start;
		gb_spin = 0;
		intro_y = intro_y_start;
		intro_first_game_switch = true;
		___play_song(___sng_zandy_arcade_intro,  VOL_MSC * VOL_MASTER, false);
	}
	
	// rising spin
	if (substate == 0){
		var _prog = (intro_y - intro_y_start) / (intro_y_target - intro_y_start);
		
		gb_spin = (360 * 4) * (min(1, _prog+(0.05)));
		//show_message(step);
		intro_y = ___smooth_move(intro_y, intro_y_target, 1, 19);
		if (wait <= 0){
			wait = 30;
			___substate_change(substate+1);
			gb_spin = 0;
		}
		
		if (intro_y == intro_y_target) wait--;
		gb_y_offset = intro_y;
		
		// shake
		var _shake_below_diff_of = 7;
		var _diff = abs(intro_y - intro_y_target);
		if (_diff <= _shake_below_diff_of){
			var _sv = (_shake_below_diff_of - _diff)/4;
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
	var _stop_at_dir = 180*3;
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
		
		if (!TEST_MODE_ACTIVE && !gallery_mode && !microgame_won){
			life = max(0, life-1);
		}
		
		gb_show = true;
		var _sound = (microgame_won) ? ___sng_microgame_win : ___sng_microgame_lose;
		
		if (!TEST_MODE_ACTIVE){
			if (microgame_won || life > 0){
				transition_music_current  = ___play_song(_sound,  VOL_MSC * VOL_MASTER, 0);
				transition_music_began = true;
				audio_sound_pitch(transition_music_current, transition_speed);
			}
		}
		wait = 30 / transition_speed;
	}
	
	if (wait <= 0){
		if (TEST_MODE_ACTIVE){ 
			microgame_start(microgame_next_name);
			___state_change("playing_microgame"); 
			exit;
		} else {
			if (!gallery_mode && !microgame_won){
				heart_show_lose_seq = true;
				heart_begin = true;
				gb_slot_is_empty = true;

			}
			if (life <= 0){ 
				___state_change("outro");
			} else {
				___state_change("game_switch");
			}
			exit;
		}
	}
	
	wait--;
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
		gb_show = true;
		gb_scale = gb_scale_max;
		gb_spin = 0;
		gb_y_offset = 0;
		gb_cover_cartridge = false;
		gb_spin_speed = 9 * transition_speed;
		cart_angle = 0;
		cart_x = 81;
		cart_y = 109;
		tsd_show = true;
	}
	
	// zoom out gameboy - - - - - - - - - - - - - - - - - - - - - - - - 
	if (substate == 0){
		
		var _min = 0.005;
		var _div = 5;
		if (intro_first_game_switch){
			//_min = 1;
			_div = 4;
		}
		gb_scale = ___smooth_move(gb_scale, gb_scale_min, _min, _div);
		if (gb_scale <= gb_scale_min){
			gb_scale = gb_scale_min;
			___substate_change(substate+1);
			
			exit;
		}
	}
	
	// flip the gameboy - - - - - - - - - - - - - - - - - - - - - - - - 
	if (substate == 1){
		
		if (substate_begin){
			wait = 10 / transition_speed;
		}
		var _max_spin = (!gallery_mode) ? 180 : 360;

		if (wait <= 0){
			gb_spin = min(gb_spin + gb_spin_speed, _max_spin);
			if (gb_spin >= _max_spin){
				___substate_change(substate+1);
				if (gallery_mode) ___substate_change(8);
			}
		}
		wait--;
		if (gallery_mode) title_alpha = min(1, title_alpha + (1/20));
	}
	
	// wait a sec
	if (substate == 2){
		if (substate_begin){
			dd_bg_show = false;
			wait = 18 / transition_speed;
		}
		if (wait <= 0) ___substate_change(substate+1);
		wait --;
	}
	
	// eject old cart - - - - - - - - - - - - - - - - - - - - - - - - 
	if (substate == 3){
		if (substate_begin){
			cart_vsp = -10;
			cart_scale = 1;
			cart_out_perform_bounce = false;
			if (!gb_slot_is_empty){
				cart_show = true;
				sfx_play(___snd_cart_remove, 1, 0);
				cart_out_perform_bounce = true;
			}
			gb_store_y_offset = gb_y_offset;
			gb_slot_is_empty = true;
			gb_cover_cartridge = true;
			snapback_dir = 250;
			snapback_rad = 3;
			gb_cart_eject_speed = transition_speed;
			if (intro_first_game_switch){
				gb_cart_eject_speed *= 1.25;
			}

		}
		
		var _grav = 0.75 * gb_cart_eject_speed;
		var _grav_max = 100 * gb_cart_eject_speed;
		var _cart_scale_max = 1.05;
		
		cart_y += cart_vsp;
		cart_vsp = min(cart_vsp + _grav, _grav_max);
		
		if (cart_out_perform_bounce) gb_y_offset =  lengthdir_y(snapback_rad, snapback_dir);
		snapback_dir += 10 * gb_cart_eject_speed;
		snapback_rad = max(0, snapback_rad - (3/10));

		if (cart_vsp > 0){
			gb_cover_cartridge = false;
			cart_angle += (cart_vsp/10) * gb_cart_eject_speed;
			if (cart_scale < _cart_scale_max) cart_scale += (0.0025 * gb_cart_eject_speed);
		}
		
		if (cart_y >= 320){
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
			cart_show = true;
		}
		
		cart_x = ___smooth_move(cart_x, cart_in_slot_x, 0.5, 7.5);
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
			cart_vsp = 0.2;
			wait = 40 / transition_speed;	
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
		if (snapback_rad <= 0 && wait <= 0){
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
			wait = 20;
			if (intro_first_game_switch) wait = 0;
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
			//if (gallery_mode && !gallery_first_pass) title_alpha = 0;
			title_fade_time = 10 / transition_speed;
			wait = 30 / transition_speed;
			larold_index = 1;
			if (df_bg_show) gb_shake = 10;
		}
		
		if (df_bg_show && wait <= 15) gb_shake = 1;
		
		if (gallery_mode && wait > 0) title_alpha = min(1, title_alpha + ((1/10)*transition_speed));
		if (wait <= 0) title_alpha = max(0, title_alpha - (1/title_fade_time));
		
		if (title_alpha < 0.5){
			tsd_show = false;
		}
		
		if (title_alpha <= 0){
			gb_scale = ___smooth_move(gb_scale, gb_scale_max, 0.01, 8);
		}
		if (gb_scale >= gb_scale_max){
			df_bg_show = false;
			df_bg_alpha = 0;
			dd_bg_show = false;
			dd_bg_alpha = 0;
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
			intro_first_game_switch = false;
			microgame_start(microgame_next_name);
			___state_change("playing_microgame");
			exit;
		}
		
		if (prompt_scale_done) wait--;
		
	}
	
}

// --------------------------------------------------------------------------------
// STATE | OUTRO
// --------------------------------------------------------------------------------
if (state == "outro"){
	
	if (state_begin){
		gb_show = true;
		gb_scale = gb_scale_max;
		gb_spin = 0;
		gb_y_offset = 0;
		gb_cover_cartridge = false;
		gb_spin_speed = 9 * transition_speed;
		ou_draw_games = true;
		df_bg_show = false;
		df_bg_alpha = 0;
		dd_bg_show = false;
		dd_bg_alpha = 0;
		
	}
	
	// zoom out gameboy - - - - - - - - - - - - - - - - - - - - - - - - 
	if (substate == 0){
		var _min = 0.005;
		var _div = 5;
		if (intro_first_game_switch){
			//_min = 1;
			_div = 4;
		}
		gb_scale = ___smooth_move(gb_scale, gb_scale_min, _min, _div);
		if (gb_scale <= gb_scale_min){
			gb_scale = gb_scale_min;
			//gb_show = false;
			//ou_gameboy_swing_show = true;
			___substate_change(substate+1);
			;
			exit;
		}
	}
	
	// wait for heart sequence to finish - - - - - - - - - - - - - - - -
	if (substate == 1){
		if (heart_show_lose_seq && heart_sound_played) ___substate_change(substate+1);
	}
	
	// spin Y - - - - - - - - - - - - - - - - - - - - - - - -
	if (substate == 2){
		if (substate_begin){
			sfx_play(___snd_glass_crack, 1, false);
			ou_gameboy_y_is_spinning = true;
			ou_flash = 0.5;
			gb_shake = 5;
		}

		var _max_spin = 300;
		gb_y_offset += 0.5;
		//ou_gameboy_y_angle = min(ou_gameboy_y_angle + ou_gameboy_angle_speed, _max_spin);
		ou_gameboy_y_angle = ___smooth_move(ou_gameboy_y_angle, _max_spin, 20, 5);
		//ou_gameboy_angle_speed = max(ou_gameboy_angle_speed - 0.5, 0);
		if (ou_gameboy_y_angle >= _max_spin){
			___substate_change(substate+1);
			___play_sfx(___snd_gameboy_drop, 0.8);
			
		}
		
	}

	// shake - - - - - - - - - - - - - - - - - - - - - - - -
	if (substate == 3){
		if (substate_begin){
			wait = 0;
			gb_shake = 10;
			ou_draw_scorebox = true;
		}
		if (wait <= 0){	
			___substate_change(substate+1);
		}
		wait--;

	}
	
	if (!ou_scorebox_larold_scale_done && ou_draw_scorebox){
			ou_scorebox_larold_scale = -lengthdir_y(1.2, ou_scorebox_larold_scale_dir);
			ou_scorebox_larold_scale_dir += 10;
			if (ou_scorebox_larold_scale <= 1 && ou_scorebox_larold_scale_dir > 90){
				ou_scorebox_larold_scale = 1;
				ou_scorebox_larold_scale_done = true;
			}
	}

	
	// shake gameboy then fall - - - - - - - - - - - - - - - - 
	
	// bring in games (and larold
	if (substate == 4){
		if (substate_begin){
			
			wait = 10;
		}
		

		
		ou_games_global_rad = ___smooth_move(ou_games_global_rad, ou_games_global_rad_target_1, 0.5, 18);
		//var _prog = ((ou_games_global_rad-100)/50)
		//ou_games_global_scale = 1 + (3 * _prog);
		
		if (ou_games_global_rad <= ou_games_global_rad_target_1){
			wait--;
			ou_games_global_scale = 1;
			ou_games_global_rad = ou_games_global_rad_target_1;
			if (wait <= 0) ___substate_change(substate+1);
		}
		
	}
	
	// shoot games at center
	if (substate == 5){
		
		var _all_done = true;
		
		for (var i = 0; i < array_length(played_record); i++){
			
			with(played_record[i]){
				
				if (state < 3) _all_done = false;
				
				// wait
				if (state == 0){
					if (wait <= 0){
						state++;
						wait = 20;
					}
					
					wait = max(0, wait-1);
					
					
				}
				// shake
				if (state == 1){
					pullback = 0;
					if (wait <= 0){
						___play_sfx(___snd_cartzip, 0.1 + random(0.1), /* 1.15 + random(0.25)*/other.ou_pitch_shift + 0.15 + random(0.25), false);
						state++;
					}
					wait = max(0, wait-1);
				}
				// shoot
				if (state == 2){
					spd = min(8, spd + 1);
					dist -= spd;
					if (abs(dist) > other.ou_games_global_rad){
						dist = -other.ou_games_global_rad;
						other.ou_scorebox_scale_mod = other.ou_scorebox_scale_mod_max;
						other.ou_score_display += points;
						other.ou_flash = random(0.02);
						other.ou_scorebox_larold_shake = 2;
						___play_sfx(___snd_cart_insert, 0.6 + random(0.1), /*0.9 + random(0.2)*/other.ou_pitch_shift + random_range(-0.1,0.1), false, 100);
						state++;
					}
				}
			}
		}
		
		
		if (_all_done){
			___substate_change(substate+1);
			wait = 20;
			
		}
	}
	
	// wait 
	if (substate == 6){
		wait--;
		if (wait <= 0) ___substate_change(substate+1);
	}
	
	// score rise
	if (substate == 7){
		if (substate_begin){
			ou_draw_games = false;
			___play_sfx(___snd_score_pulse_1)
		}
		var _tar = -60;
		ou_scorebox_y_offset = ___smooth_move(ou_scorebox_y_offset, _tar, 0.5, 12);
		if (ou_scorebox_y_offset <= _tar){
			wait = 10;
			 ___substate_change(substate+1);
		}
	}
	
	// wait
	if (substate == 8){
		wait--;
		if (wait <= 0) ___substate_change(substate+1);
	}
	
	// shake
	if (substate == 9){
		var _time = 60;
		var _max_alpha = 0.5;
		if (substate_begin){
			___play_sfx(___snd_score_powerup)
			ou_scorebox_larold_shake = _time;
		}
		ou_scorebox_larold_scale += 0.01;
		gb_shake = 1;
		if (ou_scorebox_larold_scale >= 1.25) ou_light_alpha = min(ou_light_alpha + (_max_alpha/_time), _max_alpha);
		if (ou_light_alpha >= _max_alpha){
			___play_sfx(___snd_score_pop);
			ou_light_alpha = 1;
			wait = 60*2;
			ou_draw_games = false;
			ou_draw_scorebox = false;
			gb_show = false;
			___substate_change(substate+1);
		}
	}
	
	// wait
	if (substate == 10){
		wait--;
		if (wait <= 0) ___substate_change(substate+1);
	}
	
	// fade in light
	if (substate == 11){
		if (substate_begin){
			
			___state_change("end_screen");

		}
		
	}
	
}

// --------------------------------------------------------------------------------
// STATE | END SCREEN
// --------------------------------------------------------------------------------
if (state == "end_screen"){
	
	if (state_begin){
		ec_show = false;
		es_draw = true;
		pause_enabled = false;
		if (!es_score_saved){
			load_local_scores();
			add_score_to_board_local(ou_score_display);
			___store_score_for_submission(ou_score_display);
			es_score_saved = true;
		}
		var _sng = (es_score_in_scoreboard) ? ___sng_zandy_foo : ___sng_zandy_foo_lose;
		if (es_song_id != noone && audio_is_playing(es_song_id)){
			audio_sound_gain(es_song_id, 1, 250);
		} else {
			es_song_id = ___play_song(_sng, 1, true);
		}
		es_menu_confirmed = false;
		button_guide_frame = 3;
		button_guide_show = true;
	}
	
	// fade in
	if (substate == 0){
		
		ou_light_alpha = max(0, ou_light_alpha - (1/40));
	
		// move cursor
		var _menu_len = array_length(es_menu);
		var _v_move = ___menu_sign_timed_input_vertical(-KEY_UP + KEY_DOWN);
		var _store_pos = es_menu_cursor;
		es_menu_cursor += _v_move;
		if (es_menu_cursor >= _menu_len) es_menu_cursor = 0;
		if (es_menu_cursor < 0) es_menu_cursor = _menu_len - 1;
		if (es_menu_cursor != _store_pos){
			___sound_menu_tick_vertical();
		}

		if (KEY_PRIMARY_PRESSED){
			___sound_menu_select();
			es_menu_confirmed = true;
			___substate_change(substate+1);
		}
	
	}
	
	//// fade out music
	//if (substate == 1){
	//	var _time = 30;
	//	if (substate_begin){
	//		audio_sound_gain(es_song_id, 0, (_time/60)*1000);
	//		wait = 10;
	//	}
	//	es_close_circle_prog = max(0, es_close_circle_prog - (1/_time));
	//	if (es_close_circle_prog <= 0) wait--;
		
	//	if (wait <= 0){
	//		___substate_change(substate+1);
	//	}
	//}
	
	// perform menu action
	if (substate == 1){
		if (substate_begin){
			var _selection = es_menu[es_menu_cursor];
			_selection.action();
		}
	}
}

//----------------------------------------------------------------------------------
// exit to submit screen
//---------------------------------------------------------------------------------
if (state == "exit_transition"){
		var _time = 30;
		
		if (state_begin){
			audio_sound_gain(es_song_id, 0, (_time/60)*1000);
			wait = 10;
			es_close_circle_prog = 1;
			button_guide_show = false;
		}
		
		es_close_circle_prog = max(0, es_close_circle_prog - (1/_time));
		if (es_close_circle_prog <= 0) wait--;
		
		if (wait <= 0){
			
			workspace_end();
			room_goto(___rm_main_menu);
			application_surface_draw_enable(true);
			if (es_exit_to == "submit"){
				instance_create_layer(0, 0, layer, ___obj_name_entry);
			} else if (es_exit_to == "main_menu"){
				with(instance_create_layer(0, 0, layer, ___obj_main_menu)) skip_intro = true;
			}
			instance_destroy();
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
		ec_menu_cursor = 0;
		ec_shake = ec_shake_max;
		es_draw = false;
		ec_menu_cursor = 0;
		audio_sound_gain(es_song_id, 0, 100);
		___sound_menu_error();
		button_guide_frame = 6;
		button_guide_show = true;
	}
	
	ec_menu_y_offset = ___smooth_move(ec_menu_y_offset, 0, 0.5, 5);
	
	// back button
	if (KEY_SECONDARY_PRESSED || keyboard_check_pressed(vk_escape)){
		ec_action_0();
		___sound_menu_back();
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
		if (KEY_PRIMARY_PRESSED){
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



if (ou_draw_games){
	ou_games_dir += 0.2;
	ou_games_global_rad_dir += 6;
	ou_scorebox_larold_shake = max(ou_scorebox_larold_shake-1, 0);
	ou_scorebox_scale_mod = max(0, ou_scorebox_scale_mod - (ou_scorebox_scale_mod_max/6));
}





// flash  - - - - - - - - - - - - - - - - - - - - - - - -
if (ou_flash > 0){
	ou_flash = max(0, ou_flash - (1/6));
}

ec_alpha = ___toggle_fade(ec_alpha, ec_show, 10);
ec_shake = max(0, ec_shake-1);
es_menu_fade = max(0, es_menu_fade - (1/15));
button_guide_alpha = ___toggle_fade(button_guide_alpha, button_guide_show, 24);
tsd_alpha = ___smooth_move(tsd_alpha, tsd_show, 0.03, 7);
tsd_shake_timer = max(0, tsd_shake_timer-1);
particle_fire_move();
