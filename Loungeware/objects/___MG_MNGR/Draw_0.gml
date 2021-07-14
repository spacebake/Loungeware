var _gb_w = (sprite_get_width(___spr_gameboy_overlay)) * gb_scale;
var _gb_x_origin_offset = sprite_get_xoffset(___spr_gameboy_overlay) * gb_scale;
var _gb_margin_left =  ((VIEW_W - _gb_w)/2) + _gb_x_origin_offset;
var _gb_margin_top = 200 * (1-gb_scale);
var _gbx = _gb_margin_left + gb_offset_x;
var _gby = _gb_margin_top + gb_offset_y;
var _gmx = _gb_margin_left + cart_offset_x;
var _gmy = _gb_margin_top + cart_offset_y;

// -----------------------------------------------------------
// STATE | intro
// -----------------------------------------------------------
if (state == "intro"){
	if (state_begin){
		gb_scale = 0.25;
		_gb_frame = 0;
		_gb_intro_y_start = VIEW_H + 16;
		_gb_intro_y = _gb_intro_y_start;
		_gb_intro_y_end = (VIEW_H/2) - 32;
		wait = 20;
	}
	
	if (substate == 0){
		//_gby = (140 * (1-gb_scale));
	
		
		var _prog = (_gb_intro_y_start - _gb_intro_y) / (_gb_intro_y_start - _gb_intro_y_end);
		_gb_frame = ((sprite_get_number(___spr_gameboy_spin_x) * 3)+0.99) * _prog;
	
		_gb_intro_y = ___smooth_move(_gb_intro_y, _gb_intro_y_end, 1, 30);
		if (substate == 1){
			gb_scale = min(1, gb_scale + 1/30);
		}
		
		if (wait <= 0) substate++;
		if (_gb_intro_y == _gb_intro_y_end) wait--;
		
		___shader_cartridge_on(microgame_current_metadata);
		draw_sprite_ext(___spr_gameboy_spin_x, _gb_frame, _gbx, _gb_intro_y, gb_scale, gb_scale, 0, c_white, 1);
		___shader_cartridge_off();
	}
	
	if (substate == 1){
		___shader_cartridge_on(microgame_current_metadata);
		draw_sprite_ext(___spr_gameboy_overlay, _gb_frame, _gbx, _gby, gb_scale, gb_scale, 0, c_white, 1);
		___shader_cartridge_off();
		gb_scale = ___smooth_move(gb_scale, 1, 0.01, 10);
		if (gb_scale == 1) ___state_change("xxx");
	}
	//show_message(_gby);
	

	
}



// -----------------------------------------------------------
// STATE | xxx
// -----------------------------------------------------------
if (state == "xxx"){
	if (state_begin){
		_fade_alpha = 0;
		wait = 60;
	}
	
		// move larold
		var _dir_speed = 2.5;
		var _larold_rad = 2;
		larold_dir += _dir_speed;
		var _y_offset_larold = lengthdir_y(_larold_rad, larold_dir);
		var _y_offset_glare = lengthdir_y(_larold_rad * 0.75, larold_dir + 180);
		
		// draw larold
		draw_set_alpha(0.025)
		draw_sprite(___spr_larold_reflection, larold_index, 0, _y_offset_larold);
		
		// draw glare
		draw_set_alpha(0.015)
		draw_sprite(___spr_larold_reflection, 0, 0, _y_offset_glare);
		draw_set_alpha(1);
	
		// draw overlay
		draw_sprite_ext(___spr_gameboy_overlay, 0, 0, 0, 1, 1, 0, c_white, 1);
		
		//draw fade in
		draw_set_alpha(_fade_alpha);
		draw_set_color(c_gbblack);
		draw_rectangle_fix(0, 0, VIEW_W, VIEW_H);
	
	// zoom out gameboy
	if (substate == 0){

		
		if (wait <= 0){
			___state_change("game_switch");
			exit;
		}
		
		_fade_alpha = max(0, _fade_alpha - (1/30));
		if (_fade_alpha <= 0) wait--;
		
	}
	
	
}

