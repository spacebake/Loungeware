//--------------------------------------------------------------------------------------------------------
// checks if key is held using ___global.default_input_keys. provide a string as the property name for key type
//--------------------------------------------------------------------------------------------------------
function ___macro_keyboard_check(_keystr){
	var _list =  variable_struct_get(___global.default_input_keys, _keystr);
	for (var i = 0; i < array_length(_list); i++){
		if (keyboard_check(_list[i])) {
			return (_list[i] == vk_enter) ? !keyboard_check(vk_alt) : true; // Makes Alt + Enter (which toggles fullscreen) not trigger an input :)
		}
	}
	for (var i=0;i<gamepad_get_device_count();i++) {
		if (___global.controller_values[i].state.held[$ _keystr]) return true;
	}
	return false;
}

//--------------------------------------------------------------------------------------------------------
// DRAW RECTANGLE FIX
// draws a rectangle but with 1 pixel removed from the x2 and y2 values
//--------------------------------------------------------------------------------------------------------
function draw_rectangle_fix(_x1, _y1, _x2, _y2){
	draw_rectangle(_x1, _y1, _x2 - 1, _y2 - 1, 0);
}

	
//--------------------------------------------------------------------------------------------------------
// checks if key is pressed using ___global.default_input_keys. provide a string as the property name for key type
//--------------------------------------------------------------------------------------------------------
function ___macro_keyboard_check_pressed(_keystr){
	var _list =  variable_struct_get(___global.default_input_keys, _keystr);
	for (var i = 0; i < array_length(_list); i++){
		if (keyboard_check_pressed(_list[i])) {
			return (_list[i] == vk_enter) ? !keyboard_check(vk_alt) : true; // Makes Alt + Enter (which toggles fullscreen) not trigger an input :)
		}
	}
	for (var i=0;i<gamepad_get_device_count();i++) {
		if (___global.controller_values[i].state.pressed[$ _keystr]) return true;
	}
	return false;
}

//--------------------------------------------------------------------------------------------------------
// checks if key is released using ___global.default_input_keys. provide a string as the property name for key type
//--------------------------------------------------------------------------------------------------------
function ___macro_keyboard_check_released(_keystr){
	var _list =  variable_struct_get(___global.default_input_keys, _keystr);
	for (var i = 0; i < array_length(_list); i++){
		if (keyboard_check_released(_list[i])) {
			return (_list[i] == vk_enter) ? !keyboard_check(vk_alt) : true; // Makes Alt + Enter (which toggles fullscreen) not trigger an input :)
		}
	}
	for (var i=0;i<gamepad_get_device_count();i++) {
		if (___global.controller_values[i].state.released[$ _keystr]) return true;
	}
	return false;
}

//--------------------------------------------------------------------------------------------------------
// LOAD FAKE MICROGAME
// loads a fake microgame as the first game to pop out of the gameboy, no game is actually attached to it
//--------------------------------------------------------------------------------------------------------
function ___microgame_load_fake(){

		var _cart = ___get_fake_label();
		
		
		_cart.cartridge_label = ___spr_fake_labels;
		cart_sprite = ___cart_sprite_create(_cart);
		
		microgame_current_metadata = _cart;

		//show_message(microgame_current_metadata);
		microgame_next_name = microgame_unplayed_list[| irandom_range(0, ds_list_size(microgame_unplayed_list) - 1)];
		microgame_next_metadata = variable_struct_get(___global.microgame_metadata, microgame_next_name);
}

