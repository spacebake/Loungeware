// Player
_transform = new n8fl_FTransform(0, 0);
_transform.set_parent(inst_n8fl_eascape1_car_start.get_transform());
_transform.set_pos_f(x, y);

_did_jump = false;

_win_jump_wave = new n8fl_FWave(0.1,-5);
_win_jump_wave.set_offset(0);

_velocity = new n8fl_FVector(0,0);
_grav = 0.7;
_jump_force = 2;
_tumble_rotate_speed = 20;
_tumble_force = 5;
_is_tumbling = false;
_did_land = false;
_kill_y = 0;

jumped = new n8fl_FDelegate(function(){});
bounced = new n8fl_FDelegate(function(){});
landed = new n8fl_FDelegate(function(){});

_on_collide_car_goal = function(){
	if(_is_tumbling){
		return;	
	}
	
	if(_did_land == false && _velocity._y > 0){
		_did_land = true;
		_on_land_success();
	}
}

_on_jump = function(){
	_transform.set_parent(undefined);
	_velocity.set_y(-_jump_force);
	jumped.invoke();
	sfx_play(n8fl_escape1_jump, 0.8, false);
}

_on_land_fail = function(){
	var pos =_transform.get_pos();
	pos.set_y(_kill_y);
	_transform.set_pos_v(pos);
	landed.invoke(false);
	sfx_play(n8fl_escape1_lose, 0.8, false);
}

_on_land_success = function(){
	_transform.set_parent(inst_n8fl_eascape1_car_goal.get_transform());
	_win_jump_wave.play();
	landed.invoke(true);
	sfx_play(n8fl_escape1_win, 0.45, false);
}

_on_tumble = function(){
	var pos =_transform.get_pos();
	pos.set_y(_kill_y);
	_transform.set_pos_v(pos);
	
	_velocity.set_y(-_tumble_force);
	_tumble_force = max(1, _tumble_force-1);
	bounced.invoke();
}

_tick = function(){
	_kill_y = inst_n8fl_eascape1_car_goal.y - sprite_height/2;	
	
	if(_did_land){
		var base_y = 
			n8fl_bbox_middle(inst_n8fl_eascape1_car_goal).get_y() -
			sprite_height / 2 -
			4;
			
		_transform.set_y(base_y + _win_jump_wave.get_value());
	}
	else if(_did_jump == false && KEY_PRIMARY){
		_did_jump = true;
		_on_jump();
	}
	else if(_did_jump){
		_apply_velocity();
			
		var pos =_transform.get_pos();
		if(pos.get_y() > _kill_y){
			if(_is_tumbling == false){
				_is_tumbling = true;
				_on_land_fail();
			}
			_on_tumble();
		}
	
		if(_is_tumbling){
			_velocity.set_x(n8fl_escape1_game.get_travel_speed()/5);
			image_angle += _tumble_rotate_speed;	
		}
	}
	
	x = _transform.get_x();
	y = _transform.get_y();
}

_apply_velocity = function(){
	_velocity.add_f(0, _grav);	
	
	var local_pos = _transform.get_local_pos();
	local_pos.add_v(_velocity);
	_transform.set_local_pos_v(local_pos);
}

_draw = function(){
	draw_self();
}