// -----------------------------------------------------------
// STATE | MICROGAME RESULT
// -----------------------------------------------------------
if (state == "microgame_result"){
	
	// god bless this mess. will fix it at some point (yeah, right)
	
	if (state_begin){
		transition_music_began = true;
		if (microgame_won){
			if (!dev_mode ||  !___global.test_vars.loop_game){
				transition_music  = audio_play_sound(___sng_microgame_win, 0, 0);
				audio_sound_gain(transition_music , VOL_MSC * VOL_MASTER, 0);
			}
		} else {
			life = max(0, life-1);
			if (!dev_mode ||  !___global.test_vars.loop_game){
				transition_music  = audio_play_sound(___sng_microgame_lose, 0, 0);
				audio_sound_gain(transition_music , VOL_MSC * VOL_MASTER, 0);
			}
		}
		wait = 30;
		life_dir = 0;
		life_alpha = 0;
		life_alpha_done = false;
		life_scale = 0;
		life_last_frame = 0;
		life_image_speed = 0.3;
		life_shake_timer_max = 30;
		life_shake_timer = life_shake_timer_max;
		life_sound_played = false;
	}
	
	// move larold
	var _dir_speed = 2.5;
	var _larold_rad = 2;
	larold_dir += _dir_speed;
	var _y_offset_larold = lengthdir_y(_larold_rad, larold_dir);
	var _y_offset_glare = lengthdir_y(_larold_rad * 0.75, larold_dir + 180);
		
	// draw larold
	draw_set_alpha(0.025)
	draw_sprite(___spr_larold_reflection, larold_index, 0, _y_offset_larold);
		
	// draw glare
	draw_set_alpha(0.015)
	draw_sprite(___spr_larold_reflection, 0, 0, _y_offset_glare);
	draw_set_alpha(1);
	
	// draw overlay
	draw_sprite_ext(___spr_gameboy_overlay, 0, 0, 0, 1, 1, 0, c_white, 1);
	
	if (dev_mode && dev_mode_loop_game){
		
		var _str = (microgame_won ? "WON" : "LOST");
		draw_set_color(c_white);
		draw_set_font(fnt_frogtype);
		draw_set_halign(fa_center);
		draw_text_transformed(VIEW_W/2, 95, _str, 2, 2, 0);
		draw_set_halign(fa_left);
	}
	
	// show larold for a hot second
	if (substate == 0){
		wait--;
		if (wait <= 0){
			if (dev_mode && dev_mode_loop_game){ 
				___microgame_start(microgame_next_name);
				___state_change("playing_microgame"); 
				exit
			}
			if (microgame_won){
				___state_change("game_switch");
				exit;
			} else {
				wait = 20;
				substate++
			}
		}
	}
	
	// draw health screen (this substate is bypassed if microgame was won)
	if (substate == 1){
		// draw life
		life_dir += 5;
		if (!life_alpha_done){
			life_scale = -lengthdir_y(1.1, life_dir);
			if (life_dir > 90) && (life_scale <= 1){
				life_alpha_done = true;
				life_scale = 1;
			}
		} else {
			if (life_shake_timer <= 0) life_last_frame = min(life_last_frame + life_image_speed, sprite_get_number(___spr_life_lose)-1);
			life_shake_timer = max(0, life_shake_timer - 1);
		}
		
		if (life_last_frame >= 4 && !life_sound_played){
			life_sound_played = true;
			sfx_play(___snd_microgame_heart_pop, 1, 0);
		}
		
		var _life_spr = ___spr_life;
		var _life_w = sprite_get_width(_life_spr);
		var _life_y = ((canvas_y + (canvas_h/2)))/2;
		var _margin = 12;
		var _total_w = (_life_w * life_max) + (_margin * (life_max-1));
		var _life_x = ((VIEW_W/2) - (_total_w / 2)) + (_life_w/2);
		
		for (var i = 0; i < life + 1; i++){
			var _y_mod = lengthdir_y(1, life_dir + (i * 40));
			var _alpha = life_alpha;
			var _frame = 0;
			var _sprite = _life_spr;
			if (i == life){ // least heart 
				if (life_shake_timer > 0 && life_alpha_done){
					var _shake_val = (1-(life_shake_timer/life_shake_timer_max)) * 3;
					_life_x += random_range(-_shake_val, _shake_val);
					_life_y += random_range(-_shake_val, _shake_val);
				}
				_frame = life_last_frame; 
				_sprite = ___spr_life_lose;
			}
			draw_sprite_ext(_sprite, _frame, _life_x, _life_y + _y_mod, life_scale, life_scale, 0, c_white, _alpha);
			_life_x += _life_w + _margin;
		}
		
		// draw overlay again because too lazy to fix this
		draw_sprite_ext(___spr_gameboy_overlay, 0, 0, 0, 1, 1, 0, c_white, 1);
		
		if (life_alpha_done && life_last_frame >= sprite_get_number(___spr_life_lose) -1){
			life_alpha = max(0, life_alpha - (1/10));
			life_scale = life_alpha;
		} else {
			life_alpha = min(1, life_alpha + (1/10));
		}
		
		
		if (wait <= 0){

			___state_change("game_switch");
		}
		if (life_alpha <= 0 &&  life_alpha_done) wait--;
	}
	
}

