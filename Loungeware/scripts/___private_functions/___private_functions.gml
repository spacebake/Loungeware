//--------------------------------------------------------------------------------------------------------
// DRAW RECTANGLE FIX
// draws a rectangle but with 1 pixel removed from the x2 and y2 values
//--------------------------------------------------------------------------------------------------------
function draw_rectangle_fix(_x1, _y1, _x2, _y2){
	draw_rectangle(_x1, _y1, _x2 - 1, _y2 - 1, 0);
}

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

// ------------------------------------------------------------------------------------------

// ------------------------------------------------------------------------------------------
function ___gamepad_check_button_multiple(device,buttons) {
	for (var i=0;i<array_length(buttons);i++) {
		if (gamepad_button_check(device,buttons[i])) return true;	
	}
	return false;
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
	substate_goto = noone;
	state_begin = true;
	substate = 0;
	subsubstate = 0;
	store_substate = 0;
	substate_begin = false;
	force_substate = noone;
	state_previous = noone;
}

// ------------------------------------------------------------------------------------------
// STATE CHANGE FUNCTION | prepares a state change. state won't change until state_handler is called
// state_setup must have been called in the create event to use this function.
// ------------------------------------------------------------------------------------------
function ___state_change(_state_goto){
	// note: when this function is called state_begin is set to TRUE for the next step 
	//(this will happen even if you try to change into a state you are already in).
	if (state != _state_goto) state_previous = state;
	state_goto = _state_goto;
}
	
// ------------------------------------------------------------------------------------------
// SUBSTATE CHANGE 
// ------------------------------------------------------------------------------------------
function ___substate_change(_substate){
	substate_goto = _substate;
}

// ------------------------------------------------------------------------------------------
// STATE CHANGE HANDLER | 
// ------------------------------------------------------------------------------------------
function ___state_handler(){
	state_begin = false;
	substate_begin = false;
	
	if (substate_goto != noone){
		substate = substate_goto;
		substate_goto = noone;
	}
	
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
	var _snd_id = audio_play_sound(_snd_index, 0, 0);
	var _vol = 0.8 * VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index);
	audio_sound_gain(_snd_id, _vol, 0);
	audio_sound_pitch(_snd_id, 0.99 + random(0.01));
}

function ___sound_menu_tick_horizontal(){
	var _snd_index  = ___snd_menu_tick;
	var _snd_id = audio_play_sound(_snd_index, 0, 0);
	var _vol = 0.8 * VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index);
	audio_sound_gain(_snd_id, _vol, 0);
	audio_sound_pitch(_snd_id, 0.8);
}

function ___sound_menu_select(){
	var _snd_index  = ___snd_cart_insert;
	var _snd_id = audio_play_sound(_snd_index, 0, 0);
	var _vol = VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index) * 0.7;
	audio_sound_gain(_snd_id, _vol, 0);
}

function ___sound_menu_error(){
	var _snd_index  = ___snd_error;
	var _snd_id = audio_play_sound(_snd_index, 0, 0);
	var _vol = VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index) * 0.7;
	audio_sound_gain(_snd_id, _vol, 0);
}

function ___sound_menu_success(){
	var _snd_index  = ___snd_success;
	var _snd_id = audio_play_sound(_snd_index, 0, 0);
	var _vol = VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index) * 0.7;
	audio_sound_gain(_snd_id, _vol, 0);
}

function ___sound_menu_back(){
	var _snd_index  = ___snd_bumper;
	var _snd_id = audio_play_sound(_snd_index, 0, 0);
	var _vol = VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index) * 0.3;
	audio_sound_gain(_snd_id, _vol, 0);
	audio_sound_pitch(_snd_id, 1);
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
function ___play_song(_sound_index, _vol=1, _loop=true, _priority=100){
	var _snd_id = audio_play_sound(_sound_index, _priority, _loop);
	audio_sound_gain(
		_snd_id, 
		_vol * audio_sound_get_gain(_sound_index) * VOL_MSC * VOL_MASTER,
		0,
	);
	ds_list_add(___global.___audio_active_list, _snd_id);
	return _snd_id;
}