//--------------------------------------------------------------------------------------------------------
// MICROGAME START
// name says it all tbh
//--------------------------------------------------------------------------------------------------------
function ___microgame_start(_microgame_propname){
	
	// init new microgame
	with(___MG_MNGR){
		
		// garbo the sprites from last cutscene
		while (ds_list_size(garbo_sprites) > 0){
			sprite_delete(garbo_sprites[| 0]);
			ds_list_delete(garbo_sprites, 0);
		}
		
		var _metadata = variable_struct_get(___global.microgame_metadata, _microgame_propname);
		microgame_current_metadata = _metadata;
		microgame_current_name = _microgame_propname;
		
		
		microgame_timer = _metadata.time_seconds * 60;
		microgame_timer_max = _metadata.time_seconds * 60;
		if (dev_mode && _metadata.time_seconds > ___global.max_microgame_time){
			show_message("You are exceeding the maximum amount of time allowed for a microgame. Please make a game that is " + string(___global.max_microgame_time) + " seconds or shorter.\nIf you need to test your microgame without a timer then press \"I\" while in test mode to toggle infinite timer.");
		}
		

		microgame_won = false;
		microgame_timer_skip = false;
		cart_sprite = ___cart_sprite_create(_metadata);
		gb_timerbar_visible = true;
		transition_appsurf_zoomscale = 1;
		transition_circle_rad = canvas_h;
		
		if (_metadata.music_track != noone) microgame_music_start(_metadata.music_track, 1, _metadata.music_loops);
		microgame_music_auto_stopped = false;
		room_goto(_metadata.init_room);
		
		// destroy and recreate fake global
		with (___fake_global) instance_destroy();
		instance_create_layer(0, 0, layer, ___fake_global);
		// garbage collect any leftover ds structures from previous microgame
		workspace_end();
		workspace_begin();
	}
}

//--------------------------------------------------------------------------------------------------------
// MICROGAME END
// name says it all tbh
//--------------------------------------------------------------------------------------------------------
function ___microgame_end(){
	
	games_played += 1;
	if (games_played mod 3 == 0){
		difficulty_up_queue = true;
	} else {
		difficulty_up_queue = false;
	}
	
	show_debug_overlay(false);
	
	// update save data
	if (!dev_mode && !gallery_mode){
		var _save_struct = variable_struct_get(___global.save_data.microgame_data, ___MG_MNGR.microgame_current_name);
		_save_struct.play_count = _save_struct.play_count + 1;
		if (___MG_MNGR.microgame_won){
			_save_struct.wins = _save_struct.wins + 1;
			var _time_taken = ___MG_MNGR.microgame_timer_max - ___MG_MNGR.microgame_time_finished;
			if (_time_taken < _save_struct.best_time) _save_struct.best_time = _time_taken;
		}
	}
	___save_game();
	
	// send to server if data collection on
	if (___global.save_data.data_collection){
		// < CODE GO HERE AT SOME POINT >
	}
		
	// if win
	if (___MG_MNGR.microgame_won){
		larold_index = 1;
		var _points = 1 + (___MG_MNGR.microgame_timer / ___MG_MNGR.microgame_timer_max) + (DIFFICULTY/5);
		___MG_MNGR.score_total += _points;
	// if lose
	} else {
		//show_message("lose");
		//show_message("time remaining: " + ___MG_MNGR.microgame_timer);
	}
	
	// go to rest room (lol)
	room_goto(___rm_restroom);
	
	if (!dev_mode && !gallery_mode){
		// remove game from unplayed list 
		var _index_to_remove = ds_list_find_index(microgame_unplayed_list, ___MG_MNGR.microgame_current_name);
		ds_list_delete(microgame_unplayed_list, _index_to_remove);
	
		// if uplayed list is empty, repopulate it with all games (excluse the one just played, if possble, see below)
		if (ds_list_size(microgame_unplayed_list) <= 0){
			microgame_populate_unplayed_list();
		
			// if there is more than 1 game, delete the last played game from the new list as to not get repeats
			if (ds_list_size(microgame_unplayed_list) > 1){
				_index_to_remove = ds_list_find_index(microgame_unplayed_list, ___MG_MNGR.microgame_current_name);
				ds_list_delete(microgame_unplayed_list, _index_to_remove);
			}
		}
	
		// choose next game from uplayed list
		microgame_next_name = microgame_unplayed_list[| irandom_range(0, ds_list_size(microgame_unplayed_list) - 1)];
		microgame_next_metadata = variable_struct_get(___global.microgame_metadata, microgame_next_name);
	} else {
		microgame_next_name = microgame_current_name;
		microgame_next_metadata = microgame_current_metadata;
	}
	
}


