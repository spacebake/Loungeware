sprite_index = choose(space_lander_part_smoke, space_lander_part_smoke2);
image_angle = choose(0, 90, 180, 270);
starting_frame = irandom(2);
prog = 0;
range = random_range(16, 58);

direction = random_range(0, 180);


function smooth_move(_current_val, _target_val, _minimum, _divider){
	
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
