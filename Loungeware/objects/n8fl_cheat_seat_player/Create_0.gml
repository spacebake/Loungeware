_transform = new n8fl_FTransform(x, y);
_left_desk = inst_n8fl_cheat_seat_desk_left;
_right_desk = inst_n8fl_cheat_seat_desk_right;
_my_desk = inst_n8fl_cheat_seat_desk_mid;
_target_desk = _my_desk;
_is_busted = false;
_score = 0;
_max_score = 10;

d_busted = new n8fl_FDelegate(function(){});

_init = function(){
	
}

_tick = function(){
	if(_is_busted == false){
		var spd = 0.2;
		var target_offset = new n8fl_FVector(0, 0);
	
		_target_desk = _my_desk;
	
		if(KEY_LEFT){
			_target_desk = _left_desk;	
			target_offset._x += sprite_width/2;
		}else if(KEY_RIGHT){
			_target_desk = _right_desk;	
			target_offset._x -= sprite_width/2;
		}
	
		var dest = new n8fl_FVector(_target_desk.x,_target_desk.y).add_v(target_offset);
		var v = dest.copy().subtract_v(_transform.get_pos()).scale_f(spd);
	
		var pos = _transform.get_pos();
		pos.add_v(v);
		_transform.set_pos_v(pos);
	}
	
	_transform.apply_to_inst(id);
	depth = -_transform.get_y() + sprite_get_height(n8fl_cheat_seat_desk_spr);
}

_draw = function(){
	_transform.apply_to_inst(id);
	draw_self();
}

is_in_seat = function(){
	if(_target_desk != _my_desk){
		return false;
	}
	var delta = new n8fl_FVector(
		_transform.get_x() - _target_desk.x,
		_transform.get_y() - _target_desk.y
	);
	return delta.magnitude() < 1;
}

set_busted = function(){
	_is_busted = true;
	d_busted.invoke(id);
}

is_cheating = function(){
	if(_target_desk == _my_desk){
		return false;
	}
	var delta = new n8fl_FVector(
		_transform.get_x() - _target_desk.x,
		_transform.get_y() - _target_desk.y
	);
	return delta.magnitude()-1 <= sprite_width / 2;
}

get_target_desk = function(){
	return _target_desk;
}

perform_cheat = function(){
	_score += 1;
	_score = clamp(_score, 0, _max_score);
}

get_score = function(){ return _score; }
get_score_normalized = function(){ return _score / _max_score; }

n8fl_execute_next_once(_init);