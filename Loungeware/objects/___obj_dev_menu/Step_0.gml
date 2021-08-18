headdir += 3;
spotlight_dir += 2;

if (skip_possible && KEY_ANY_PRESSED && state != "dev_record"){
	if (spotlight_snd != noone) audio_sound_gain(spotlight_snd, 0, 200);
	if (sng == noone) sng = audio_play_sound(___sng_zandintro_through_wall, 1, true);
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
			spotlight_snd = audio_play_sound(___snd_spotlight_on, 1, false);
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
			wait = 80;
			step = 0;
			screenshake = 6;
			if (sng == noone) sng = audio_play_sound(___sng_zandintro_through_wall, 1, true);
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
	
	if (ds_list_find_index(voice_frames, step-60) != -1){
		larold_talking = 5;
		var _snd = audio_play_sound(___snd_lar_voice, 0, 0);
		audio_sound_pitch(_snd, random_range(0.95, 1.05));
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
	skip_possible = false;
	var _v_move = -KEY_UP_PRESSED + KEY_DOWN_PRESSED;
	var _store_cursor = cursor;
	cursor +=  _v_move;
	if (cursor > array_length(menu)-1) cursor = 0;
	if (cursor < 0) cursor = array_length(menu)-1;
	if (cursor != _store_cursor){
		___sound_menu_tick_vertical();
	}
	if (KEY_PRIMARY_PRESSED){
		confirmed = true;
		// play snd
		var _snd_index  = ___snd_cart_insert;
		var _snd_id = audio_play_sound(_snd_index, 0, 0);
		var _vol = VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index) * 0.7;
		audio_sound_gain(_snd_id, _vol, 0);
		wait = 8;
	}
	
	if (confirmed && wait <= 0){
		menu[cursor][1]();

	}
	wait--;
}

// -----------------------------------------------------------------------
// STATE | FLY UP
//------------------------------------------------------------------------
if (state == "fly_up"){
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
}


