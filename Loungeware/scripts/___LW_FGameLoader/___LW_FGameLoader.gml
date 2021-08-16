function LW_FGameLoader() constructor{
	_rules = [];
	_games = {};
	
	set_rules = function(rules){
		_rules = rules;		
	}
	
	get_games = function()
	{
		return _games;	
	}
	
	load_game = function(game_name, meta){
		show_debug_message("INFO: Loading game config " + game_name);	

		var _game = {};
		var is_valid = true;
		for(var i=0; i < array_length(_rules); i++){
			var rule = _rules[i];
			
			if(rule.is_valid(meta) == false && rule.get_is_nullable() == false){
				show_debug_message("WARNING: Invalid field " + rule.get_field_name());
				config_is_valid = false;
			}else{
				// if you really want verbose
				//show_debug_message("INFO: Set " + string(rule.get_field_name()) + " to " + string(rule.get_value(config_struct)));
				_game[$ rule.get_field_name()] = rule.get_value(meta);
			}
		}
		
		if(is_valid == false){
			show_debug_message("ERROR: Could not load game config " + string(game_name));
			return false;
		}
		
		if (_game.is_enabled == false){
			show_debug_message("SKIP: " + string(game_name) + " is not enabled");
			return false;
		}
		
		_games[$  game_name] = _game;
		show_debug_message("INFO: Loaded " + string(game_name) + "!");
		return true;
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

function LW_FGameLoaderDateTransformer(field_name, default_value) : LW_FGameLoaderTransformer(field_name, default_value) constructor {
    monthNames = {
        january : 1, jan : 1,
        february : 2, feb : 2,
        march : 3, mar : 3,
        april : 4, apr : 4,
        may : 5,
        june : 6, jun : 6,
        july : 7, jul : 7,
        august : 8, aug : 8,
        september : 9, sep : 9, sept : 9,
        october : 10, oct : 10, spooky : 10,
        november : 11, nov : 11,
        december : 12, dec : 12, jolly : 12,
    };
    _is_valid_internal = function(val) {
        if (is_string(val)) {
            return string_length(val) > 0;
        } else if (is_struct(val)) {
            if not (variable_struct_exists(val, "day") &&
                    variable_struct_exists(val, "month") &&
                    variable_struct_exists(val, "year")) {
                return false;
            }
            var dd = val.day;
            var mm = val.month;
            var yy = val.year;
            return is_numeric(dd) && dd >= 1 && dd <= 99 &&
                    (is_numeric(mm) && mm >= 1 && mm <= 12 || is_string(mm) && variable_struct_exists(monthNames, string_lower(mm))) &&
                    is_numeric(yy) && (yy >= 2000 && yy <= 2099 || yy >= 0 && yy <= 99);
        } else {
            return false;
        }
    }
    _get_value_internal = function(val) {
        if (is_struct(val)) {
            var day = string_format(val.day, 2, 0);
            var month = string_format(is_string(val.month) ? monthNames[$ string_lower(val.month)] : val.month, 2, 0);
            var year = string_format(val.year >= 2000 ? val.year - 2000 : val.year, 2, 0);
            return string_replace_all(year + "/" + month + "/" + day, " ", "0");
        } else {
            return string(val);
        }
    }
}

function LW_FGameLoaderSoundTransformer(field_name, default_value) : LW_FGameLoaderTransformer(field_name, default_value) constructor 
{
	_is_valid_internal = function(sound_id){
		return audio_exists(sound_id);
	}
}

function LW_FGameLoaderRoomTransformer(field_name, default_value) : LW_FGameLoaderTransformer(field_name, default_value) constructor 
{	
	_is_valid_internal = function(room_id){
		return room_exists(room_id);
	}
}

function LW_FGameLoaderSpriteTransformer(field_name, default_value) : LW_FGameLoaderTransformer(field_name, default_value) constructor 
{
	_is_valid_internal = function(sprite_id){
		return sprite_exists(sprite_id);
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