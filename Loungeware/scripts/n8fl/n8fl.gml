function n8fl_impossible_move_to(current, dest, spd){
	var n = current + (dest-current) * ((1/(60*(spd/4))));	
	if(abs(n-current) < 0.001){
		return dest;	
	}
	return n;
}

function n8fl_bbox_middle(inst){
	return new n8fl_FVector(
		inst.bbox_left + (inst.bbox_right - inst.bbox_left)/2,
		inst.bbox_top + (inst.bbox_bottom - inst.bbox_top)/2,
	);
}


function n8fl_draw_bbox(inst){
	draw_rectangle(inst.bbox_left, inst.bbox_top, inst.bbox_right, inst.bbox_bottom, true);	
}


function n8fl_FDelegate(handler) constructor
{
	_handlers = ds_list_create();
	_once_list = ds_list_create();
	ds_list_add(_handlers, handler);	
	
	add = function(handler){
		if(ds_list_find_index(_handlers, handler) > 0){
			return false;	
		}
		ds_list_add(_handlers, handler);	
		return true;
	}
	
	remove = function(handler){
		var did_delete = false;
		var index = ds_list_find_index(_handlers, handler);
		if(index >= 0){
			ds_list_delete(_handlers, index);	
			did_delete = true;
		}
		
		index = ds_list_find_index(_once_list, handler);
		if(index >= 0){
			ds_list_delete(_once_list, index);	
			did_delete = false;
		}
	}
	
	invoke = function(args){
		for(var i=0; i < ds_list_size(_handlers); i++){
			_handlers[| i](args);	
		}
		
		for(var i=0; i < ds_list_size(_once_list); i++){
			_once_list[| i](args);
		}
		ds_list_clear(_once_list);
	}
	
	once = function(handler){
		if(ds_list_find_index(_once_list, handler) > 0){
			return false;	
		}
		ds_list_add(_once_list, handler);	
		return true;
	}
}

function n8fl_FWave(freq, amp) constructor
{
	_freq = freq;
	_amp = amp;
	_offset = random_range(100,1000);
	_time = 0;
	_delta = 0;
	_tick = 0;
	_playspeed = 0;
	
	play = function(){
		_playspeed = 1;	
	}
	
	pause = function(){
		_playspeed = 0;
	}
	
	reset = function(){
		
	}
	
	is_playing = function(){
		return _playspeed != 0;	
	}
	
	get_time_normalized = function(){
		return abs(_time) / _freq;	
	}
	
	/// deprecated - use get_value
	value = function(){
		return get_value();
	}
	
	update = function(){
		if(_tick != global.n8fl_tick){
			var last_time = _time;
			_time += (1 / (60 * (_freq / 2))) * _playspeed;
			_delta = _time - last_time;
			_tick = global.n8fl_tick;
		}
	}
	
	get_value = function(){
		update();
		var t = (_time + _offset) % 360;
		return sin(t) * _amp;
	}
	
	get_delta = function(){
		update();
		var _last = sin((_time - _delta + _offset) % 360) * _amp;
		var _current = sin(((_time + _offset) % 360)) * _amp;
		return _current - _last;
	}
	
	get_delta_one = function(){
		update();
		var _last = ((1 + sin((_time - _delta + _offset) % 360)) / 2) * _amp;
		var _current = (( 1 + sin((_time + _offset) % 360)) / 2) * _amp;
		return _current - _last;
	}
	
	get_value_one = function(){
		update();
		var t = (_time + _offset) % 360;
		return ((1 + sin(t)) / 2) * _amp;
	}
	
	get_amp = function() { return _amp; }
	set_amp = function(amp) { _amp = amp; }
	get_offset = function() { return _offset; }
	set_offset = function(offset) { _offset = offset; }
} 

enum n8fl_ETween {
	Linear,
	EaseInOut,
	EaseOutElastic,
	EaseInOutElastic
}

