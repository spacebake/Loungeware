function n8fl_escape3_SPlayerJump(inst) : n8fl_FSMState() constructor
{
	_inst = inst;	
	
	_on_enter = function(){
		with(_inst){
			_velocity._y = -_jump_force;
		}
	}
	
	_on_tick = function(){
		with(_inst){
			
			_velocity._y += _grav;
			
			var pos = _transform.get_pos();
			pos.add_v(_velocity);
			_transform.set_pos_v(pos);
			
			var local_pos = _transform.get_local_pos();
			if(local_pos._y >= _start_y){
				local_pos._y = _start_y;
				_transform.set_local_pos_v(local_pos);
				_fsm.set_state(new n8fl_escape3_SPlayerRun(id));
			}
		}
	}
}

function n8fl_escape3_SPlayerBounce(inst) : n8fl_FSMState() constructor
{
	_inst = inst;	
	_bounce_force = 4;
	_base_y = 0;
	
	_on_enter = function(){
		_base_y = _inst._transform.get_local_pos().get_y();	
	}
	
	_on_tick = function(){
		with(_inst){
			_velocity._y += _grav;
			_velocity._x *= 0.95;	
			image_angle += other._bounce_force * 3;
			var pos = _transform.get_pos();
			pos.add_v(_velocity);
			_transform.set_pos_v(pos);
			
			var local_pos = _transform.get_local_pos();
			if(local_pos._y >= other._base_y){
				local_pos._y = other._base_y;
				_transform.set_local_pos_v(local_pos);
				other._bounce();
			}
		}
	}
	
	_bounce = function(){
		_inst._velocity._y = -_bounce_force;
		_bounce_force -=1;
		_bounce_force = max(0, _bounce_force);
	}
}

function n8fl_escape3_SPlayerRun(inst) : n8fl_FSMState() constructor
{
	_inst = inst;
	
	_on_enter = function(){
		_inst._run_wave.play();	
	}
	
	_on_tick = function(){
		with(_inst){
			image_angle += _run_wave.get_delta();
			
			var pos = _transform.get_pos();
			pos._x += _speed;
			_transform.set_pos_v(pos);

			if(_transform.get_x() < inst_n8fl_escape3_train.get_train_end_x()){
				_fsm.set_state(new n8fl_escape3_SPlayerFall(id));	
				exit;
			}
			
			var has_input = KEY_PRIMARY || KEY_SECONDARY || KEY_UP;
			if(has_input){
				_fsm.set_state(new n8fl_escape3_SPlayerJump(id));	
			}
		}
	}
	
	_on_exit = function(){
		_inst._run_wave.pause();	
		_inst._run_wave.reset();
		image_angle = 0;
	}
}

function n8fl_escape3_SPlayerFall(inst) : n8fl_FSMState() constructor
{
	_inst = inst;	
	
	_on_enter = function(){
		_inst.fell_off_train.invoke(_inst);
		_inst._velocity._x = -2;
	}
	
	_on_tick = function(){
		with(_inst){
			image_angle = n8fl_impossible_move_to(image_angle, 90, 0.3);
		
			_velocity._y += _grav;
			var pos = _transform.get_pos();
			pos.add_v(_velocity);
			pos._y = min(pos._y, inst_n8fl_escape3_train.y);
		
			if(pos._y == inst_n8fl_escape3_train.y){
				_fsm.set_state(new n8fl_escape3_SPlayerBounce(id));	
			}
		
			_transform.set_pos_v(pos);
		
			_velocity._x *= 0.95;		
		}
	}
}