function ___play_sfx(_sound_index, _vol=1, _pitch=1, _loop=false, _priority=0){
	var _snd_id = audio_play_sound(_sound_index, _priority, _loop);
	audio_sound_gain(
		_snd_id, 
		audio_sound_get_gain(_sound_index) * VOL_SFX * VOL_MASTER * _vol,
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
		var _game_data = variable_struct_get(___global.microgame_metadata, _microgame_key);
		microgame_next_name = _microgame_key;
		microgame_next_metadata = _game_data;
		cart_change(_game_data)
		gallery_mode = true;
		gallery_first_pass = true;
		microgame_current_metadata = _game_data;
		force_substate = 5;
		
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

// ------------------------------------------------------------------------------------------
// CARTRIDGE SHADER | turn on/off shader to recolor the cartridge to the colors specified in the microgame metadata
// ------------------------------------------------------------------------------------------
function ___shader_cartridge_on(_microgame_metadata_struct){

	 var _col1 = _microgame_metadata_struct.cartridge_col_primary;
	 var _col2 = _microgame_metadata_struct.cartridge_col_secondary;

	var _r1 = (color_get_red(_col1)/255) + 0.0;
	var _g1 = (color_get_green(_col1)/255) + 0.0;
	var _b1 = (color_get_blue(_col1)/255) + 0.0;
	
	var _r2 = (color_get_red(_col2)/255) + 0.0;
	var _g2 = (color_get_green(_col2)/255) + 0.0;
	var _b2 = (color_get_blue(_col2)/255) + 0.0;

	
	var _color_new_primary = shader_get_uniform(___shd_cartridge, "color_new_primary");
	var _color_new_secondary = shader_get_uniform(___shd_cartridge, "color_new_secondary");
	shader_set(___shd_cartridge);
	shader_set_uniform_f(_color_new_primary, _r1, _g1, _b1, 1.0);
	shader_set_uniform_f(_color_new_secondary, _r2, _g2, _b2, 1.0);
	
	
}
function ___shader_cartridge_off(){
	shader_reset();
}



// ------------------------------------------------------------------------------------------
// CREATE CARTRIDGE SPRITE | creates a sprite for the microgame cartridge
// ------------------------------------------------------------------------------------------
function ___cart_sprite_create(_microgame_metadata){
	
	// create cart suface if it doesn't exist
	if (!surface_exists(surf_cart)){
		surf_cart = surface_create(sprite_get_width(___spr_gameboy_back), sprite_get_width(___spr_gameboy_back));
	}
	var _cart_x = sprite_get_xoffset(___spr_gameboy_back);
	var _cart_y = sprite_get_yoffset(___spr_gameboy_back);
	var _label_w = 304;
	var _label_h = 144;
	var _label_x = 38;
	var _label_y = 78;
	surface_set_target(surf_cart);
	draw_clear_alpha(c_white, 0);
	___shader_cartridge_on(_microgame_metadata);
	draw_sprite_ext(___spr_gameboy_back, 1, _cart_x , _cart_y, 1, 1, 0, c_white, 1);
	___shader_cartridge_off();
	if (sprite_exists(_microgame_metadata.cartridge_label)){
		draw_sprite_stretched(_microgame_metadata.cartridge_label, 0, _label_x, _label_y, _label_w/2, _label_h/2);
	}
	surface_reset_target();
	var _spr = sprite_create_from_surface(surf_cart, 0, 0, surface_get_width(surf_cart), surface_get_height(surf_cart), 0, 0, 7, 19 );
	if (object_index == ___MG_MNGR) ds_list_add(transition_garbo_sprites, _spr);
	return _spr;
}

// ------------------------------------------------------------------------------------------
// PROMPT SPRITE CREATE | creates a temp sprite for the microgame prompt text
// ------------------------------------------------------------------------------------------
function ___prompt_sprite_create(prompt){
	var _scale = 0.5;
	var _w = WINDOW_BASE_SIZE * _scale;
	var _h = WINDOW_BASE_SIZE * _scale;
	var _surf = surface_create(_w, _h);
	
	// remove exclamation point if added by microgame dev in error
	while (string_char_at(prompt, string_length(prompt)) == "!") prompt = string_copy(prompt, 1, string_length(prompt)-1);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_frogtype);
	var _prompt_x = _w/2;
	var _prompt_y = _h/2;
	surface_set_target(_surf);
	draw_clear_alpha(c_white, 0);
	var _outline_rad = 3;
	
	// draw text outline
	draw_set_color(c_gbblack);
	
	for (var i = 0; i < 360; i += 20){
		draw_text_ext(
			_prompt_x + lengthdir_x(_outline_rad, i),
			_prompt_y + lengthdir_y(_outline_rad, i),
			string_upper(prompt) + "!", 
			16, 
			_w, 
		);
	}
	// draw text
	draw_set_color(c_gbwhite);
	draw_text_ext(
		_prompt_x,
		_prompt_y,
		string_upper(prompt) + "!", 
		16, 
		_w, 
	);
	
	surface_reset_target();
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	var _spr = sprite_create_from_surface(_surf, 0, 0, _w, _h, 0, 0, 0, 0);
	ds_list_add(transition_garbo_sprites, _spr);
	if (surface_exists(_surf)) surface_free(_surf);
	return _spr;
}

// ------------------------------------------------------------------------------------------
// DRAW TITLE | DRAWS THE GAME TITLE FOR TRANSITION SEQUENCE
// ------------------------------------------------------------------------------------------
function ___draw_title(_x, _y){
	var _scale = 1;
	draw_set_font(fnt_frogtype);
	var _game_name = "\"" + string_upper(microgame_next_metadata.game_name) + "\"";
	var _game_creator = string_upper(microgame_next_metadata.authors);
	var _margin = 0;
	var _padding = 3;
	var _w = (WINDOW_BASE_SIZE - 64)/2;//174;
	var _sep = 14;
	var _name_h = string_height_ext(_game_name, _sep, _w) * _scale;
	var _name_w = string_width_ext(_game_name, _sep, _w) * _scale;
	var _creator_h = string_height_ext(_game_creator, _sep, _w) * _scale;
	var _creator_w = string_width_ext(_game_creator, _sep, _w) * _scale;
	var _max_w = max(_creator_w, _name_w);
	var _line_x1 = _x - (_max_w/2);
	var _line_x2 = _x + (_max_w/2);
	_y =  _y - ((_name_h + _creator_h + _margin)/2);

	draw_set_color(c_gbyellow);
	draw_set_halign(fa_center);

	draw_text_ext_transformed(_x, _y, _game_name, _sep, _w, _scale, _scale, 0);
	draw_set_color(c_gbpink);
	draw_rectangle_fix(_line_x1, (_y - _padding) - 2, _line_x2, _y - _padding);
	_y += (_name_h + _margin);
	draw_text_ext_transformed(_x, _y, _game_creator, _sep, _w, _scale, _scale, 0);
	_y += (_creator_h);
	draw_rectangle_fix(_line_x1, (_y + _padding) - 2, _line_x2, _y + _padding);
	draw_set_halign(fa_left);
	
}

// ------------------------------------------------------------------------------------------
// score constructor
// ------------------------------------------------------------------------------------------
function ___score_create(_name="", _points=0) constructor {
	name = _name;
	points = _points;
}

// ------------------------------------------------------------------------------------------
// ds list to struct
// ------------------------------------------------------------------------------------------
function ___ds_list_to_struct(_list){
	var _struct = {};
	for (var i = 0; i < ds_list_size(_list); i++){
		variable_struct_set(_struct, i, _list[| i]);
	}
	return _struct;
}

// ------------------------------------------------------------------------------------------
// struct to ds list (doesnt preserve key names) creates a ds list, be careful.
// ------------------------------------------------------------------------------------------
function ___struct_to_ds_list(_struct){
	var _list = ds_list_create();
	var _keys = variable_struct_get_names(_struct);
	for (var i = 0; i < array_length(_keys); i++){
		var _key = _keys[i];
		var _val = variable_struct_get(_struct, _key);
		ds_list_add(_val);
	}
	return _list;
}

// ------------------------------------------------------------------------------------------
// takes a sign (to be used for menu navigation) and returns another sign based on timers, for fluid menu movement (hard to describe, just read the code)
// ------------------------------------------------------------------------------------------
function ___menu_sign_timed_input_horizontal(_sign){
	static _sign_prev = 0;
	static _input_cd = 0;
	var _input_cd__max_initial = 20;
	var _input_cd_max_subsequent = 4;
	
	if (_sign == 0){
		_input_cd = 0;
		_sign_prev = _sign;
		return 0;
	} 
	
	if (_sign != _sign_prev){
		_input_cd = _input_cd__max_initial;
		_sign_prev = _sign;
		return _sign;
	}
	
	if (_sign == _sign_prev){
		if (_input_cd > 0){
			_input_cd = max(0, _input_cd - 1);
			return 0;
		} else {
			_input_cd = _input_cd_max_subsequent;
			_sign_prev = _sign;
			return _sign;
		}
	}
}

// ------------------------------------------------------------------------------------------
// same as previous functions, but this needs to be seperate so that 
// ------------------------------------------------------------------------------------------
function ___menu_sign_timed_input_vertical(_sign){
	static _sign_prev = 0;
	static _input_cd = 0;
	var _input_cd__max_initial = 30;
	var _input_cd_max_subsequent = 4;
	
	if (_sign == 0){
		_input_cd = 0;
		_sign_prev = _sign;
		return 0;
	} 
	
	if (_sign != _sign_prev){
		_input_cd = _input_cd__max_initial;
		_sign_prev = _sign;
		return _sign;
	}
	
	if (_sign == _sign_prev){
		if (_input_cd > 0){
			_input_cd = max(0, _input_cd - 1);
			return 0;
		} else {
			_input_cd = _input_cd_max_subsequent;
			_sign_prev = _sign;
			return _sign;
		}
	}
}

// ------------------------------------------------------------------------------------------
function ___uniqid(){
	var _len = 13;
	var _chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	var _str = "";
	for (var i = 0; i < _len; i++){
		_str += string_char_at(_chars, random_range(1, string_length(_chars)));
	}
	return _str;
}

// ------------------------------------------------------------------------------------------
function ___store_score_for_submission(_score){
	___global.score_last_as_obj = {points: _score, score_id_local: ___uniqid()}
}

// ------------------------------------------------------------------------------------------
// returns the current player id if it exists in save file, otherwise: creates a new one and saves it
// ------------------------------------------------------------------------------------------
function ___load_or_create_player_id(){
	var _path = "pid.lw";
	var _file_exists = file_exists(_path);
	var _id_is_valid = false;
	var _id;
	var _file;
		
	if (_file_exists){
		_file = file_text_open_read(_path);
		_id = file_text_read_string(_file);
		if (string_length(_id) == 13){
			_id_is_valid = true;
		} else {
			show_debug_message("invalid pid");
			file_delete(_path);
		}
		
		file_text_close(_file);
	}
		
	if (!_id_is_valid){
		_id = ___uniqid();
		_file = file_text_open_write(_path);
		file_text_write_string(_file, _id);
		file_text_close(_file); 
	}
	
	return _id;
}

// ------------------------------------------------------------------------------------------
// DRAWS A TEXT MENU VERTICALLY
// ------------------------------------------------------------------------------------------
function ____menu_text_vertical_draw(_x, _y, _menu_array, _cursor_pos,  _confirmed, _scale=1, _v_sep=35, _fnt=___global.___fnt_gallery){
	
	static prev_confirmed = false;
	static shake_timer_max = 15;
	static shake_timer = 0;
	static x_prev = _x;
	static y_prev = _y;
	
	_v_sep = _v_sep * _scale;
	
	// prevent wastefully shaking chars during menu movement
	var _moving = (x_prev != _x || y_prev != _y);
	x_prev = _x;
	y_prev = _y;
	
	var _store_halign = draw_get_halign();
	draw_set_halign(fa_center);
	
	for (var i = 0; i < array_length(_menu_array); i++){
		var _selected = (_cursor_pos == i);
		var _scale_final = 1 * _scale;
		var _txt = variable_struct_get(_menu_array[i], "text");
		var _is_disabled = (variable_struct_get(_menu_array[i], "action") == ___noop);
		draw_set_color(c_gbwhite);
		draw_set_font(_fnt);
		
		if (_selected){
			if (_confirmed){
				_txt = "<shake," + string(floor((shake_timer/2)*_scale)) + ">" + _txt;
				shake_timer = max(0, shake_timer - 1);
				draw_set_color(c_gbpink);
				_scale_final = 1.2 * _scale;
			} else {
				_txt = "<wave,1>" + _txt;
				draw_set_color(c_gbyellow);
			}
			
		}
		var _letter_spacing = 2 * _scale;
		___global.___draw_text_advanced(_x, _y, _v_sep, !_moving, true, _txt, 1, _scale_final, _letter_spacing);
		
		// strikethrough disabled menu items
		if (_is_disabled){
			var _str_count = string_length(_txt);
			var _str_w = string_width(___global.___string_strip_tags(_txt)) + ((_str_count-1) * _letter_spacing);
			var _overshoot = 5;
			var _line_y_center = _y + 9;
			var _thickness = 4;
			draw_rectangle_fix(
				_x - (_str_w/2) - _overshoot,
				_line_y_center - (_thickness/2),
				_x + (_str_w/2) + _overshoot,
				_line_y_center + (_thickness/2)
			);
		}
		
		
		_y += _v_sep;
	}
	draw_set_halign(_store_halign);
	if (prev_confirmed == false && _confirmed == true){
		shake_timer = shake_timer_max;
	}
	
	prev_confirmed = _confirmed;

}


// ------------------------------------------------------------------------------------------
// moves a value from 0-1 or 1-0 based on a true false value and a step count
// ------------------------------------------------------------------------------------------
function ___toggle_fade(_val, _is_show, _steps){
	if (_is_show){
		return min(1, _val + (1/_steps));
	} else {
		return max(0, _val - (1/_steps));
	}
}

// ------------------------------------------------------------------------------------------
// array shuffle
// ------------------------------------------------------------------------------------------
function ___array_shuffle(_array){
	var _ds_list = ds_list_create();
	var _new_array = [];
	for (var i = 0; i < array_length(_array); i++){
		_ds_list[| i] = _array[i];
	}
	ds_list_shuffle(_ds_list);
	for (var i = 0; i < ds_list_size(_ds_list); i++){
		array_push(_new_array, _ds_list[| i]);
	}
	ds_list_destroy(_ds_list);
	return _new_array;
}