function n8fl_FTween(start, dest, duration) constructor
{
	_start = start;
	_dest = dest;
	_duration = duration;
	_play_speed = 0;
	_last_play_speed = 0;
	_time = 0;
	_tick = 0;
	_type = n8fl_ETween.EaseInOut;
	
	completed = new n8fl_FDelegate(function(){});
	started = new n8fl_FDelegate(function(){});
	
	_is_started = false;
	_is_completed = false;
	
	get_start = function(){ return _start; }
	set_start = function(start) { _start = start; }
	get_dest = function() { return _dest; }
	set_dest = function(dest) { _dest = dest; }
	get_duration = function() { return _duration; }
	set_duration = function(duration){ _duration = duration; }
	set_playspeed = function(playspeed) { _playspeed = playspeed; }
	get_type = function() { return _type; }
	set_type = function(type) { type = _type; }
	
	normalized_value = function(){
		update();
		var t = _time / _duration;
		switch(_type){
			case n8fl_ETween.EaseInOut: return -(cos(pi * t) - 1) / 2;
			case n8fl_ETween.EaseOutElastic:
				var c4 = (2 * pi) / 4;

				return t == 0 ? 0 : (t == 1 ? 1 : power(2, -10 * t) * sin((t * 10 - 0.75) * c4) + 1);
			case n8fl_ETween.EaseInOutElastic:
				if(t == 0) return 0;
				
				var c5 = (2 * pi) / 5.5;
				
				if(t == 1){
					return 1;	
				}
				
				return  t < 0.5
				  ? -(power(2, 20 * t - 10) * sin((20 * t - 11.125) * c5)) / 2
				  : (power(2, -20 * t + 10) * sin((20 * t - 11.125) * c5)) / 2 + 1;
				
		}
		return t;
	}
	
	value = function(){
		var t = normalized_value();
		return lerp(_start, _dest, t);
	}
	
	update = function(){
		if(_play_speed == 0){
			return;	
		}
		if(_tick != global.n8fl_tick){

			if(_time == 0 && _is_started == false){
				_is_started = true;
				started.invoke(self);
			}
			
			if((_time / _duration >= 1) && _is_completed == false){
				_is_completed = true;
				completed.invoke(self);
			}
			
			_is_completed = _time / _duration >= 1;
			
			_time += (1/60) * _play_speed;
			_time = clamp(_time, 0, _duration);
			_tick = global.n8fl_tick;
		}
	}
	
	play = function(){
		if(argument_count > 0){
			_play_speed = argument[0];	
		}else{
			_last_play_speed = _last_play_speed == 0 ? 1 : _last_play_speed;
			_play_speed = _last_play_speed;
		}
		_last_play_speed = _play_speed;
	}
	
	pause = function(){
		if(_play_speed == 0){
			_last_play_speed = _last_play_speed == 0 ? 1 : _last_play_speed;
		}else{
			_last_play_speed = 1;	
		}
		_play_speed = 0;	
	}
	
	reset = function(){
		_play_speed = 0;
		_last_play_speed = 0;
		_tick = 0;
		_time = 0;
		_is_started = false;
		_is_completed = false;
	}
	
	is_playing = function(){
		return _is_started && _is_completed == false;	
	}
}

function n8fl_FOptional() constructor 
{
	_value = undefined;
	_has_value = false;
	
	static set = function(val){
		_has_value = true;
		_value = val;
	}
	
	static get = function(){
		return _value;	
	}
	
	static reset = function(){
		_value = undefined;
		_has_value = false;
	}
	
	static has_value = function(){
		return _has_value;	
	}
}

function n8fl_FTransform(x, y) constructor 
{
	_x = x;
	_y = y;
	_parent = undefined;
	
	get_parent = function(){ return _parent; }
	set_parent = function(parent){
		if(parent == _parent){
			return;	
		}
		
		var valid_next_parent = parent != undefined && ( is_struct(parent) || instance_exists(parent));
		var valid_current_parent = _parent != undefined && ( is_struct(_parent) || instance_exists(_parent))
		if(valid_current_parent){
			var pos = get_pos();
			_parent = undefined;
			_x = pos._x;
			_y = pos._y;
		}
		
		if(valid_next_parent){
			var pos = get_pos();
			_parent = parent;
			set_pos_v(pos);
		}
		
		_parent = parent; 
	}
	get_local_pos = function(){ return new n8fl_FVector(_x, _y); }
	set_local_pos_f = function(x,y){
		_x = x;
		_y = y;
	}
	set_local_pos_v = function(vector){
		_x = vector._x;
		_y = vector._y;
	}
	get_pos = function(){ 
		var local_pos = get_local_pos();
		var parent_pos = new n8fl_FVector(0, 0);
		if(_parent != undefined){
			if(is_struct(_parent) || instance_exists(_parent)){
				parent_pos = _parent.get_pos();
			}
		}
		local_pos.add_v(parent_pos);
		return local_pos;
	}
	get_x = function(){ return get_pos().get_x(); }
	get_y = function(){ return get_pos().get_y(); }
	set_x = function(x){ set_pos_f(x, get_pos().get_y());}
	set_y = function(y){ set_pos_f(get_pos().get_x(), y);}
	set_pos_f = function(x, y){
		var world_pos = new n8fl_FVector(x, y);	
		world_pos.subtract_v(get_parent_pos());
		_x = world_pos.get_x();
		_y = world_pos.get_y();
	}	
	set_pos_v = function(v){ set_pos_f(v._x, v._y); }
	get_parent_pos = function(){
		var parent_pos = new n8fl_FVector(0, 0);
		if(_parent != undefined){
			if(is_struct(_parent) || instance_exists(_parent)){
				parent_pos = _parent.get_pos();
			}
		}
		return parent_pos;
	}
}

