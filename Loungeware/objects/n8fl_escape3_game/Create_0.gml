randomize();

_fake_camera_transform = new n8fl_FTransform(-0, 0);
_fsm = new n8fl_FSM();

_travel_speed = 4;
_chars = ds_list_create();

_init = function(){
	inst_n8fl_escape3_player.fell_off_train.once(function(){
		microgame_fail();
		_fsm.set_state(new n8fl_escape3_game_SFallOutro(id));
	});
	
	inst_n8fl_escape3_player.hit_obstacle.once(function(){
		microgame_fail();
		_fsm.set_state(new n8fl_escape3_game_SObstacleOutro(id));	
	});
	
	inst_n8fl_escape3_player.landed_in_helicopter.once(function(){
		microgame_win();
		_fsm.set_state(new n8fl_escape3_game_SWinOutro(id));
	});
	
	n8fl_execute_next_once(function(){
		_fsm.set_state(new n8fl_escape3_game_SIntro(id));
	});
}

_tick = function(){
	_fsm.tick();
}

_cleanup = function(){
	ds_list_destroy(_chars);
}


get_travel_speed = function(){
	return _travel_speed;
}

get_next_char = function(){
	if(ds_list_size(_chars) == 0){
		_generate_chars();	
	}
	var char = _chars[| 0];
	ds_list_delete(_chars, 0);
	return char;
}

_generate_chars = function(){
	ds_list_clear(_chars);
	for(var i=0; i < sprite_get_number(n8fl_escape3_rake); i++){
			ds_list_add(_chars, i);
	}
	ds_list_shuffle(_chars);
}

get_fake_camera_transform = function(){ return _fake_camera_transform; }

n8fl_execute_next_once(_init);