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
		if (TEST_MODE_ACTIVE && _metadata.time_seconds > ___global.max_microgame_time){
			show_message("You are exceeding the maximum amount of time allowed for a microgame. Please make a game that is " + string(___global.max_microgame_time) + " seconds or shorter.\nIf you need to test your microgame without a timer then press \"I\" while in test mode to toggle infinite timer.");
		}
		

		microgame_won = false;
		microgame_timer_skip = false;
		cart_sprite = ___cart_sprite_create(_metadata);
		gb_timerbar_visible = true;
		transition_appsurf_zoomscale = 1;
		transition_circle_rad = canvas_h;
		
		if (_metadata.music_track >= 0) microgame_music_start(_metadata.music_track, 1, _metadata.music_loops);
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
	if (!TEST_MODE_ACTIVE && !gallery_mode){
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
	
	if (!TEST_MODE_ACTIVE && !gallery_mode){
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
// SMOOTH MOVE
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
	
	if (HTML_MODE){
		show_debug_message("Trying to load local file in HTML mode. this shouldn't happen!");
		return {};
	}
	
	 var _filename = "tmpenv.dev";
	 var _test_key = ___dev_config_get_test_key();

	
	 var _default = {
	 	difficulty_level: 1,
	 	microgame_key: _test_key,
	 	mute_test: false,
	 	debug_hidden: false,
	 	infinite_timer: false,
	 	fullscreen_status: false,
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
		
	 //delete file if test game has changed
	 if (_loaded.microgame_key != _test_key){
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
	_data.microgame_key = ___dev_config_get_test_key();
	_data.mute_test = ___dev_debug.muted;
	_data.debug_hidden = ___dev_debug.debug_hidden;
	_data.infinite_timer = ___dev_debug.infinite_timer;
	_data.fullscreen_status = ___dev_debug.fullscreen_status;
	
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
	var _snd_id = ___BUILTIN_AUDIO_PLAY_SOUND(_snd_index, 0, 0);
	var _vol = 0.8 * VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index);
	audio_sound_gain(_snd_id, _vol, 0);
	audio_sound_pitch(_snd_id, 1);
}

function ___sound_menu_tick_horizontal(){
	var _snd_index  = ___snd_menu_tick;
	var _snd_id = ___BUILTIN_AUDIO_PLAY_SOUND(_snd_index, 0, 0);
	var _vol = 0.8 * VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index);
	audio_sound_gain(_snd_id, _vol, 0);
	audio_sound_pitch(_snd_id, 0.8);
}


// ------------------------------------------------------------------------------------------
// DRAW DOTTED LINE
// ------------------------------------------------------------------------------------------
function draw_dotted_line(_x1, _y1, _x2, _y2, _dot_size, _gap_size){
	// swap x1 and x2 if x2 is smaller
	var _xx = _x1;
	var _yy = _y1;
	var _direction = point_direction (_x1, _y1, _x2, _y2);
	
	var _dist = point_distance(_x1, _y1, _x2, _y2);
	var _seg_count = floor((_dist + _gap_size) / (_dot_size + _gap_size)) + 1;
	repeat(_seg_count){
		
		draw_rectangle_fix(_xx - (_dot_size/2), _yy - (_dot_size/2), _xx+(_dot_size/2), _yy + (_dot_size/2));
		_xx += lengthdir_x(_gap_size + _dot_size, _direction);
		_yy += lengthdir_y(_gap_size + _dot_size, _direction);
	}
	
}

// ------------------------------------------------------------------------------------------
// MICROGAME GET KEYLIST CHRONOLOGICAL
// returns an array of all miceogame keys ordered by date-added (newest first)
// ------------------------------------------------------------------------------------------
function ___microgame_get_keylist_chronological(){
	var _microgame_keylist = variable_struct_get_names(___global.microgame_metadata);
	var _keys = ds_priority_create();
	
	for (var i = 0; i < array_length(_microgame_keylist); i++){
		var _date = variable_struct_get(___global.microgame_metadata, _microgame_keylist[i]).date_added;
		
		var _date_as_array = ___global.___split_string_by_char(_date, "/", true);
		
		if (array_length(_date_as_array) != 3){
			show_debug_message("DATE ERROR IN " + string(_microgame_keylist[i].game_name));
			_date = 0;
		} else {
			var _year = real(_date_as_array[0]);
			if (_year < 100) _year = 2000 + _year;
			var _month = real(_date_as_array[1]);
			var _day = real(_date_as_array[2]);
			
			_date = (_year * 365) + (_month * 31) + (_day);
			
		}
		
	
		ds_priority_add(_keys, _microgame_keylist[i], _date);
	}
	_microgame_keylist = [];
	while (ds_priority_size(_keys) > 0){
		array_push(_microgame_keylist, ds_priority_delete_max(_keys));
	}
	ds_priority_destroy(_keys);
	
	return _microgame_keylist;
}


// ------------------------------------------------------------------------------------------
// PRIVATE SOUND FUNCTIONS (for use in base game, do not use in microgames, 
// for public functions: check the public_audio_functions script
// ------------------------------------------------------------------------------------------
function ___play_song(_sound_index, _vol=1, _loop=true){
	var _snd_id = ___BUILTIN_AUDIO_PLAY_SOUND(_sound_index, 1, true);
	audio_sound_gain(
		_snd_id, 
		_vol * audio_sound_get_gain(_sound_index) * VOL_MSC * VOL_MASTER,
		0,
	);
	return _snd_id;
}

function ___play_sfx(_sound_index, _vol=1, _pitch=1, _loop=false){
	var _snd_id = ___BUILTIN_AUDIO_PLAY_SOUND(_sound_index, 1, _loop);
	audio_sound_gain(
		_snd_id, 
		audio_sound_get_gain(_sound_index) * VOL_SFX * VOL_MASTER,
		0,
	);
	audio_sound_pitch(_snd_id, _pitch);
	return _snd_id;
}


// ------------------------------------------------------------------------------------------
// DEV CONFIG GET TEST KEY
// get the current game test key from the dev config file
// ------------------------------------------------------------------------------------------
function ___dev_config_get_test_key(){
	if (!HTML_MODE){
		if (!file_exists(___DEV_CONFIG_PATH)) return false;
		var _file = file_text_open_read(___DEV_CONFIG_PATH);
		var _str = file_text_read_string(_file);
		var _data = json_parse(_str);
		file_text_close(_file);
		return _data.microgame_key;
	}
}


// ------------------------------------------------------------------------------------------
// URL GET QUERY
// returns the key/value pairs fromt the URL query string as a struct 
//(or empty struct if none exist, or not in html mode)
// ------------------------------------------------------------------------------------------
function ___url_get_query(){
	show_debug_message("attempting to check query string");
	var _data = {};
	if (!HTML_MODE) return _data;
	for (var i = 0; i < parameter_count(); i++){
		var _str = parameter_string(i+1);
		var _equal_pos = string_pos("=", _str);
		if (_equal_pos <= 0) continue;
		var _key = string_delete(_str, _equal_pos, string_length(_str) - _equal_pos + 1);
		var _val = string_delete(_str, 1, _equal_pos);
		variable_struct_set(_data, _key, _val);
	};
	return _data;
}

// ------------------------------------------------------------------------------------------
// URL GET VAR
// get the value of the given url querty variable if it exists. if it doesn't exist, returns -1
// ------------------------------------------------------------------------------------------
function ___url_get_var(_varname){
	var _data = ___url_get_query();
	if (!variable_struct_exists(_data, _varname)) return -1;
	return variable_struct_get(_data, _varname);
}

// ------------------------------------------------------------------------------------------
// MICROGAME KEY EXISTS
// checks whether a microgame exists in the data
// ------------------------------------------------------------------------------------------
function ___microgame_key_exists(_key, _override_disable=true){
	if (_key == -1) return false;
	var _exists = false;
	var _keylist = variable_struct_get_names(___global.save_data.microgame_data);
	for (var i = 0; i < array_length(_keylist); i++){
		if (_keylist[i] == _key){
			var _is_enabled = variable_struct_get(___global.save_data.microgame_data, "is_enabled");
			if (_is_enabled){
				_exists = true;
			} else {
				if (_override_disable) _exists = true;
			}
			break;
		} 
	}
	return _exists;
}

// ------------------------------------------------------------------------------------------
// MICROGAME LOAD GALLERY VERSION
// loads the gallery version of a microgame
// ------------------------------------------------------------------------------------------
function ___microgame_load_gallery_version(_microgame_key, _difficulty=1){
	
	_difficulty = round(clamp(_difficulty, 1, 5));
	room_goto(___rm_restroom);
	
	with(instance_create_layer(0, 0, layer, ___MG_MNGR)){
		___state_change("game_switch");
		___global.difficulty_level = _difficulty;
		force_substate = 5;
		var _game_data = variable_struct_get(___global.microgame_metadata, _microgame_key);
		cart_sprite = ___cart_sprite_create(_game_data);
		microgame_next_name = _microgame_key;
		microgame_next_metadata = _game_data;
		gb_scale = gb_min_scale;
		gallery_mode = true;
		gallery_first_pass = true;
		microgame_current_metadata = _game_data;
		
	}
	instance_destroy();
}

// ------------------------------------------------------------------------------------------
// MICROGAME LIST REMOVE INCOMPATIBLE
// removes all the games that are not compatible with the current configuration or export
// from the global gamelist
// ------------------------------------------------------------------------------------------
function ___microgame_list_remove_incompatible(){
	// at this point in the game we can be sure that the game is not running in developer mode
	// so here we will delete all disabled games
	microgame_namelist = variable_struct_get_names(___global.microgame_metadata);
	for(var i = 0; i < array_length(microgame_namelist); i++){
		var _data = variable_struct_get(___global.microgame_metadata, microgame_namelist[i]);
		var _disabled = (variable_struct_exists(_data, "is_enabled")) && (_data.is_enabled == false);
		var _has_html_prop = variable_struct_exists(_data, "supports_html");
		var _supports_html = (_has_html_prop && _data.supports_html == true);
		
		if (_disabled || (HTML_MODE && !_supports_html)){
			var _debug_str = _data.game_name + " was removed from gamelist because ";
			
			if (_disabled){
				_debug_str += "[disabled] ";
			} else if (HTML_MODE){
				if (!_has_html_prop){
					_debug_str += "[no \"supports_html\" property was found in metadata] ";
				} else {
					_debug_str += "[\"supports_html\" property was set to false]";
				}
			}
			
			show_debug_message(_debug_str);
			variable_struct_remove(___global.microgame_metadata, microgame_namelist[i]);
		}
	}
}