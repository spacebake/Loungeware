headdir += 3;
spotlight_dir += 2;

if (skip_possible && KEY_ANY_PRESSED && state != "dev_record"){
	if (spotlight_snd != noone) audio_sound_gain(spotlight_snd, 0, 200);
	if (sng == noone) sng = ___play_song(___sng_zandintro_through_wall);

	screenshake = 8;
	state = "skip";
	exit;
}

//------------------------------------------------------------------------
// STATE | DEV RECORD
//------------------------------------------------------------------------
if (state == "dev_record"){
	if (KEY_PRIMARY_PRESSED) state = "intro";
	}
//------------------------------------------------------------------------
// STATE | INTRO
//------------------------------------------------------------------------
if (state == "intro"){
	
	if (substate == 0){
		wait--;
		if (wait <= 0){
			spotlight_snd = ___play_sfx(___snd_spotlight_on);
			substate++;
		}
	}
	
	if (substate == 1){
		var _max = 0.3;
		light_val = max(0, light_val - (_max/6));
		if (ds_list_find_index(flash_frames, step) != -1){
			light_val = _max;
		}
		if (step == ds_list_find_value(flash_frames, ds_list_size(flash_frames)-1)){
			light_val = 1;
			wait = 50;
			step = 0;
			screenshake = 6;
			if (sng == noone) sng = ___play_song(___sng_zandintro_through_wall);
			state = "talk";
			exit;
		}
		step++;
	}
	
	
}

//------------------------------------------------------------------------
// STATE | TALK
//------------------------------------------------------------------------
if (state == "talk"){
	
	str = string_copy(str_final, 1, str_pos);
	var _len = string_length(str_final)+1;
	str_pos_prev = str_pos;
	if (wait <= 0) str_pos = min(str_pos + txt_speed, _len);
	if (str_pos >= _len) string_complete = true;
	wait = max(0, wait-1);
	
	if (ds_list_find_index(voice_frames, step-30) != -1){
		larold_talking = 5;
		var _pitch = random_range(0.95, 1.05);
		___play_sfx(___snd_lar_voice, 1, _pitch);

	}
	if (string_complete && larold_talking <= 0){
		
		state="menu_slide";
		exit;
	}
	step++;
	larold_talking = max(0, larold_talking-1);
	larold_frame = (larold_talking > 0);
}


//------------------------------------------------------------------------
// STATE | MENU SLIDE
//------------------------------------------------------------------------
if (state == "menu_slide"){
	menu_item_x_offset = ___smooth_move(menu_item_x_offset, 0, 1, 5);
	if (menu_item_x_offset <= 0){
		state = "choose";
		
	}
}

//------------------------------------------------------------------------
// STATE | SKIP
//------------------------------------------------------------------------
if (state == "skip"){
	light_val = 1;
	str = str_final;
	menu_item_x_offset = 0;
	state = "choose";
}

//------------------------------------------------------------------------
// STATE | CHOOSE
//------------------------------------------------------------------------
if (state == "choose"){
	
	yy_mod = ___smooth_move(yy_mod, 0, 1, 8);
	skip_possible = false;
	
	if (!confirmed){
		var _v_move = -KEY_UP_PRESSED + KEY_DOWN_PRESSED;
		var _store_cursor = cursor;
		cursor +=  _v_move;
		if (cursor > array_length(menu)-1) cursor = 0;
		if (cursor < 0) cursor = array_length(menu)-1;
		if (cursor != _store_cursor){
			___sound_menu_tick_vertical();
		}
	}
	
	if (KEY_PRIMARY_PRESSED && !confirmed){
		confirmed = true;
		// play snd
		var _snd_index  = ___snd_cart_insert;
		var _snd_id = ___play_sfx(_snd_index, 0.7);

		wait = 8;
	}
	
	if (confirmed && wait <= 0){
		var _menu_function = menu[cursor][1];
		_menu_function();
	}
	wait--;
}

