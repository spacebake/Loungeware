_start_y = y;
_transform = new n8fl_FTransform(x, y);
_speed = -0.1;
image_xscale = -1;

_velocity = new n8fl_FVector(0,0);
_grav = 0.2;
_grounded = true;
_jump_force = 3;

_did_fail = false;
_did_success = false;

failed = new n8fl_FDelegate(function(){});
successed = new n8fl_FDelegate(function(){});

_fall_off_timer = new n8fl_FTimer(3.7);

_run_wave = new n8fl_FWave(0.1, 5);

_init = function(){
	_fall_off_timer.play();
}

_on_heli_collided = function(heli){
	if(_velocity._y < 0){
		return	
	}
	
	if(_did_success == false){
		_did_success = true;
		_transform.set_parent(heli.get_transform());
		image_xscale = 1;
		successed.invoke();
	}
}

_on_obstacle_collided = function(){
	if(_did_fail == false){
		_did_fail = true;
		_transform.set_parent(inst_n8fl_escape3_train.get_transform());
		_velocity._y = -_jump_force / 2;
		failed.invoke();
	}
}

_tick = function(){	
	
	if(_did_success == false){
		_velocity._y += _grav;
	}
	
	var pos = _transform.get_pos();
	pos.add_v(_velocity);
	
	if(
		_did_success == false && 
		_did_fail == false && 
		_fall_off_timer.is_completed() && 
		y >= _start_y
	){
		_grounded = false;
		image_angle = n8fl_impossible_move_to(image_angle, 90, 0.3);
		pos._y = min(pos._y, inst_n8fl_escape3_train.y);
		_velocity._x *= 0.95;
	}else{
		if(pos.get_y() >= _start_y){
			_grounded = true;
			pos._y = _start_y;
			_velocity._y = 0;
		}else{
			_grounded = false;	
		}
	}
	
	if(_grounded){
		_run_wave.play();
		image_angle += _run_wave.get_delta();	
	}else{
		_run_wave.pause();	
	}
	
	if(_did_fail){
		_velocity._x = 0;
		image_angle = 90;
		image_xscale = -1;
	}else if(_did_success){
		_velocity._x = 0;
		_velocity._y = 0;
		image_angle = inst_n8fl_escape3_heli.image_angle;
	}else if(_fall_off_timer.is_completed() == false){
		_velocity._x = _speed;
		var has_input = KEY_PRIMARY || KEY_SECONDARY || KEY_UP;
		if(_grounded && has_input){
			_velocity._y = -_jump_force;
		}
	}
	
	_transform.set_pos_v(pos);
	_transform.apply_to_inst(id);
}

n8fl_execute_next_once(_init);