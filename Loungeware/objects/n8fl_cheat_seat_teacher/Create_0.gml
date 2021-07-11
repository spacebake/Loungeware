function n8fl_cheat_seat_teacher_SWalk(inst) : n8fl_FSMState() constructor 
{
	_inst = inst;
	_bounce_wave = new n8fl_FWave(0.1, 3);
	_on_enter = function(){
		_inst._walk_wave.play();
		_bounce_wave.play();
	}
	_on_tick = function(){
		if(_inst.is_player_bustable()){
			_inst._fsm.set_state(new _inst.n8fl_cheat_seat_teacher_SAlert(_inst));
		}else{
			var pos = _inst._transform.get_pos();
			pos._x += _inst._walk_wave.get_delta();
			_inst._transform.set_pos_v(pos);
		
			_inst.image_angle = _bounce_wave.get_value();
			_inst.image_xscale = sign(_inst._walk_wave.get_delta()) ? 1 : -1;
		}
	}
	_on_exit = function(){
		_inst.image_angle = 0;
		_inst._walk_wave.pause();
	}
}

function n8fl_cheat_seat_teacher_SPunish(inst) : n8fl_FSMState() constructor 
{
	_inst = inst;
	_speed = 2;
	_bounce_wave_y = new n8fl_FWave(0.1, 3);
	_bounce_wave_y.set_offset(0);
	
	_on_enter = function(){
		_inst.image_blend = c_red;
		_bounce_wave_y.play();
	}
	_on_tick = function(){
		var d = new n8fl_FVector(
			inst_n8fl_cheat_seat_player.x - _inst._transform.get_x(),
			inst_n8fl_cheat_seat_player.y - _inst._transform.get_y(),
		);
		
		var pos = _inst._transform.get_pos();
		if(d.magnitude() > 8){
			var v = d.copy().normalize().scale_f(_speed);
		
			
			pos.add_v(v);
		}
		pos._y += _bounce_wave_y.get_delta_one();
		_inst._transform.set_pos_v(pos);
	}
	_on_exit = function(){
	
	}
}

function n8fl_cheat_seat_teacher_SAlert(inst) : n8fl_FSMState() constructor 
{
	_inst = inst;
	_shake_intensity_tween = new n8fl_FTween(0,1, 0.6);
	_shake_wave_x = new n8fl_FWave(0.03, 1);
	_enter_pos = 0;
	
	_on_enter = function(){
		_enter_pos = _inst._transform.get_x();
		_shake_intensity_tween.play();
		_shake_wave_x.play();
		_shake_intensity_tween.completed.once(function(){
			inst_n8fl_cheat_seat_player.set_busted();
		});
	}
	_on_tick = function(){
		if(_inst.is_player_bustable() == false){
			_inst._fsm.set_state(new _inst.n8fl_cheat_seat_teacher_SWalk(_inst));
			exit;
		}
		_inst.image_blend = make_color_rgb(
			255,
			(1-_shake_intensity_tween.get_value()) * 255, 
			(1-_shake_intensity_tween.get_value()) * 255);
		var pos = _inst._transform.get_pos();
		pos._x += _shake_wave_x.get_delta() * _shake_intensity_tween.get_value();
		_inst._transform.set_pos_v(pos);
	}
	_on_exit = function(){
		_inst.image_blend = c_white;
		var pos = _inst._transform.get_pos();
		pos._x = _enter_pos;
		_inst._transform.set_pos_v(pos);
	}
}

_transform = new n8fl_FTransform(x, y);
_fsm = new n8fl_FSM();
_walk_padding = 20;
_walk_wave = new n8fl_FWave(0.7, (room_width/2) - _walk_padding);
_init = function(){
	inst_n8fl_cheat_seat_player.d_busted.once(_on_player_busted);
	_walk_wave.set_offset(0);
	_fsm.set_state(new n8fl_cheat_seat_teacher_SWalk(id));
}

_tick = function(){
	_fsm.tick();
	_transform.apply_to_inst(id);
	depth = -y;
}

_draw = function(){
	_transform.apply_to_inst(id);
	draw_self();
}

is_facing_player = function(){
	return 	
		abs(inst_n8fl_cheat_seat_player.x - x) > 10 && 
		abs(inst_n8fl_cheat_seat_player.x - x) < 25 && 
		sign(inst_n8fl_cheat_seat_player.x - x) == image_xscale;
}

is_player_bustable= function(){
	return is_facing_player() && inst_n8fl_cheat_seat_player.is_in_seat() == false;
}

_on_player_busted = function(){
	_fsm.set_state(new n8fl_cheat_seat_teacher_SPunish(id));
}


n8fl_execute_next_once(_init);