// --------------------------------------------------------------------------------
// STATE | GAME SWITCH TRANSITION (don't judge me)
// --------------------------------------------------------------------------------
if (state == "game_switch"){
	
	var _scale = 0.5;
	
	if (state_begin){
		gb_scale = 1;
		gb_offset_x = 0;
		gb_offset_y = 0;
		cart_offset_x = 0;
		cart_offset_y = 0;
		cart_angle = 0;
		cart_draw_over = false;
		spin_speed = 0.75
		gb_min_scale = 0.4;
		gb_max_scale = 1;
		gb_scale_diff =  gb_max_scale - gb_min_scale;
		title_y = 64;
	}
	

	
	
	// zoom out gameboy
	if (substate == 0){
		
		// draw larold
		var _larold_alpha = (gb_scale - gb_min_scale) / gb_scale_diff;
		draw_surf_larold(_gb_margin_left, _gb_margin_top, canvas_w * gb_scale, canvas_h * gb_scale, _larold_alpha, bm_normal);
		
		// draw gameboy overlay
		var _target_scale = gb_min_scale;
		var _larold_alpha = (gb_scale - _target_scale)/gb_scale_diff;
		
		// draw gameboy
		draw_sprite_ext(___spr_gameboy_overlay, 0, _gb_margin_left, _gb_margin_top, gb_scale, gb_scale, 0, c_white, 1);
		// draw larold reflection
				
		gb_scale = ___smooth_move(gb_scale, _target_scale, 0.0025, 5);
		
		if (gb_scale == _target_scale){
			substate++;
			exit;
		}
	}
	
	// spin 1
	if (substate == 1){
		
		if (substate_begin){
			wait = 15;
			spin_frame = 0;
		}
		
		// draw gameboy
		___shader_cartridge_on(microgame_current_metadata);
		draw_sprite_ext(___spr_gameboy_spin_x, spin_frame, _gb_margin_left, _gb_margin_top, _scale, _scale, 0, c_white, 1);
		___shader_cartridge_off();
		wait--;
		if (wait <= 0){
			var _max_spin_frame = 15;
			spin_frame = min(spin_frame + spin_speed, _max_spin_frame);
			if (spin_frame >= _max_spin_frame){
				substate++;
				exit;
			}
		}
	}
	
	// wait
	if (substate == 2){
		
		if (substate_begin){
			wait = 10;
		}

		draw_sprite_ext(___spr_gameboy_back, 0, _gbx, _gby, _scale, _scale, 0, c_white, 1);
		___shader_cartridge_on(microgame_current_metadata);
		draw_sprite_ext(___spr_gameboy_back, 1, _gmx, _gmy, _scale, _scale, cart_angle, c_white, 1);
		___shader_cartridge_off();
		draw_sprite_ext(___spr_gameboy_back, 2, _gbx, _gby, _scale, _scale, 0, c_white, 1);
		
		if (wait <= 0){
			substate++;	
			exit;
		}

		wait--;
	}
	
	// eject old cart
	if (substate == 3){
		
		if (substate_begin){
			cart_vsp = -11;
			snapback_dir = 250;
			snapback_rad = 3;
			cart_scale = 1;
			sfx_play(___snd_cart_remove, 1, 0);
		}
		
		var _grav = 0.75;
		var _grav_max = 100;
		var _cart_scale_max = 1.05;
		cart_offset_y += cart_vsp;
		cart_vsp = min(cart_vsp + _grav, _grav_max);
		
		gb_offset_y = lengthdir_y(snapback_rad, snapback_dir);
		snapback_dir += 10;
		snapback_rad = max(0, snapback_rad - (3/10));

		if (cart_vsp > 0){
			cart_draw_over = true;
			cart_angle += cart_vsp/10;
			if (cart_scale < _cart_scale_max) cart_scale += 0.0025;
		}
		
		draw_sprite_ext(___spr_gameboy_back, 0, _gbx, _gby, _scale, _scale, 0, c_white, 1);
		if (!cart_draw_over){
			draw_sprite_ext(cart_sprite, 0, _gmx, _gmy, _scale, _scale, cart_angle, c_white, 1);
		}
		draw_sprite_ext(___spr_gameboy_back, 2, _gbx, _gby, _scale, _scale, 0, c_white, 1);
		if (cart_draw_over){
			draw_sprite_ext(cart_sprite, 0, _gmx, _gmy, cart_scale/2, cart_scale/2, cart_angle, c_white, 1);
		}
		
		if (_gmy > VIEW_H + 80){
			substate++;
			exit;
		}
	}
	
	// slide in new game from right
	if (substate == 4){
		if (substate_begin){
			//change cart color
			cart_sprite = ___cart_sprite_create(microgame_next_metadata);
			cart_offset_y = -90;
			cart_offset_x = 190;
			cart_angle = 0;
			cart_vsp = 0;
		}
		cart_offset_x = ___smooth_move(cart_offset_x, 0, 0.5, 10);
		draw_sprite_ext(___spr_gameboy_back, 0, _gbx, _gby, _scale, _scale, 0, c_white, 1);
		draw_sprite_ext(cart_sprite, 0, _gmx, _gmy, _scale, _scale, cart_angle, c_white, 1);
		draw_sprite_ext(___spr_gameboy_back, 2, _gbx, _gby, _scale, _scale, 0, c_white, 1);
		if (cart_offset_x == 0){
			substate++;
			exit;
		}
	}
	
	
	// wait, then move down
	if (substate == 5){
		if (substate_begin){
			wait = 20;
			_store_cart_offset_y = cart_offset_y;
		}
		if (cart_vsp == 0) cart_vsp = 0.5;
		var _title_alpha = 1 - (cart_offset_y / _store_cart_offset_y);
		draw_set_alpha(_title_alpha);
		___draw_title(VIEW_W/2, title_y);
		draw_set_alpha(1);
		draw_sprite_ext(___spr_gameboy_back, 0, _gbx, _gby, _scale, _scale, 0, c_white, 1);
		draw_sprite_ext(cart_sprite, 0, _gmx, _gmy, _scale, _scale, cart_angle, c_white, 1);
		draw_sprite_ext(___spr_gameboy_back, 2, _gbx, _gby, _scale, _scale, 0, c_white, 1);	
		if (wait <= 0){
			cart_offset_y += cart_vsp;
			cart_vsp = min(8, cart_vsp * 1.3);
			if (cart_offset_y + cart_vsp >= 0){
				substate++;
				exit;
			}
		}
		wait--;
	}

	// catch cart / bounce
	if (substate == 6){
		if (substate_begin){
			cart_offset_y = 0;
			snapback_dir = 250;
			snapback_rad = 5;
			sfx_play(___snd_cart_insert, 1, 0);
		}
		gb_offset_y = lengthdir_y(snapback_rad, snapback_dir);
		snapback_dir += 10;
		snapback_rad = max(0, snapback_rad - (5/25));
		___draw_title(VIEW_W/2, title_y);
		___shader_cartridge_on(microgame_next_metadata);
		draw_sprite_ext(___spr_gameboy_back, 3, _gbx, _gby, _scale, _scale, 0, c_white, 1);
		___shader_cartridge_off();
		if (snapback_rad <= 0){
			substate++;
			exit;
		}

	}
	
	// spin back
	if (substate == 7){
		if (substate_begin){
			gb_scale = 0.4;
			gb_offset_x = 0;
			gb_offset_y = 0;
			cart_offset_x = 0;
			cart_offset_y = 0;
		}
		___shader_cartridge_on(microgame_next_metadata);
		draw_sprite_ext(___spr_gameboy_spin_x, spin_frame, _gb_margin_left, _gb_margin_top, _scale, _scale, 0, c_white, 1);
		___shader_cartridge_off();
		___draw_title(VIEW_W/2, title_y);
		spin_frame += spin_speed;
		
		if (spin_frame >= sprite_get_number(___spr_gameboy_spin_x)-1){
			substate++;
			exit;
		}
	}

	// zoom back in
	if (substate == 8){
		
		if (substate_begin){
			title_alpha = 1;
			title_fade_time = 10;
			wait = 60;
			larold_index = 1;
		}
		var _target_scale = gb_max_scale;
		if (wait <= 0) title_alpha = max(0, title_alpha - (1/title_fade_time));
		
		draw_set_alpha(title_alpha);
		___draw_title(VIEW_W/2, title_y);
		draw_set_alpha(1);
		
		// draw larold reflection
		var _larold_alpha = (gb_scale - gb_min_scale) / gb_scale_diff;
		// draw larold
		draw_surf_larold(_gb_margin_left, _gb_margin_top, canvas_w * gb_scale, canvas_h * gb_scale, _larold_alpha, bm_normal);

		// draw gameboy
		draw_sprite_ext(___spr_gameboy_overlay, 0, _gb_margin_left, _gb_margin_top, gb_scale, gb_scale, 0, c_white, 1);
		if (title_alpha <= 0) gb_scale = ___smooth_move(gb_scale, _target_scale, 0.01, 8);
		if (gb_scale >= _target_scale){
			substate++;
			exit;
		}
		wait--;
	}
		
	if (substate == 9){
		
		if (substate_begin){
			//sfx_play(___snd_gb_on, 1, 0);
			prompt_dir = 45;
			prompt_scale = 0;
			prompt_scale_done = false;
			wait = 5;
			prompt = microgame_next_metadata.prompt[irandom(array_length(microgame_next_metadata.prompt) - 1)];
			prompt_sprite = ___prompt_sprite_create(prompt);
			
		}
	
		// draw larold
		draw_surf_larold(_gb_margin_left, _gb_margin_top, canvas_w * gb_scale, canvas_h * gb_scale, 1, bm_normal);
		
		// draw gameboy
		draw_sprite_ext(___spr_gameboy_overlay, 0, _gb_margin_left, _gb_margin_top, gb_scale, gb_scale, 0, c_white, 1);
		
		if (!prompt_scale_done){
			prompt_scale = -lengthdir_y(1.5, prompt_dir);
			prompt_dir += 5;
			if (prompt_dir > 90 && prompt_scale <= 1){
				prompt_scale = 1;
				prompt_scale_done = true;
			}
		}
		
		// draw prompt
		var _shake_val = max(0, (prompt_scale - 1) * 5);
		var _shake_x = random_range(-_shake_val, _shake_val);
		var _shake_y = random_range(-_shake_val, _shake_val);
		
		var _prompt_x = ((canvas_x + (canvas_w/2)) * _scale) + _shake_x;
		var _prompt_y = ((canvas_y + (canvas_h/2)) * _scale) + _shake_y;
		var _prompt_alpha = min(prompt_scale, 1);
		draw_sprite_ext(prompt_sprite, 0, _prompt_x, _prompt_y, prompt_scale, prompt_scale, 0, c_white, _prompt_alpha);
		
		if (wait <= 0){

			___microgame_start(microgame_next_name);
			___state_change("playing_microgame");
			exit;
		}
		
		if (prompt_scale_done) wait--;
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
	
	cart_float_dir += 5;
	if (cart_float_dir >= 360) cart_float_dir -= 360;
	var _scale = 0.5;
	var _spr_w = sprite_get_width(cart_sprite) * _scale;
	var _spr_h = sprite_get_height(cart_sprite)* _scale;
	
	var _x = ((VIEW_W/2) - (_spr_w/2));
	var _y = (((VIEW_H/2) - (_spr_h/2)) + 20) + lengthdir_y(3, cart_float_dir);
	draw_sprite_ext(cart_sprite, 0, _x, _y, _scale, _scale, 0, c_white, 1);
}