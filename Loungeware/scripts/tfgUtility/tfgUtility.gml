/// @desc Calls some procedure for each element of an array.
/// @param {array} variable The array to apply the function tfg_to.
/// @param {script} f The function tfg_to apply to all elements in the array.
/// @param {int} [n] The number of elements to loop through.
/// @param {int} [i=0] The index of the array to start at.
///@author Katsaii
///@func tfg_array_foreach(array, func)
function tfg_array_foreach(_array, _f) {
	var count = argument_count > 2 ? argument[2] : array_length(_array);
	var start = argument_count > 3 ? argument[3] : 0;
	for (var i = 0; i < count; i += 1) {
		_f(_array[start + i]);
	}
}

///@desc Calls some procedure for each element of a list
///@author Katsaii
///@func tfg_ds_list_foreach(list, func)
function tfg_ds_list_foreach(_list, _f) {
	var count = argument_count > 2 ? argument[2] : ds_list_size(_list)
	var start = argument_count > 3 ? argument[3] : 0;
	for (var i = 0; i < count; i += 1) {
		_f(_list[| start + i]);
	}
}

/// @desc Calls some procedure for each key-value pairs of a struct.
/// @param {struct} struct The struct to apply the function tfg_to.
/// @param {script} f The function tfg_to apply.
/// @author Katsaii
function tfg_struct_foreach(_struct, _f) {
	var count = variable_struct_names_count(_struct);
	var names = variable_struct_get_names(_struct);
	for (var i = count - 1; i >= 0; i -= 1) {
		var key = names[i];
		var val = variable_struct_get(_struct, key);
		_f(key, val);
	}
}

/// @func tfg_array_create_nd(size1, size2,...)
function tfg_array_create_nd() {
    if (argument_count == 0) return 0;
    
    var _array = array_create(argument[0]),
        _args  = array_create(argument_count-1),
        _i;
        
    _i = 0; repeat(argument_count-1) {
        _args[@ _i] = argument[_i+1];
        ++_i;
    }
    
    _i = 0; repeat(argument[0]) {
        _array[@ _i] = script_execute_ext(array_create_nd, _args);
        ++_i;
    }
    
    return _array;
}

/// @func		approach(val1, val2, amount)
/// @param		{real}	 val1				Initial value
/// @param		{real}	 val2				Target value
/// @param		{real}	 amount				Increment (or Decrement)
/// @returns	{real}						Changed value
/// @author		Meseta
function tfg_approach(_val1, _val2, _inc) {
	if (_inc < 0) throw("approach: amount is negative")
	return (_val1 + clamp(_val2-_val1, -_inc, _inc));
}

///@func tfg_chance(percent)
///@param {real} percent			percentage on scale 0-1
///@returns {bool} chance			i can't think of what to write here
function tfg_chance(_percent){
	//chance(0.7) returns true 70% of time
	return _percent > random(1)
}

/// @func		animation_end()
/// @returns	{bool}						Whether sprite_index has finished animating or not
/// @author		Minty Python
function tfg_animation_end() {
	return (image_index + image_speed*sprite_get_speed(sprite_index)/(sprite_get_speed_type(sprite_index)==spritespeed_framespergameframe? 1 : game_get_speed(gamespeed_fps)) >= image_number);	
}

/// @func tfg_draw_set_text(colour, font, halign, valign)
///@param {real}			colour
///@param {real}			font
///@param {real}			halign
///@param {real}			valign
///@returns					N/A
function tfg_draw_set_text(_colour, _font, _halign, _valign){
	draw_set_colour(_colour)
	draw_set_font(_font)
	draw_set_halign(_halign)
	draw_set_valign(_valign)
}

