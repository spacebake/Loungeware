// Player
_transform = new n8fl_FTransform(0, 0);
_transform.set_parent(inst_n8fl_escape2_car.get_transform());
_transform.set_pos_f(x, y);

_did_jump = false;

_win_jump_wave = new n8fl_FWave(0.1,-5);
_win_jump_wave.set_offset(0);

_velocity = new n8fl_FVector(0,0);
_grav = 0.8;
_jump_force = 6.5;
_tumble_rotate_speed = 20;
_tumble_force = 5;
_is_tumbling = false;
_did_land = false;
_kill_y = 0;

jumped = new n8fl_FDelegate(function(){});
bounced = new n8fl_FDelegate(function(){});
landed = new n8fl_FDelegate(function(){});

_land_cart = noone;

_on_collide_train_goal = function(cart){
	if(_is_tumbling){
		return;	
	}
	
	if(cart.image_index == 1 && 
		_did_land == false && 
		_velocity._y > 0
	){
		_did_land = true;
		_land_cart = cart;
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
	_win_jump_wave.play();
	_transform.set_parent(_land_cart.get_transform());
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
	_kill_y = inst_n8fl_escape2_train.y - sprite_height/2 + 10;
	
	if(_did_land){
		var base_y = 
			n8fl_bbox_middle(_land_cart).get_y() -
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
		
		if(_velocity.get_y() > 0){
			layer = layer_get_id("Mid");	
		}
			
		var pos =_transform.get_pos();
		if(_velocity.get_y() > 0 && pos.get_y() > _kill_y){
			if(_is_tumbling == false){
				_is_tumbling = true;
				_on_land_fail();
			}
			_on_tumble();
		}
	
		if(_is_tumbling){
			_velocity.set_x(n8fl_escape2_game.get_travel_speed()/5);
			image_angle += _tumble_rotate_speed;	
		}
	}
	
	_transform.apply_to_inst(id);
}

_apply_velocity = function(){
	_velocity.add_f(0, _grav);	
	
	var local_pos = _transform.get_local_pos();
	local_pos.add_v(_velocity);
	_transform.set_local_pos_v(local_pos);
}

get_transform = function(){ return _transform; }

_draw = function(){
	draw_self();
}
