function ___GAME_INIT(){
	randomize();
	instance_create_layer(0, 0, layer, ___global);
	
	___global.window_base_size = 540;
	
	// font
	___global.___fnt_gallery = font_add_sprite_ext(___spr_frogtype_midscale, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!\"$^&*%[]{}()+=-_?/@'£#|¬.,><", false, 0);
	
	// colours
	___global.macro_c_magenta = make_color_rgb(255, 0, 255);
	___global.macro_c_gbyellow = make_color_rgb(241, 154, 82);
	___global.macro_c_gbpink = make_color_rgb(200, 85, 78);
	___global.macro_c_gbblack = make_color_rgb(26, 23, 33);
	___global.macro_c_gbblack = make_color_rgb(26, 23, 33);
	___global.macro_c_gboff = make_color_rgb(31, 27, 37);
	___global.macro_c_cart_primary = make_color_rgb(89, 51, 100);
	___global.macro_c_cart_secondary = make_color_rgb(38, 30, 66);
	___global.macro_c_gbacklight = make_color_rgb(40,33,49);
	___global.macro_c_gbtimer_full = make_color_rgb(160, 49, 88);
	___global.macro_c_gbtimer_empty = make_color_rgb(52, 41, 79);
	___global.macro_c_gbwhite = make_color_rgb(255, 200, 156);
	___global.macro_c_larold = make_color_rgb(228, 181, 129);
	
	// musical credits

	
	// default inputs
	___global.default_input_keys = {
		right: [vk_right, ord("D")],
		up: [vk_up, ord("W")],
		left: [vk_left, ord("A")],
		down: [vk_down, ord("S")],
		primary: [ord("X"), ord("L")],
		secondary: [ord("Z"), ord("K")],
		pause: [vk_escape, vk_enter],
	}
	___global.default_controller_keys = {
		right: [gp_padr],
		up: [gp_padu],
		left: [gp_padl],
		down: [gp_padd],
		primary: [gp_face1],
		secondary: [gp_face2],
		pause: [gp_start],
	}
	
	___global.default_controller_axes = {
		horizontal: [gp_axislh],
		vertical: [gp_axislv],
	}
	
	___global.controller_values = [];
	for (var i=0;i<gamepad_get_device_count();i++) {
		var connected = gamepad_is_connected(i);
		___global.controller_values[i] = {
			active: connected,
			axes: {
				horizontal: 0,
				vertical: 0,
			},
			state: {
				pressed: {
					up: false,
					down: false,
					left: false,
					right: false,
					primary: false,
					secondary: false,
					pause: false,
				},
				held: {
					up: false,
					down: false,
					left: false,
					right: false,
					primary: false,
					secondary: false,
					pause: false,
				},
				released: {
					up: false,
					down: false,
					left: false,
					right: false,
					primary: false,
					secondary: false,
					pause: false,
				}
			}
		}
	}
	
	// default volume
	___global.default_vol = { sfx: 1, msc: 1, master: 1, }
	
	var _version = "0.1.0";
	___global.max_microgame_time = 12;
	___global.save_filename = "dot.dot";
	___global.microgame_metadata = ___init_metadata();
	___global.difficulty_level = 1;
	___global.difficulty_max = 5;
	___global.difficulty_read = function(){return ___global.difficulty_level;}
	___global.volume_read = function(_prop_name){return variable_struct_get(___global.save_data.vol, _prop_name);}
	___global.window_base_size_read = function(){return ___global.window_base_size;}
	___global.time_remaining_read = function(){return ___MG_MNGR.microgame_timer}
	___global.time_max_read = function(){return ___MG_MNGR.microgame_timer_max}
	___global.test_mode_check = function(){return ___global.test_vars.test_mode_on;}
	
	// add public songs to credits
	var _is_public_music = false;
	var _metadata_all = ___global.microgame_metadata;
	var _microgame_keys = variable_struct_get_names(_metadata_all);
	for (var i = 0; i < array_length(_microgame_keys); i++){
		var _data = variable_struct_get(_metadata_all, _microgame_keys[i]);
		var _credits = _data.credits;
		var _music_name = audio_get_name(_data.music_track);
		_is_public_music = string_copy(_music_name, 1, 4) == "sng_";
		
		if (_is_public_music){
			_music_name = string_replace(_music_name, "sng_", "");
			var _insert = 1;
			while(string_char_at(_music_name, _insert) != "_"){
				_insert++;
				if (_insert > string_length(_music_name)){
					break;
				}
			}
			_music_name = string_copy(_music_name, 1, _insert-1);
			// check if name was already in credits
			var _name_already_exists = false;
			for (var j = 0; j < array_length(_credits); j++){
				if (string_upper(_music_name) == string_upper(_credits[j])) _name_already_exists = true;
			}
			if (!_name_already_exists) array_push(_credits, _music_name);
			
		
		}
	

}
	
	// load save data if exists
	___global.save_data = {};
	if (file_exists(___global.save_filename)){
		var _file = file_text_open_read(___global.save_filename);
		var _str = file_text_read_string(_file);
		___global.save_data = json_parse(_str);
		file_text_close(_file);
	} 
	
	var _default_save_data = {
		version: _version,
		best_score: 0,
		microgame_data: {},
		vol: ___global.default_vol,
		input_keys: ___global.default_input_keys,
		data_collection: false,
	}
	
	//update version number
	___global.save_data.version = _version;
	
	// compare save data against defaults, set any properties that are missing from save data
	var _default_save_data_props = variable_struct_get_names(_default_save_data);
	for (var i = 0; i < array_length(_default_save_data_props); i++){
		var _prop_name = _default_save_data_props[i];
		var _default_val = variable_struct_get(_default_save_data, _prop_name);
		if (!variable_struct_exists(___global.save_data, _prop_name)) variable_struct_set(___global.save_data, _prop_name, _default_val);
	}
		
	// IF NO SAVE DATA, GO TO ROOM THAT ASKS FOR DATA COLLECTION CONSENT (AND POSSIBLY NAME FOR LEADERBOARDS)
	
	// add any new games to stat data (from save file), or add all games if there was no save file
	var _metadata_props = variable_struct_get_names(___global.microgame_metadata);
	for (var i = 0; i < array_length(_metadata_props); i++){
		var _prop_name = _metadata_props[i];
		if (!variable_struct_exists(___global.save_data.microgame_data, _prop_name)){
			var _data = {
				play_count: 0,
				wins: 0,
				best_time: 10000000,
			}
			variable_struct_set(___global.save_data.microgame_data, _prop_name, _data);
		}
	}
	
	// save
	___save_game();
	
	// check for updates with more games (to do)
	
	// set default input keys
	___global.input_keys = {
		right: vk_right,
		up: vk_up,
		left: vk_left,
		down: vk_down,
		primary: ord("Z"),
		secondary: ord("Y")
	}
	
	if (___global.test_vars.test_mode_on){
		room_goto(___rm_restroom);
		instance_create_layer(0, 0, layer, ___MG_MNGR);
	} else {
		room_goto(___rm_main_menu);
		instance_create_layer(0, 0, layer, ___obj_title_screen);
	}
	
}

function ___save_game(){
	var _str = json_stringify(___global.save_data);
	//var _file = file_text_open_write(___global.save_filename);
	//file_text_write_string(_file, _str);
	//file_text_close(_file);
}




