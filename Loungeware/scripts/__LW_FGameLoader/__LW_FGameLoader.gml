function LW_FGameLoader() constructor{
	function _read_game_config(filename, configs, rules){
		show_debug_message("INFO: reading game config " + filename);	
	
		if(file_exists(filename) == false){
			show_debug_message("WARNING: No file " + filename);	
			return;
		}
	
		var file = file_text_open_read(filename);
		var str = "";
		while(file_text_eof(file) == false){
			var line =  file_text_readln(file);
			var comment_count = 0;
			for(var i=1; i < string_length(line) + 1; i++){
				var char = string_char_at(line, i);
				if(char == "/"){
					comment_count++;	
					if(comment_count == 2){
						break;	
					}
				}else{
					comment_count = 0;
					str = str + char;
				}
			}
		
			if(comment_count == 2){
				continue;	
			}
		}
		
		var config_map = json_decode(str)
		if(config_map < 0){
			show_debug_message("WARNING: could not read json");	
		}
		
		var config_struct = {};
		var config_is_valid = true;
		for(var i=0; i < array_length(rules); i++){
			var rule = rules[i];
			
			if(rule.is_valid(config_map) == false && rule.get_is_nullable() == false){
				show_debug_message("WARNING: Invalid field " + rule.get_field_name());
				show_message("WARNING: Invalid field " + rule.get_field_name());
				config_is_valid = false;
			}else{
				// if you really want verbose
				//show_debug_message("INFO: Set " + string(rule.get_field_name()) + " to " + string(rule.get_value(config_map)));
				config_struct[$ rule.get_field_name()] = rule.get_value(config_map);
			}
		}
		
		if(config_is_valid == false){
			show_debug_message("ERROR: Could not load game config " + string(filename));
		}else{
			configs[$ filename] = config_struct;
			show_debug_message("Info: Loaded " + string(filename) + "!");
		}

		ds_map_destroy(config_map);
	}

	function _get_directories(path, out){
		var search_path = path +"/*";
		var dir = file_find_first(search_path, fa_directory);
		var added = [];

		while(dir != ""){
			var full_path = path+"/"+dir;
			if(directory_exists(full_path)){
				out[@ array_length(out)] = full_path;
				added[@ array_length(added)] = full_path;
			}
			dir = file_find_next();
		}
		file_find_close();
	
		for(var i=0; i < array_length(added); i++){
			_get_directories(added[i], out);
		}
	
		return out;
	}

	function _get_json_files(path, out){
		var search_path = path+"/*.json";
		var filename = file_find_first(search_path, 0);

		while(filename != ""){
			var full_path = path+"/"+filename;
			out[@ array_length(out)] = full_path;
			filename = file_find_next();
		}
		file_find_close();	
		return out;
	}
	
	function get_configs(rules){
		var dirs = [];
		var jsons = [];
		var configs = {};
	
		_get_directories("games", dirs);
	
		for(var i=0; i < array_length(dirs); i++){
			_get_json_files(dirs[i], jsons);
		}
	
		for(var i=0; i < array_length(jsons); i++){
			_read_game_config(jsons[i], configs, rules);
		}
		return configs;
	}
}

function LW_FGameLoaderRuleBuilder() constructor 
{
	_rules = [];
	
	add_rule = function(rule){
		_rules[@ array_length(_rules)] = rule;	
		return self;
	}
	
	get_rules = function(){
		return _rules;	
	}
}

function LW_FGameLoaderTransformer(field_name, default_value) constructor 
{
	_field_name = field_name;
	_is_nullable = false;
	_default_value = default_value;
	_validators = [];
	
	is_valid = function(config){
		if(ds_map_exists(config, _field_name) == false){
			return false;	
		}
		if(config[? _field_name] == undefined){
			return false;	
		}
		return _is_valid_internal(config[? _field_name]);
	}
	
	get_value = function(config){
		if(is_valid(config)){
			return _get_value_internal(config[? _field_name]);	
		}
		return _default_value;
	}
	
	add_validator = function(validator){
		if(validator != undefined){
			_validators[@ array_length(_validators)] = validator;
		}
		return self;
	}
	
	set_nullable = function(){
		_is_nullable = true;
		return self;	
	}
	
	get_is_nullable = function(){ return _is_nullable; }
	
	get_field_name = function() { return _field_name; }
	
	_get_value_internal = function(val){
		return val;
	}
	
	_is_valid_internal = function(){
		return true;	
	}
}


