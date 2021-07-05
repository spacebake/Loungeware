function ___GAME_INIT(){
	
	instance_create_layer(0, 0, layer, ___global);
	instance_create_layer(0, 0, layer, ___fake_global);
	___global.window_base_size = 540;
	
	// colours
	___global.macro_c_magenta = make_color_rgb(255, 0, 255);
	___global.macro_c_gbyellow = make_color_rgb(241, 154, 82);
	___global.macro_c_gbpink = make_color_rgb(200, 85, 78);
	___global.macro_c_gbblack = make_color_rgb(26, 23, 33);
	___global.macro_c_gboff = make_color_rgb(31, 27, 37);
	___global.macro_c_cart_primary = make_color_rgb(89, 51, 100);
	___global.macro_c_cart_secondary = make_color_rgb(38, 30, 66);
	___global.macro_c_gbacklight = make_color_rgb(40,33,49);
	___global.macro_c_gbtimer_full = make_color_rgb(160, 49, 88);
	___global.macro_c_gbtimer_empty = make_color_rgb(52, 41, 79);
	___global.macro_c_gbwhite = make_color_rgb(255, 200, 156);
	
	// default inputs
	___global.default_input_keys = {
		right: [vk_right, ord("D")],
		up: [vk_up, ord("W")],
		left: [vk_left, ord("A")],
		down: [vk_down, ord("S")],
		primary: [ord("Z"), ord("K")],
		secondary: [ord("X"), ord("L")],
		pause: [vk_escape, vk_enter],
	}
	// default volume
	___global.default_vol = { sfx: 1, msc: 1,master: 1, }
	
	var _version = "0.1.0";
	___global.max_microgame_time = 12;
	___global.save_filename = "dot.dot";
	___global.microgame_metadata = ___init_metadata();
	___global.difficulty_level = 1;
	___global.difficulty_read = function(){return ___global.difficulty_level;}
	___global.volume_read = function(_prop_name){return variable_struct_get(___global.save_data.vol, _prop_name);}
	___global.window_base_size_read = function(){return ___global.window_base_size;}
	___global.time_remaining_read = function(){return ___GM.microgame_timer}
	___global.time_max_read = function(){return ___GM.microgame_timer_max}
	
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
	
	instance_create_layer(0, 0, layer, ___GM);
	
	// options
	___GM.opt_gameboy_button_animation = false;
	___GM.opt_gameboy_screen_shadow = false;
	
}

function ___save_game(){
	var _str = json_stringify(___global.save_data);
	//var _file = file_text_open_write(___global.save_filename);
	//file_text_write_string(_file, _str);
	//file_text_close(_file);
}