/// @func tfg_string_wrap(string, max_width)
///@param {string} string			string to be wrapped
///@param {real} max_width			string WIDTH (not length) to wrap after
///@returns {string}				wrapped string
function tfg_string_wrap(_str, _max_width){
	var _str_len = string_length(_str)
	var _last_space = 1
	
	var _count = 1
	var _sub_str
	
	repeat (_str_len){
		_sub_str = string_copy(_str, 1, _count)
		if (string_char_at(_str, _count) == " ") _last_space = _count
		
		if (string_width(_sub_str) > _max_width){
			_str = string_delete(_str, _last_space, 1)
			_str = string_insert("\n", _str, _last_space)
		}
		_count++
	}
	return _str
}

/// @func tfg_nine_slice_box_stretched(sprite, x1, y1, x2, y2, index)
///@arg sprite
///@arg x1 left
///@arg y1 top
///@arg x2 rigt
///@arg y2 bottom
///@arg index image index
function tfg_nine_slice_box_stretched(sprite, x1, y1, x2, y2, index){
	var _size = sprite_get_width(argument0) / 3;
	var _x1 = argument1;
	var _y1 = argument2;
	var _x2 = argument3;
	var _y2 = argument4;
	var _index = argument5;
	var _w = _x2 - _x1;
	var _h = _y2 - _y1

	//MIDDLE
	draw_sprite_part_ext(argument0, _index, _size, _size, 1, 1, _x1 + _size,_y1 + _size, _w - (_size * 2), _h - (_size * 2), c_white,1);

	//CORNERS
	//TOP LEFT
	draw_sprite_part(argument0, _index, 0, 0, _size, _size, _x1, _y1);
	//TOP RIGHT
	draw_sprite_part(argument0, _index, _size * 2, 0, _size, _size, _x1 + _w - _size, _y1);
	//BOTTOM LEFT
	draw_sprite_part(argument0, _index, 0, _size * 2, _size, _size, _x1, _y1 + _h - _size);
	//BOTTOM RIGHT
	draw_sprite_part(argument0, _index, _size * 2, _size * 2, _size, _size, _x1 + _w - _size, _y1 + _h - _size);

	//EDGES
	//LEFT
	draw_sprite_part_ext(argument0, _index, 0, _size, _size, 1, _x1, _y1 + _size, 1, _h - (_size * 2), c_white, 1);
	//RIGHT
	draw_sprite_part_ext(argument0, _index, _size * 2, _size, _size, 1, _x1 + _w - _size, _y1 + _size, 1, _h - (_size * 2), c_white, 1);
	//TOP
	draw_sprite_part_ext(argument0, _index, _size, 0, 1, _size, _x1 + _size, _y1, _w - (_size * 2), 1, c_white, 1);
	//BOTTOM
	draw_sprite_part_ext(argument0, _index, _size, _size * 2, 1, _size, _x1 + _size, _y1 + _h - (_size), _w - (_size * 2), 1, c_white,1);
}

/// @func tfg_str_split(string, delimiter)
///@author YellowAfterLife
function tfg_str_split(s, d){
    if (0) return argument[0]
    var r = []
    var p = string_pos(d, s), o = 1;
    var dl = string_length(d);
    if (dl) while (p) {
        array_push(r, string_copy(s, o, p - o));
        o = p + dl;
        p = string_pos_ext(d, s, o);
    }
    array_push(r, string_delete(s, 1, o - 1));
    return r;
}

/// @func tfg_array_reverse(array, start, end)
function tfg_array_reverse(_array, _start, _end){
	if (0) return argument[0];
	if (is_undefined(_start)) _start = 0;
	if (is_undefined(_end)) _end = array_length(_array) - 1;
	
    while (_start < _end){
        var _temp = _array[_start]
        _array[_start] = _array[_end]
        _array[_end] = _temp
        _start++
        _end--
    }
	
	return _array;
}

/// @func tfg_array_count(array, what)
function tfg_array_count(_array, _what) {
    var _count = 0;
    for (var i = 0; i < array_length(_array); i++) {
        if (_array[i] == _what) {
            _count++;
        }
    }
    return _count
}