function n8fl_escape3_SPlayerHeliRide(inst) : n8fl_FSMState() constructor
{
	_inst = inst;	
	
	_on_enter = function(){
		
		//_inst.fell_off_train.invoke(_inst);
		//_inst._velocity._x = -2;
		//_inst._velocity._x = _inst.xprevious - _inst.x;
	}
	
	_on_tick = function(){
		with(_inst){
			if(_transform.get_parent() != inst_n8fl_escape3_heli.get_transform()){
				_velocity._y += _grav;
				var pos = _transform.get_pos();
				pos.add_v(_velocity);
				pos._y = min(pos._y, inst_n8fl_escape3_heli.bbox_bottom);
				if(pos._y == inst_n8fl_escape3_heli.bbox_bottom){
					_transform.set_parent(inst_n8fl_escape3_heli.get_transform());
					image_xscale = 1;
				}
				_transform.set_pos_v(pos);
			}else{
				image_angle = inst_n8fl_escape3_heli.image_angle;
				var pos = _transform.get_pos();
				pos._x = n8fl_impossible_move_to(pos._x, inst_n8fl_escape3_heli.x, 0.4);
				pos._y = n8fl_impossible_move_to(pos._y, inst_n8fl_escape3_heli.y+4, 0.4);
				_transform.set_pos_v(pos);
			}
		}
		//with(_inst){
		//	image_angle = n8fl_impossible_move_to(image_angle, 90, 0.3);
		
		//	_velocity._y += _grav;
		//	var pos = _transform.get_pos();
		//	pos.add_v(_velocity);
		//	pos._y = min(pos._y, inst_n8fl_escape3_train.y);
		
		//	if(pos._y == inst_n8fl_escape3_train.y){
		//		_fsm.set_state(new n8fl_escape3_SPlayerBounce(id));	
		//	}
		
		//	_transform.set_pos_v(pos);
		
		//	_velocity._x *= 0.95;		
		//}
	}
}

function n8fl_escape3_SPlayerFailed(inst) : n8fl_FSMState() constructor
{
	_inst = inst;	
	_base_y = 0;
	
	_on_enter = function(){
		_inst._transform.set_parent(inst_n8fl_escape3_train.get_transform());
		_inst._velocity._y = -_inst._jump_force / 2;
		_base_y = _inst._transform.get_local_pos().get_y();	
	}
	
	_on_tick = function(){
		with(_inst){
			image_angle = n8fl_impossible_move_to(image_angle, 90, 0.2);
			_velocity._y += _grav;
			var pos = _transform.get_pos();
			pos.add_v(_velocity);
			_transform.set_pos_v(pos);	
			
			var local_pos = _transform.get_local_pos();
			if(local_pos._y >= other._base_y){
				local_pos._y = other._base_y;
				_transform.set_local_pos_v(local_pos);
			}
		}
	}
}

_fsm = new n8fl_FSM();
_start_y = y;
_transform = new n8fl_FTransform(x, y);
_speed = -0.08;
image_xscale = -1;

_velocity = new n8fl_FVector(0,0);
_grav = 0.3;
_jump_force = 4;
_did_fail = false;
_did_heli = false;

fell_off_train = new n8fl_FDelegate(function(){});
hit_obstacle = new n8fl_FDelegate(function(){});
landed_in_helicopter = new n8fl_FDelegate(function(){});
_run_wave = new n8fl_FWave(0.1, 5);

_sprint_delay_timer = new n8fl_FTimer(4.2);

_init = function(){
	_sprint_delay_timer.play();
	_sprint_delay_timer.completed.once(function(){
		_speed *= 3;
	});
	_transform.set_parent(inst_n8fl_escape3_game.get_fake_camera_transform());
	_fsm.set_state(new n8fl_escape3_SPlayerRun(id));
}

_on_obstacle_collided = function(){
	if(_did_fail == false){
		_did_fail = true;
		_fsm.set_state(new n8fl_escape3_SPlayerFailed(id));
		hit_obstacle.invoke(id);
	}
}

_on_heli_collided = function(heli){
	if(_did_heli == false){
		_did_heli = true;
		_fsm.set_state(new n8fl_escape3_SPlayerHeliRide(id));
		landed_in_helicopter.invoke(id);
	}
}

tick_count = 0;
r = irandom_range(50, 80);
_tick = function(){	
	tick_count++;

	if(_did_fail == false){
		if(tick_count % r  = 0){
			r = irandom_range(50, 80);
			var _snd_id = sfx_play(n8fl_reach_for_it_mister_gunshot_snd, 0.4, 0);
			audio_sound_pitch(_snd_id, random_range(0.5,1.2));
		
			_snd_id = sfx_play(n8fl_reach_for_it_mister_ricochet_snd, 0.2, 0);
			audio_sound_pitch(_snd_id, random_range(0.7,1));
		}
	}

	_sprint_delay_timer.update();
	_fsm.tick();
	_transform.apply_to_inst(id);
}


n8fl_execute_next_once(_init);