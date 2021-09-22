step++;
shadow_dir += 2.5;
baku_shake = max(0, baku_shake-1);

for (var i = 0; i < array_length(suspects); i++){
	with (suspects[i]){
		shaking = max(0, shaking-1);
	}
}

if (state == "wait"){
	if (wait <= 0){
		state = "move_in";
		wait = time_allowed;
		exit;
	}
	wait = max(wait-1,0);
}

if (state == "move_in"){
	var _done_count = 0;
	for (var i = 0; i < array_length(suspects); i++){
		with (suspects[i]){
			x = other.smooth_move(x, x_goto, 1, 30*((i+1)/10));
			if (x == x_goto){
				if (!shake_set) {
					shaking = 6;
					shake_set = true;
				}
				_done_count++;
			}
		}
	}
	if (_done_count >= array_length(suspects)){
		wait--;
		if (wait <= 0){
			
			state = "fade_to_poster";
		}
	}
}

if (state == "fade_to_poster"){
	fade_alpha = min(1, fade_alpha + (1/20));
	if (fade_alpha >= 1){
		camera_set_view_size(CAMERA, room_width*2, room_height*2);
		show_lineup = false;
		state = "poster_slide";
		fade_alpha = 0;
		show_menu = true;
		wait = 15;
	}
}

if (state == "poster_slide"){
	wait--;
	if (wait <= 0){
		if (hmm_played == false){
			hmm_played = true;
			play_voice(space_ll_snd_hmm);
		}
		poster_y = smooth_move(poster_y, 0, 1, 6);
		if (poster_y == 0){
			state = "choose";
			
		}
	}
	var _max_diff = abs(poster_y_begin);
	poster_prog = 1 - (abs(poster_y)/_max_diff);
}

if (state == "choose"){
	
	exclamation_alpha = min(exclamation_alpha + (1/5), 1);
	var _store_pos = selected;
	var _hmove = -KEY_LEFT_PRESSED + KEY_RIGHT_PRESSED;
	selected += _hmove;
	if (selected > 2) selected = 0;
	if (selected < 0) selected = 2;
	
	if (_store_pos != selected){
		
		sfx_play(space_ll_snd_paper, 1, false);
	}
	
	if (KEY_PRIMARY_PRESSED){
		confirmed = true;
		show_answers = true;
		answershake = 12;
		if (guilty_suspect.card_number == selected+1){
			baku_frame = 1;
			baku_shake = 8;
			state = "selected_correctly";
			microgame_win();
			substate = 0;
			play_voice(space_ll_snd_yes);
			wait = 30;
			exit;
		} else {
			baku_frame = 2;
			baku_shake = 16;
			microgame_music_stop(10);
			voice_playing = play_voice(space_ll_snd_huh);
			wait = 60;
			state = "selected_incorrectly";
			substate = 0;
		}
		
	}
}


if (state == "selected_correctly"){
	
	if (substate == 0){
		wait--;
		if (wait <= 0){
			spr_freezeframe = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), false, false, 0, 0);
			camera_set_view_size(CAMERA, room_width, room_height);
			show_freezeframe = true;
			show_lineup = true;
			show_menu = false;
			suspects = [guilty_suspect];
			guilty_suspect.x_goto = (room_width/3);
			guilty_suspect.x =guilty_suspect.x_goto;
			substate++;
		}
	}

	if (substate == 1){
		fade_alpha = min(1, fade_alpha + (1/10));
		if (fade_alpha >= 1){
			wait = 7;
			substate++;
		}
	}
	
	if (substate == 2){
		wait--;
		if (wait <= 5) guilty_suspect.shaking = 1;
		if (wait <= 0){
			substate++;
			guilty_suspect.image = guilty_suspect.base_image + 4;
			sfx_play(space_ll_snd_gavel, 1, 0);
			wait = 70;
		}
	}
	
	if (substate == 3){
		wait--;
		if (wait <= 20) guilty_suspect.shaking = 1;
		if (wait <= 6) guilty_suspect.shaking = 2;
		if (wait <= 0){
			guilty_suspect.shaking = 0;
			sfx_play(space_ll_snd_gavel, 1, 0);
			//microgame_music_stop(10);
			guilty_suspect.image += 1;
			wait = 30;
			substate++;
		}
	}
	
	if (substate == 4){
		if (wait <= 0){
			substate++;
			wait = 15;
		}
		wait--;
	}
	
	if (substate == 5){
		if (wait <= 0) show_bars = true;
		wait--;
		if (bars_done){
			substate++;
			wait = 60;
		}
	}
	
	if (substate == 6){
		wait--;
		if (wait <= 0) microgame_end_early();
	}
}