function n8fl_FLabel() : n8fl_FTransform(0,0) constructor 
{
	_text = "";
	_colour = c_white;
	_font = fnt_frogtype;
	_valign = fa_left;
	_halign = fa_top;
	_padding = new n8fl_FPadding(0, 0, 0, 0);
	_xscale = 1;
	_yscale = 1;
	_angle = 0;
	_alpha = 1;
	_max_width = new n8fl_FOptional();
	_max_width_sep = new n8fl_FOptional();
	
	draw_set = function(){
		draw_set_halign(_halign);
		draw_set_valign(_valign);
		draw_set_font(_font);
		draw_set_colour(_colour);
		draw_set_alpha(_alpha);
	}
	
	draw = function(){
		draw_set();
		var pos = get_pos().add_f(_padding.get_left(), _padding.get_top());
		if(_max_width.has_value() && _max_width_sep.has_value()){
			draw_text_ext_transformed(
				pos.get_x(),
				pos.get_y(),
				_text,
				_max_width_sep.get(),
				_max_width.get(),
				_xscale,
				_yscale,
				_angle
			);
		}else{
			draw_text_transformed(
				pos.get_x(), 
				pos.get_y(), 
				_text,
				_xscale,
				_yscale,
				_angle
			);
		}
	}
	
	draw_debug = function(){
		var pos = get_pos();
		var width = get_string_width();
		var height = get_string_height();
		draw_set_color(c_red);
		draw_rectangle(
			pos.get_x(), 
			pos.get_y(), 
			pos.get_x() + width, 
			pos.get_y() + height, 
			true
		);
		
		
		//draw_set_color(c_green);
		//draw_rectangle(
		//	pos.get_x() + _padding.get_left(), 
		//	pos.get_y() + _padding.get_top(), 
		//	pos.get_x() + width, 
		//	pos.get_y() + height, 
		//	true
		//);
	}
	
	get_text = function(){ return _text; }
	set_text = function(text){ _text = text; }
	get_colour = function(){ return _colour; }
	set_colour = function(colour){ _colour = colour; }
	get_halign = function(){ return _halign; }
	set_halign = function(halign){ _halign = halign; }
	get_valign = function(){ return _valign; }
	set_valign = function(valign){ _valign = valign; }	
	set_scale = function(xscale, yscale){
		_xscale = xscale;
		_yscale = yscale;
	}
	
	set_padding_f = function(left, top, right, bottom){
		_padding.set_left(left);
		_padding.set_right(right);
		_padding.set_top(top);
		_padding.set_bottom(bottom);
	}
	
	set_max_width = function(width, sep){
		_max_width.set(width);
		_max_width_sep.set(sep);
	}
	
	clear_max_width = function(){
		_max_width.reset();
		_max_width_sep.reset();
	}
	
	get_string_width = function(){
		draw_set();
		return string_width(_text) * _xscale + _padding.get_left() + _padding.get_right();
	}
	
	get_string_height = function(){
		draw_set();
		return string_height(_text) * _yscale + _padding.get_top() + _padding.get_bottom();
	}
	
	get_padding = function(){ return _padding; }
}

function n8fl_FPadding(left, top, right, bottom) constructor
{
	_left = left;
	_top = top;
	_right = right;
	_bottom = bottom;
	
	set_left = function(left){ _left = left; }
	set_top = function(top){ _top = top; }
	set_right = function(right){ _right = right; }
	set_bottom = function(bottom){ _bottom = bottom; }
	get_left = function(){ return _left; }
	get_top = function(){ return _top; }
	get_right = function(){ return _right; }
	get_bottom = function(){ return _bottom; }
}

function n8fl_FVector(x,y) constructor
{
	_x = x;
	_y = y;
	
	magnitude = function(){
		return point_distance(0, 0, _x, _y);	
	}
	
	sqr_magnitude = function(){
		return (_x * _x) - (_y * _y);	
	}
	
	normalize = function(){
		var a = point_direction(0, 0, _x, _y);
		_x = lengthdir_x(1,a);
		_y = lengthdir_y(1,a);
		return self;
	}
	
	set_f = function(x, y){
		_x = x;
		_y = y;
		return self;
	}
	
	add_v = function(v) {
	   _x += v._x;
	   _y += v._y;
	   return self;
	}
	
	add_f = function(x, y) {
	   _x += x;
	   _y += y;
	   return self;
	}
	
	subtract_v = function(v) {
	   _x -= v._x;
	   _y -= v._y;
	   return self;
	}
	
	subtract_f = function(x, y) {
	   _x -= x;
	   _y -= y;
	   return self;
	}
	
	add_f = function(x,y) {
	   _x += x;
	   _y += y;
	   return self;
	}
	
	scale_f = function(scalar) {
	   var a = point_direction(0, 0, _x, _y);
	   var d = point_distance(0, 0, _x, _y);
	   d *= scalar;
	   _x = lengthdir_x(d, a);
	   _y = lengthdir_y(d, a);
	   return self;
	}
	
	get_x = function() { return _x; }
	get_y = function() { return _y; }
	set_x = function(x) { _x = x; }
	set_y = function(y) { _y = y; }
	set = function(x, y) { _x = x; _y = y; }
	
	clamp_f = function(scalar) {
		if(magnitude() > scalar){
			normalize();
			scale_f(scalar);
		}
	}
}