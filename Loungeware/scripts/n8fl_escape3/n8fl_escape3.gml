
function n8fl_escape3_game_SMainGame(inst) : n8fl_FSMState() constructor
{
	_inst = inst;
	_tween = new n8fl_FTween(_inst._fake_camera_transform.get_x(), _inst._fake_camera_transform.get_x()+40, 6);
	_timer = new n8fl_FTimer(4.1);
	
	_on_enter = function(){
		_tween.reset();
		_tween.play();
		_timer.play();
		//_timer.completed.once(function(){
		//	_inst._fsm.set_state(new n8fl_escape3_game_SFinalSprint(_inst));
		//});
	}
	
	_on_tick = function(){
		_timer.update();
		var pos = _inst._fake_camera_transform.get_pos();
		pos._x += _tween.get_delta();
		_inst._fake_camera_transform.set_pos_v(pos);
	}
}


function n8fl_escape3_game_SIntro(inst) : n8fl_FSMState() constructor
{
	
	_inst = inst;
	_back_dist = 100;
	_tween = new n8fl_FTween(0, _back_dist, 1.2);
	
	_on_enter = function(){
		_tween.reset();
		_tween.play();
		
		var pos = _inst._fake_camera_transform.get_pos();
		pos._x = -_back_dist;
		_inst._fake_camera_transform.set_pos_v(pos);
	}
	
	_on_tick = function(){
		var pos = _inst._fake_camera_transform.get_pos();
		pos._x += _tween.get_delta();
		_inst._fake_camera_transform.set_pos_v(pos);
		
		if(_tween.is_completed()){
			_inst._fsm.set_state(new n8fl_escape3_game_SMainGame(_inst));
		}
	}
}

function n8fl_escape3_game_SFallOutro(inst) : n8fl_FSMState() constructor
{
	
	_inst = inst;
	_tween = new n8fl_FTween(_inst.get_travel_speed(), 0, 1);
	
	_on_enter = function(){
		_tween.reset();
		_tween.play();
	}
	
	_on_tick = function(){
		_inst._travel_speed = _tween.get_value();
	}
}

function n8fl_escape3_game_SObstacleOutro(inst) : n8fl_FSMState() constructor
{
	
	_inst = inst;
	_tween = new n8fl_FTween(_inst.get_travel_speed(), 0, 1);
	
	_on_enter = function(){
		//_tween.reset();
		//_tween.play();
	}
	
	_on_tick = function(){
		var pos = _inst._fake_camera_transform.get_pos();
		pos._x -= _inst._travel_speed/3.5;
		_inst._fake_camera_transform.set_pos_v(pos);
		//_inst._travel_speed = _tween.get_value();
	}
}

function n8fl_escape3_game_SWinOutro(inst) : n8fl_FSMState() constructor
{
	_inst = inst;
	_back_dist = 0;
	_tween_x = new n8fl_FTween(0, -room_width, 0.8);
	_tween_y = new n8fl_FTween(0, room_height, 0.8);
	
	
	_on_enter = function(){
		_tween_x.reset();
		_tween_x.play();
		_tween_y.play();
	}
	
	_on_tick = function(){
		if(inst_n8fl_escape3_player._transform.get_parent() == inst_n8fl_escape3_heli.get_transform()){
			var pos = _inst._fake_camera_transform.get_pos();
			pos._x += _tween_x.get_delta();
			pos._y += _tween_y.get_delta();
			_inst._fake_camera_transform.set_pos_v(pos);
		}
	}
}