function LW_FGameLoaderNumberTransformer(field_name, default_value) : LW_FGameLoaderTransformer(field_name, default_value) constructor 
{
	_has_min = false;
	_has_max = false;
	_min = 0;
	_max = 0;
	
	set_min = function(min_number) {
		_has_min = true;
		_min = min_number;
		return self;
	}
	
	set_max = function(max_number) {
		_has_max = true;
		_max = max_number;
		return self;
	}
	
	_is_valid_internal = function(number){
		if(_has_min && number < _min){
			return false;	
		}
		
		if(_has_max && number > _max){
			return false;	
		}
		
		return is_real(number);
	}
}

function LW_FGameLoaderStringTransformer(field_name, default_value) : LW_FGameLoaderTransformer(field_name, default_value) constructor 
{
	_is_valid_internal = function(val){
		if(is_string(val) == false){
			return false;	
		}
		if(string_length(val) == 0){
			return false;	
		}
		return true;
	}
	
	_get_value_internal = function(val) { return string(val); }
}

function LW_FGameLoaderAssetTransformer(field_name, default_value) : LW_FGameLoaderTransformer(field_name, default_value) constructor 
{
	_is_valid_internal = function(asset_name){
		if(is_string(asset_name) == false){
			return false;	
		}
		if(string_length(asset_name) == 0){
			return false;	
		}
		return true;
	}
	
	_get_value_internal = function(asset_name){ return asset_get_index(asset_name); }
}

function LW_FGameLoaderSoundTransformer(field_name, default_value) : LW_FGameLoaderAssetTransformer(field_name, default_value) constructor 
{
	_base_validate = _is_valid_internal;
	
	_is_valid_internal = function(asset_name){
		return _base_validate(asset_name) && (audio_get_name(asset_get_index(asset_name)) == asset_name);
	}
}

function LW_FGameLoaderRoomTransformer(field_name, default_value) : LW_FGameLoaderAssetTransformer(field_name, default_value) constructor 
{
	_base_validate = _is_valid_internal;
	
	_is_valid_internal = function(asset_name){
		return _base_validate(asset_name) && (room_get_name(asset_get_index(asset_name)) == asset_name);
	}
}

function LW_FGameLoaderSpriteTransformer(field_name, default_value) : LW_FGameLoaderAssetTransformer(field_name, default_value) constructor 
{
	_base_validate = _is_valid_internal;
	
	_is_valid_internal = function(asset_name){
		return _base_validate(asset_name) && (sprite_get_name(asset_get_index(asset_name)) == asset_name);
	}
}

function LW_FGameLoaderBoolTransformer(field_name, default_value) : LW_FGameLoaderTransformer(field_name, default_value) constructor 
{
	_base_validate = _is_valid_internal;
	
	_is_valid_internal = function(_bool){
		return  is_string(_bool) == false && is_real(_bool) && _bool == 0 || _bool == 1;
	}
}

function LW_FGameLoaderArrayTransformer(field_name, default_value) : LW_FGameLoaderTransformer(field_name, default_value) constructor 
{
	_has_min = false;
	_min = 0;
	_inner_validator = function(val){ return true; }
	
	set_inner_validator = function(inner_validator){
		_inner_validator = inner_validator;
		return self;
	}
	
	set_min = function(min_length){
		_has_min = true;
		_min = min_length;
		return self;
	}
	
	_is_valid_internal = function(list){
		if(list == undefined){
			return false;	
		}
		if(_has_min && ds_list_size(list) < _min){
			return false;	
		}
		
		for(var i=0; i < ds_list_size(list); i++){
			if(_inner_validator(list[| i]) == false){
				return false;	
			}
		}
		
		return true;
	}
	
	_get_value_internal = function(list){
		var arr = [];
		for(var i=0; i < ds_list_size(list); i++){
			arr[i] = list[| i];
		}
		return arr;
	}
}

function LW_FGameLoaderColourTransformer(field_name, default_value) : LW_FGameLoaderTransformer(field_name, default_value) constructor 
{
	_base_validate = _is_valid_internal;
	
	_is_valid_internal = function(colour){
		if(is_string(colour)){
			show_error("I didn't write hex yet. someone please do this if you want this feature", false);
			return false;
		}else {
			if(ds_list_size(colour) != 3){
				return false;	
			}
			for(var i=0; i < ds_list_size(colour); i++){
				if(is_real(colour[| i]) == false){
					return false;
				}
			}
		}
		return true;
	}
	
	_get_value_internal  = function(colour){ 
		if(is_string(colour)){
			show_error("I didn't write hex yet. someone please do this if you want this feature", false);
			return make_colour_rgb(255, 255, 255);
		}else{
			if(ds_list_size(colour) != 3){
				return make_colour_rgb(255, 255, 255);	
			}
			return make_colour_rgb(colour[| 0], colour[| 1], colour[| 2]);
		}
	}
}