//--------------------------------------------------------------------------------------------------------
// tTH MOVE
// moves a number towards another number, slows down as it approaches
//--------------------------------------------------------------------------------------------------------
function ___smooth_move(_current_val, _target_val, _minimum, _divider){
	
	if (object_index == ___MG_MNGR){
		_divider = (_divider / transition_speed);
		_minimum = (_minimum * transition_speed);
	}
	
	var _diff = _target_val - _current_val;
	var _store_sign = sign(_diff);
	
	if (abs(_diff) <= _minimum){
		_current_val = _target_val;
	} else {
		_current_val += max(_minimum/3, abs(_diff / _divider)) * sign(_diff);
		if (_store_sign != sign(_target_val - _current_val)){
			_current_val = _target_val;
		}
	}
	return _current_val;
}


//--------------------------------------------------------------------------------------------------------
// LOG | log multiple values at once
//--------------------------------------------------------------------------------------------------------
function log(){
	var _str = "";
	var _i = 0; repeat(argument_count) {
		_str += string(argument[_i++]) + " | ";    
	}
	show_debug_message(_str);
}

// ------------------------------------------------------------------------------------------
// STATE SETUP || call this in the create event.
// ------------------------------------------------------------------------------------------
function ___state_setup(_starting_state){
	state = _starting_state;
	state_goto = _starting_state;
	state_begin = true;
	substate = 0;
	subsubstate = 0;
	store_substate = 0;
	substate_begin = false;
}

// ------------------------------------------------------------------------------------------
// STATE CHANGE FUNCTION | prepares a state change. state won't change until state_handler is called
// state_setup must have been called in the create event to use this function.
// ------------------------------------------------------------------------------------------
function ___state_change(_state_goto){
	// note: when this function is called state_begin is set to TRUE for the next step 
	//(this will happen even if you try to change into a state you are already in).
	state_goto = _state_goto;
}

// ------------------------------------------------------------------------------------------
// STATE CHANGE HANDLER | 
// ------------------------------------------------------------------------------------------
function ___state_handler(){
	state_begin = false;
	substate_begin = false;
	if (state_goto != noone){
		state_begin = true;
		state = state_goto;
		state_goto = noone;
		substate = 0;
		subsubstate = 0;
		substate_begin = true;
	}
	
	if (force_substate != noone){
		substate = force_substate;
		force_substate = noone;
	}
	
	if (substate !=  store_substate){
		substate_begin = true;
	}
	store_substate = substate;

}


// ------------------------------------------------------------------------------------------
// CENTER GAME WINDOW | clue is in the name
// ------------------------------------------------------------------------------------------
function ___center_window(){
	with (___global) alarm_set(0, 1);
}

// ------------------------------------------------------------------------------------------
// RESET DRAW VARS
// ------------------------------------------------------------------------------------------
function ___reset_draw_vars(){
	gpu_set_texfilter(false);
	draw_set_color(c_white);
	draw_set_font(fnt_frogtype);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	if (surface_get_target() != -1) surface_reset_target();
	shader_reset();
	matrix_set(matrix_world, matrix_build_identity());
}

// ------------------------------------------------------------------------------------------

// ------------------------------------------------------------------------------------------
function ___gamepad_check_button_multiple(device,buttons) {
	for (var i=0;i<array_length(buttons);i++) {
		if (gamepad_button_check(device,buttons[i])) return true;	
	}
	return false;
}

// ------------------------------------------------------------------------------------------

