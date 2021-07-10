y-=sprite_height;
x-=sprite_width;
image_angle = 30;

_transform = new n8fl_FTransform(x, y);
_target_pos = new n8fl_FVector(x, y);

_hover_wave = new n8fl_FWave(0.8, 3);
_hover_wave.set_offset(-180);

_hover_tween_x = new n8fl_FTween(0, 15, 2);

_in_tween_y = new n8fl_FTween(0, sprite_height + _hover_wave.get_amp() * 2, 2);
_in_tween_y.set_type(n8fl_ETween.Linear);

_in_tween_x = new n8fl_FTween(0, sprite_width, 2);
_in_tween_angle = new n8fl_FTween(image_angle, -10, 3);
_intro_timer = new n8fl_FTimer(0.1);

_exit_timer = new n8fl_FTimer(4);
_exit_tween_y = new n8fl_FTween(0,-sprite_height,1);
_exit_tween_x = new n8fl_FTween(0, sprite_width,1);
_exit_angle = new n8fl_FTween(0, -20, 1);

_init = function(){
	_intro_timer.completed.once(function(){
		_in_tween_y.play();
		_in_tween_x.play();
		_in_tween_angle.play();
		_in_tween_angle.completed.once(function(){
			_in_tween_angle = new n8fl_FTween(image_angle, 0, 2);
			_in_tween_angle.play();
		});
	});
	
	_exit_timer.completed.once(function(){
		_hover_wave.pause();
		_exit_tween_y.play();
		_exit_tween_x.play();
		_exit_angle.play();
	});
	
	_in_tween_y.completed.once(function(){
		_hover_wave.play();	
		_hover_tween_x.play();
	});
	
	_intro_timer.play();
	_exit_timer.play();
}

_tick = function(){
	_exit_timer.update();
	_intro_timer.update();
	
	_target_pos._y += _in_tween_y.get_delta();
	_target_pos._x += _in_tween_x.get_delta();
	_target_pos._y += _hover_wave.get_delta();
	_target_pos._x += _exit_tween_x.get_delta();
	_target_pos._y += _exit_tween_y.get_delta();
	_target_pos._x += _hover_tween_x.get_delta();
	image_angle += _in_tween_angle.get_delta();
	image_angle += _exit_angle.get_delta();
	
	var pos = _transform.get_local_pos();
	pos._x = n8fl_impossible_move_to(pos._x, _target_pos._x, 0.5);
	pos._y = n8fl_impossible_move_to(pos._y, _target_pos._y, 0.5);
	_transform.set_local_pos_v(pos);
	
	_transform.apply_to_inst(id);
}

get_transform = function(){ return _transform; }

n8fl_execute_next_once(_init);