// -----------------------------------------------------------------------
// STATE | FLY UP
//------------------------------------------------------------------------
if (state == "fly_up"){
	if (KEY_PRIMARY_PRESSED){
		fadeout_alpha = 1;
	}
	larold_frame = min(larold_frame + 0.2, 3);
	larold_y_mod += larold_vsp;
	larold_vsp -= 0.2;
	fadeout_alpha = min(1, fadeout_alpha + (1/90));
	if (fadeout_alpha >= 1){
		state = "execute_method";
		instance_create_layer(0,0,layer, ___obj_title_screen);
		instance_destroy();
	}
}

if (screenshake > 0){
	screenshake--;
	var sv = 2;
	if (screenshake <= 0) sv = 0;
	shake_x = random_range(-sv, sv);
	shake_y = random_range(-sv, sv);
}

// -----------------------------------------------------------------------
// STATE | MENU GOTO GAMELIST
//------------------------------------------------------------------------
if (state == "goto_gamelist"){
	yy_mod = ___smooth_move(yy_mod, -VIEW_H, 1, 8);
	if (yy_mod <= -VIEW_H) state = "gamelist";
}

// -----------------------------------------------------------------------
// STATE | GAMELIST
//------------------------------------------------------------------------
scroll_y = ___smooth_move(scroll_y, scroll_y_target, 0.5, 5);


if (state == "gamelist"){
	
	scroll_y = ___smooth_move(scroll_y, scroll_y_target, 0.5, 8);
	
	if (keyboard_check_pressed(vk_escape) || KEY_SECONDARY_PRESSED){
		if (!confirmed){
			state = "choose";
			exit;
		} else {
			confirmed = false;
		}
	}
	
	if (!confirmed){
		var _move = -KEY_UP + KEY_DOWN;
		if (_move != previous_scroll_dir){
			input_cooldown = 0;
			input_is_scrolling = false;
		}
		previous_scroll_dir = _move;
		if (abs(_move) && input_cooldown <= 0){
			if (input_is_scrolling){
				input_cooldown = input_cooldown_max;
			} else {
				input_cooldown = input_cooldown_init_max;
				input_is_scrolling = true;
			}
			___sound_menu_tick_vertical();
		} else {
			_move = 0;
			input_cooldown = max(0, input_cooldown - 1);
		}
		
		var _list_len = array_length(game_keylist);
		cursor2 += _move;
		if (cursor2 > _list_len-1) cursor2 = 0;
		if (cursor2 < 0) cursor2 = _list_len -1;
	}
	
	if (KEY_PRIMARY_PRESSED && !confirmed){
		confirmed = true;
		var _data = variable_struct_get(___global.microgame_metadata, game_keylist[cursor2]);
		if (sprite_exists(cart_sprite)) sprite_delete(cart_sprite);
		cart_sprite = ___cart_sprite_create(_data);
		// play snd
		var _snd_index  = ___snd_cart_insert;
		var _snd_id = ___play_sfx(_snd_index, 0.7);
		var _vol = VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index) * 0.7;
		audio_sound_gain(_snd_id, _vol, 0);
		exit;
		
	}
	
	if (confirmed){
		fadeout_alpha = min(1, fadeout_alpha + (1/5));
		audio_sound_gain(sng, 0, 84);
		cart_float_dir += 2;
		if (KEY_PRIMARY_PRESSED){
			state = "save";
			exit;
		}
		exit;
	} else {
		fadeout_alpha = max(0, fadeout_alpha - (1/5));
		
		audio_sound_gain(
			sng, 
			audio_sound_get_gain(___sng_zandintro_through_wall) * VOL_MSC * VOL_MASTER,
			84
		);
	}

}

if (!confirmed) confirm_shake_time = confirm_shake_time_max;

// -----------------------------------------------------------------------
// STATE | SAVE
//------------------------------------------------------------------------
if (state == "save"){
	audio_stop_all();
	save_dev_config(game_keylist[cursor2]);
	game_restart();
}