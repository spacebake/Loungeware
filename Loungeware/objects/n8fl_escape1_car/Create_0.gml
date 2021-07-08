// Car
_transform = new n8fl_FTransform(x, y);
_movement_wave = new n8fl_FWave(0.6, 1);
_movement_wave.set_offset(choose(-180, 180));
_swirve_dist = 17;
_start_x = x + _swirve_dist/2;

_init = function(){
	if(object_index == n8fl_escape1_car_goal){
		_movement_wave.set_offset(
			inst_n8fl_eascape1_car_start._movement_wave.get_offset()-180
		);
	}
	_movement_wave.play();
}

_tick = function(){
	var pos = _transform.get_local_pos();
	pos._x = _start_x + lerp(-_swirve_dist, _swirve_dist, _movement_wave.get_value());
	_transform.set_local_pos_v(pos);
	x = pos._x;
	y = pos._y;
}

_draw = function(){
	var pos = _transform.get_pos();
	draw_sprite(sprite_index, image_index, pos.get_x(), pos.get_y());	
}

get_transform = function(){return _transform;}

_init();