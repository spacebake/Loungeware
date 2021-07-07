function n8fl_impossible_move_to(current, dest, spd){
	var n = current + (dest-current) * ((1/(60*(spd/4))));	
	if(abs(n-current) < 0.001){
		return dest;	
	}
	return n;
}


function n8fl_FDelegate(handler) constructor
{
	handlers = ds_list_create();
	once_list = ds_list_create();
	ds_list_add(handlers, handler);	
	
	add = function(handler){
		if(ds_list_find_index(handlers, handler) > 0){
			return false;	
		}
		ds_list_add(handlers, handler);	
		return true;
	}
	
	remove = function(handler){
		var did_delete = false;
		var index = ds_list_find_index(handlers, handler);
		if(index >= 0){
			ds_list_delete(handlers, index);	
			did_delete = true;
		}
		
		index = ds_list_find_index(once_list, handler);
		if(index >= 0){
			ds_list_delete(once_list, index);	
			did_delete = false;
		}
	}
	
	invoke = function(args){
		for(var i=0; i < ds_list_size(handlers); i++){
			handlers[| i](args);	
		}
		
		for(var i=0; i < ds_list_size(once_list); i++){
			once_list[| i](args);
		}
		ds_list_clear(once_list);
	}
	
	once = function(handler){
		if(ds_list_find_index(once_list, handler) > 0){
			return false;	
		}
		ds_list_add(once_list, handler);	
		return true;
	}
}

function n8fl_FWave(_freq, _amp) constructor
{
	freq = _freq;
	amp = _amp;
	offset = random_range(100,1000);
	time = 0;
	tick = 0;
	
	static value = function(){
		if(tick != global.n8fl_tick){
			time += ((1/freq)/2)/60;
			tick = global.n8fl_tick;
		}
		var t = time % 360;
		return dsin(t * offset) * amp;
	}
} 

enum n8fl_ETween {
	Linear,
	EaseInOut,
	EaseOutElastic,
	EaseInOutElastic
}

function n8fl_FTween(_start, _dest, _duration) constructor
{
	start = _start;
	dest = _dest;
	duration = _duration;
	play_speed = 0;
	last_play_speed = 0;
	time = 0;
	tick = 0;
	type = n8fl_ETween.EaseInOut;
	completed = new n8fl_FDelegate(function(){});
	started = new n8fl_FDelegate(function(){});
	
	is_started = false;
	is_completed = false;
	
	normalized_value = function(){
		update();
		var t = time/duration;
		switch(type){
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
		return lerp(start, dest, t);
	}
	
	update = function(){
		if(play_speed == 0){
			return;	
		}
		if(tick != global.n8fl_tick){

			if(time == 0 && is_started == false){
				is_started = true;
				started.invoke(self);
			}
			
			if((time / duration >= 1) && is_completed == false){
				is_completed = true;
				completed.invoke(self);
			}
			
			is_completed = time / duration >= 1;
			
			time += (1/60) * play_speed;
			time = clamp(time, 0, duration);
			tick = global.n8fl_tick;
		}
	}
	
	play = function(){
		if(argument_count > 0){
			play_speed = argument[0];	
		}else{
			last_play_speed = last_play_speed == 0 ? 1 : last_play_speed;
			play_speed = last_play_speed;
		}
		last_play_speed = play_speed;
	}
	
	pause = function(){
		if(play_speed == 0){
			last_play_speed = last_play_speed == 0 ? 1 : last_play_speed;
		}else{
			last_play_speed = 1;	
		}
		play_speed = 0;	
	}
	
	reset = function(){
		play_speed = 0;
		last_play_speed = 0;
		tick = 0;
		time = 0;
		is_started = false;
		is_completed = false;
	}
	
	is_playing = function(){
		return is_started && is_completed == false;	
	}
}

function n8fl_FVector(_x,_y) constructor
{
	x = _x;
	y = _y;
	
	magnitude = function(){
		return point_distance(0, 0, x, y);	
	}
	
	sqr_magnitude = function(){
		return (x * x) - (y * y);	
	}
	
	normalize = function(){
		var a = point_direction(0, 0, x, y);
		x = lengthdir_x(1,a);
		y = lengthdir_y(1,a);
	}
	
	add_v = function(v) {
	   x += v.x;
	   y += v.y;
	}
	
	add_f = function(_x,_y) {
	   x += _x;
	   y += _x;
	}
	
	scale_f = function(scalar) {
	   var a = point_direction(0, 0, x, y);
	   var d = point_distance(0, 0, x, y);
	   d *= scalar;
	   x = lengthdir_x(d, a);
	   y = lengthdir_y(d, a);
	}
	
	clamp_f = function(scalar) {
		if(magnitude() > scalar){
			normalize();
			scale_f(scalar);
		}
	}
}