if (state == "selected_incorrectly"){
	if (substate == 0){
		wait--;
		if (wait <= 0){
			spr_freezeframe = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), false, false, 0, 0);
			camera_set_view_size(CAMERA, room_width, room_height);
			show_freezeframe = true;
			show_lineup = true;
			show_menu = false;
			suspects = [];
			show_baku_throw = true;
			substate++;
		}
	}
	// fade to interegation room
	if (substate == 1){
		fade_alpha = min(1, fade_alpha + (1/10));
		if (fade_alpha >= 1){
			wait = 7;
			substate++;
		}
	}
	
	if (substate == 2){
		wait--;
		if (wait == 1) sfx_play(space_ll_snd_baku_gasp, 1, false);
		if (wait <= 0){
			var _base_speed = 1/6;
			var _spd = _base_speed;
			if (baku_throw_frame < 17) _spd = _base_speed*2;
			if (baku_throw_frame > 20) _spd = _base_speed*0.75;
			baku_throw_frame = min(baku_throw_frame + _spd, sprite_get_number(space_ll_spr_baku_thrown_alt)-1);
			var _new_frame = baku_throw_frame_prev != floor(baku_throw_frame);
			if (_new_frame && floor(baku_throw_frame) == 17){
				sfx_play(space_ll_snd_gavel, 1.2, false);
				sfx_play(space_ll_snd_baku_land, 1, false);
				screenshake = 10;
			}
			if (_new_frame && floor(baku_throw_frame) == 22){
				//sfx_play(space_ll_snd_sigh, 1, false);
			}
			
			baku_throw_frame_prev = floor(baku_throw_frame);
			if (baku_throw_frame >= sprite_get_number(space_ll_spr_baku_thrown_alt)-1){
				show_bars = true;
			}
			
			if (bars_done){
				wait = 20;
				substate++;
			}
		}
	}
	
	if (substate == 3){
		wait--;
		if (wait <= 0){
			wait = 40;
			substate++;
		}
	}
	
	
	if (substate == 4){
		wait--;
		if (wait <= 0){
			sfx_play(space_ll_snd_sigh, 1, 0);
			baku_throw_frame -= 3;
			substate++;
			wait = 120;
		}
	}
	
	if (substate == 5){
		if (wait <= 0) microgame_end_early();
		wait--;
	}
}


if (show_bars){
	if (!bars_started){
		var _snd = sfx_play(space_ll_snd_prisondoor, 1, false);
		audio_sound_pitch(_snd, 1.05);
		bars_started = true;
		//screenshake = 4;
	}
	bars_x = max(0, bars_x - 6);
	if (bars_x <= 0 && !bars_done){
		bars_done = true;
		screenshake = 10;
	}
}


if (screenshake > 0){
	var _sv = 2;
	bars_shake_x = random_range(-1,1);
	bars_shake_y = random_range(-1,1);
	camera_set_view_pos(CAMERA, random_range(-_sv, _sv), random_range(-_sv, _sv));
	screenshake = max(0, screenshake-1);
	if (screenshake <= 0) camera_set_view_pos(CAMERA, 0, 0);
}  else {
	bars_shake_x = 0;
	bars_shake_y = 0;
}

answershake = max(answershake-1, 0);