// ------------------------------------------------------------------------------------------
function __try_read_json(filepath){
	show_debug_message("INFO: reading json file " + filepath);	
	
	if(file_exists(filepath) == false){
		show_debug_message("WARNING: Could not find file " + filepath);	
		return undefined;
	}
	var file = file_text_open_read(filepath);
	if(file == -1){
		show_debug_message("ERROR: failed to open filepath " + string(filepath));
		return;
	}
	try {
		var str = "";
		while(file_text_eof(file) == false){
			var line =  file_text_readln(file);
			for(var i=1; i < string_length(line) + 1; i++){
				var char = string_char_at(line, i);
				var is_comment = string_copy(line, i, 2) == "//";
				if(is_comment){
					break;	
				}else{
					str = str + char;
				}
			}
		
			if(is_comment == 2){
				continue;	
			}
		}
	
		file_text_close(file);
		return json_parse(str);
	}
	catch (e) {
		show_debug_message("ERROR: " + string(e));
		file_text_close(file);
		return undefined;
	}
}

// ------------------------------------------------------------------------------------------
// MICROGAME GET PROMPT
// ------------------------------------------------------------------------------------------
// reyurns a random prompt from the microgame prompt array
function ___microgame_get_prompt(_key){
	var _metadata = variable_struct_get(___global.microgame_metadata, _key);
	return _metadata.prompt[irandom(array_length(_metadata.prompt) - 1)];
}

// ------------------------------------------------------------------------------------------

// ------------------------------------------------------------------------------------------
function ___noop(){
	// noop	
}

// ------------------------------------------------------------------------------------------
// DEV LOAD
// ------------------------------------------------------------------------------------------
function ___dev_load(){
	
	var _filename = "tmpenv.dev";
	
	var _default = {
		difficulty_level: 1,
		microgame_key: ___global.test_vars.microgame_key,
		mute_test: false,
		debug_hidden: false,
		infinite_timer: false,
	}
	
	if (file_exists(_filename)){

		var _file = file_text_open_read(_filename);
		var _json = file_text_read_string(_file);
		var _loaded = json_parse(_json);
		file_text_close(_file);
	
		// check loaded has all the props that default has
		var _default_proplist = variable_struct_get_names(_default);
		for (var i = 0; i < array_length(_default_proplist); i++){
			if (!variable_struct_exists(_loaded, _default_proplist[i])){
				file_delete(_filename);
				return _default;
			}
		}
		
		// delete file if test game has changed
		if (_loaded.microgame_key != ___global.test_vars.microgame_key){
			file_delete(_filename);
			return _default;
			
		}
		
		return _loaded;
	} 
	
	return _default;

}

// ------------------------------------------------------------------------------------------
// DEV SAVE
// ------------------------------------------------------------------------------------------
function ___dev_save(){
	
	var _data = ___dev_debug.saved_dev_vars;
	_data.difficulty_level = ___global.difficulty_level;
	_data.microgame_key = ___global.test_vars.microgame_key;
	_data.mute_test = ___dev_debug.muted;
	_data.debug_hidden = ___dev_debug.debug_hidden;
	_data.infinite_timer = ___dev_debug.infinite_timer;
	
	var _filename = "tmpenv.dev";
	var _str = json_stringify(___dev_debug.saved_dev_vars);
	var _file = file_text_open_write(_filename);
	file_text_write_string(_file, _str);
	file_text_close(_file);

}

// ------------------------------------------------------------------------------------------
// SOUNDS
// ------------------------------------------------------------------------------------------
function ___sound_menu_tick_vertical(){
	var _snd_index  = ___snd_menu_tick;
	var _snd_id = audio_play_sound(_snd_index, 0, 0);
	var _vol = 0.8 * VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index);
	audio_sound_gain(_snd_id, _vol, 0);
	audio_sound_pitch(_snd_id, 1);
}

function ___sound_menu_tick_horizontal(){
	var _snd_index  = ___snd_menu_tick;
	var _snd_id = audio_play_sound(_snd_index, 0, 0);
	var _vol = 0.8 * VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index);
	audio_sound_gain(_snd_id, _vol, 0);
	audio_sound_pitch(_snd_id, 0.8);
}