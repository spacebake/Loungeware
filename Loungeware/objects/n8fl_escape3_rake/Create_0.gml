function n8fl_escape3_SRakeJump(inst) : n8fl_FSMState() constructor
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
				_fsm.set_state(new n8fl_escape3_SRakeChase(id));
			}
		}
	}
}
function n8fl_escape3_SRakeChase(inst) : n8fl_FSMState() constructor
{
	_inst = inst;
	_on_enter = function(){
		_inst._run_wave.play();	
	}
	
	_on_tick = function(){
		with(_inst){
			image_xscale = abs(inst_n8fl_escape3_player.x - x) ? 1 : -1;
			
			if(_do_chase){
				image_angle += _run_wave.get_delta();
				var pos = _transform.get_pos();
				pos._x += 0.05;
				_transform.set_pos_v(pos);
			
				if(
					n8fl_raycast_v(
						_transform.get_pos(), 
						_transform.get_pos().add_f(-8, 0),
						n8fl_escape3_obstacle
					)
				){
					_fsm.set_state(new n8fl_escape3_SRakeJump(id));
				}
			}else{
				_transform.set_parent(inst_n8fl_escape3_train.get_transform());
				image_angle = 0;	
			}
		}
	}
	
	_on_exit = function(){
		_inst._run_wave.pause();	
		_inst._run_wave.reset();
		image_angle = 0;
	}
}

image_speed = 0;


_fsm = new n8fl_FSM();
_transform = new n8fl_FTransform(x, y);
_run_wave = new n8fl_FWave(random_range(0.1, 0.2), random_range(4,5));
_velocity = new n8fl_FVector(0, 0);
_grav = 0.3;
_jump_force = 4;

_do_chase = true;

_init = function(){
	image_index = inst_n8fl_escape3_game.get_next_char();
	_transform.set_parent(inst_n8fl_escape3_game.get_fake_camera_transform());
	_start_y = _transform.get_local_pos()._y;
	_run_wave.play();
	_fsm.set_state(new n8fl_escape3_SRakeChase(id));
	
	inst_n8fl_escape3_player.fell_off_train.once(function(){
		_do_chase = false;
	});
	
	inst_n8fl_escape3_player.hit_obstacle.once(function(){
		_do_chase = false;
	});
}


_tick = function(){
	_fsm.tick();

	
	_transform.apply_to_inst(id);
}

	

n8fl_execute_next_once(_init);