function tfg_wave(from, to, duration, offset){
	//Wave(from, to, duration, offset)
 
	// Returns a value that will wave back and forth between [from-to] over [duration] seconds
	// Examples
	//      image_angle = Wave(-45,45,1,0)  -> rock back and forth 90 degrees in a second
	//      x = Wave(-10,10,0.25,0)         -> move left and right quickly
 
	// Or here is a fun one! Make an object be all squishy!! ^u^
	//      image_xscale = Wave(0.5, 2.0, 1.0, 0.0)
	//      image_yscale = Wave(2.0, 0.5, 1.0, 0.0)
 
	a4 = (argument1 - argument0) * 0.5;
	return argument0 + a4 + sin((((current_time * 0.001) + argument2 * argument3) / argument2) * (pi*2)) * a4;
}

/// @func tfg_frames_to_ms(frames)
function tfg_frames_to_ms(_f){
	return 1000 * _f / FPS
}

///@func tfg_in(value, array)
function tfg_in(value, array) {
	for (var i = 0; i < array_length(array); i++){
		if (value == array[i]) return true
	}
	return false
}

///@func tfg_len(what)
function tfg_len(_what){
	if (is_array(_what)) return array_length(_what)
	else if (is_string(_what)) return string_length(_what)
	else if (ds_exists(_what, ds_type_list)) return ds_list_size(_what)
	else throw "len: type not supported!"
}

#macro round __round_not_bankers
function tfg___round_not_bankers(_val){
	var num = _val div 1
	return _val mod 1 >= 0.5 ? num + 1 : num
}

///@func tfg_place_meeting_array(x, y, array)
function tfg_place_meeting_array(_x, _y, _array){
	for (var _i = 0; _i < array_length(_array); _i++){
		if (place_meeting(_x, _y, _array[_i])) return true
	}
	return false
}

///@func tfg_array_find_index(array, what)
function tfg_array_find_index(_array, _what){
	for (var _i = 0; _i < array_length(_array); _i++){
		if (_array[_i] == _what) return _i
	}
	return undefined
}

///@func tfg_mod2(value, divisor)
function tfg_mod2(value, divisor) {
	return value - floor(value/divisor) * divisor;
}

/// @func tfg_str_wrap(string, max_width)
///@param {string} string            string to be wrapped
///@param {real} max_width            string WIDTH (not length) to wrap after
///@returns {string}                wrapped string
function tfg_str_wrap(_str, _max_width){
    var _str_len = string_length(_str)
    var _last_space = 1
    
    var _count = 1
    var _sub_str
    
    repeat (_str_len){
        _sub_str = string_copy(_str, 1, _count)
        if (string_char_at(_str, _count) == " ") _last_space = _count
        
        if (string_width(_sub_str) > _max_width){
            _str = string_delete(_str, _last_space, 1)
            _str = string_insert("\n", _str, _last_space)
        }
        _count++
    }
    return _str
}

///@func tfg_array_filter(array, callback)
function tfg_array_filter(_array, _callback) {
	var ret = [];
		
	for (var i = 0; i < array_length(_array); i++) {
		if (_callback(_array[i]))
			array_push(ret, _array[i]);
	}
		
	return ret;	
}

///@func tfg_array_to_str(array)
function tfg_array_to_str(_array) {
	var str = "";
	for (var i = 0; i < array_length(_array); i++) {
		str += _array[i];	
	}
	return str;
}

///@func tfg_str_ltrim(str)
//
//  Returns the given string with whitespace stripped from its start.
//  Whitespace is defined as SPACE, HT, LF, VT, FF, CR.
//
//      str         string of text, string
//
/// GMLscripts.com/license
function tfg_str_ltrim(str) {
    var l,r,o;
    l = 1;
    r = string_length(str);
    repeat (r) {
        o = ord(string_char_at(str,l));
        if ((o > 8) && (o < 14) || (o == 32)) l += 1;
        else break;
    }
    return string_copy(str,l,r-l+1);
}

