function LW_FGameLoader() constructor{

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
	
	function _get_filename_from_path(filename){
		var str = "";
		for(var i=1; i < string_length(filename) + 1; i++){
			var char = string_char_at(filename,i);
			if(char == "/"){
				str = "";	
				continue;
			}
			if(char == "."){
				return str;	
			}
			str += char;
		}
		return undefined;
	}
	
	function _read_game_config(filename, configs, rules){
		show_debug_message("INFO: reading game config " + filename);	

		var config = __try_read_json(filename);
		if(config == undefined){
			show_debug_message("WARNING: could not read json");	
			return;
		}
		var config_struct = {};
		var config_is_valid = true;
		for(var i=0; i < array_length(rules); i++){
			var rule = rules[i];
			
			if(rule.is_valid(config) == false && rule.get_is_nullable() == false){
				show_debug_message("WARNING: Invalid field " + rule.get_field_name());
				config_is_valid = false;
			}else{
				// if you really want verbose
				//show_debug_message("INFO: Set " + string(rule.get_field_name()) + " to " + string(rule.get_value(config_struct)));
				config_struct[$ rule.get_field_name()] = rule.get_value(config);
			}
		}
		
		if(config_is_valid == false){
			show_debug_message("ERROR: Could not load game config " + string(filename));
		}else if (!config_struct.is_enabled && ___global.test_vars.test_mode_on == false){
			show_debug_message("SKIP: " + string(filename) + " is not enabled");
			
		}
		else {
			configs[$  _get_filename_from_path(filename)] = config_struct;
			show_debug_message("INFO: Loaded " + string(filename) + "!");
		}
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
		if(variable_struct_exists(config, _field_name) == false){
			return false;
		}
		if(config[$ _field_name] == undefined){
			return false;
		}
		return _is_valid_internal(config[$ _field_name]);
	}
	
	get_value = function(config){
		if(is_valid(config)){
			return _get_value_internal(config[$ _field_name]);	
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
	
	_is_valid_internal = function(array){
		if (!is_array(array)){
			return false;	
		}
		if (_has_min && array_length(array) < _min){
			return false;	
		}
		
		for (var i = 0; i < array_length(array); i++){
			if(_inner_validator(array[i]) == false){
				return false;	
			}
		}
		
		return true;
	}
	
	_get_value_internal = function(array){
		return array;
	}
}

function LW_FGameLoaderStringArrayTransformer(field_name, default_value) : LW_FGameLoaderTransformer(field_name, default_value) constructor 
{	
	_is_valid_internal = function(val){
		if(is_string(val)){
			if(string_length(val) == 0){
				return false;	
			}
			return true;
		}
		if (!is_array(val)){
			return false;
		}
		if(array_length(val) == 0){
			return false;
		}
		for (var i = 0; i < array_length(val); i++){
			var _content = val[i];
			if (!is_string(_content)){
				return false;
			}
		}
		return true;
	}
	
	_get_value_internal = function(val) {
		if (is_string(val)){
			return [val];
		}
		return val;
	}
}

function LW_FGameLoaderColourTransformer(field_name, default_value) : LW_FGameLoaderTransformer(field_name, default_value) constructor 
{
	_base_validate = _is_valid_internal;
	
	_is_valid_internal = function(colour){
		if(is_string(colour)){
			var temp_colour = colour;
			
			var valid_hex_char = function(_char) {
				return string_pos(_char, "0123456789ABCDEFabcdef") != 0;
			}
			//id make this a method but no closures :(
			var first_char = string_char_at(colour, 1);
			if (first_char == "#" || first_char == "$")
				temp_colour = string_delete(temp_colour, 1, 1);
			if (string_copy(temp_colour, 1, 2) == "0x")
				temp_colour = string_delete(temp_colour, 1, 2);
			if (string_length(temp_colour) != 6)
				return false;
			
			for (var i = 1; i <= 6; i++)
				if (!valid_hex_char(string_char_at(temp_colour, i)))
					return false;
			return true;
			
		}
		if(array_length(colour) != 3){
			return false;	
		}
		for(var i=0; i < array_length(colour); i++){
			if(is_real(colour[i]) == false){
				return false;
			}
		}
		return true;
	}
	
	_get_value_internal  = function(colour){ 
		if(is_string(colour)){
			var first_char = string_char_at(colour, 1);
			if (first_char == "#" || first_char == "$")
				colour = string_delete(colour, 0, 1);
			if (string_copy(colour, 1, 2) == "0x")
				colour = string_delete(colour, 0, 2);
			
			var result=0;

			// special unicode values
			var ZERO=ord("0");
			var NINE=ord("9");
			var A=ord("A");
			var F=ord("F");

			for (var i=1; i<=string_length(colour); i++){
			    var c=ord(string_char_at(string_upper(colour), i));
			    // you could also multiply by 16 but you get more nerd points for bitshifts
			    result=result<<4;
			    // if the character is a number or letter, add the value
			    // it represents to the total
			    if (c>=ZERO&&c<=NINE){
			        result=result+(c-ZERO);
			    } else if (c>=A&&c<=F){
			        result=result+(c-A+10);
			    // otherwise complain
			    }
			}
			
			return result;
			
		}
		return make_colour_rgb(colour[0], colour[1], colour[2]);
	}
}