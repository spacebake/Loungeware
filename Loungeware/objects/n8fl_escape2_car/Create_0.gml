// Car
_transform = new n8fl_FTransform(x, y);
_movement_wave = new n8fl_FWave(0.6, 1);
_movement_wave.set_offset(choose(-180, 180));
_swirve_dist = 12;
_start_x = x + _swirve_dist/2;
_player_has_jumped = false;

_init = function(){
	_movement_wave.play();
	
	inst_n8fl_escape2_player.jumped.add(function(){
		_player_has_jumped = true;
	});
}

_tick = function(){
	if(_player_has_jumped){
		_transform._x += inst_n8fl_escape2_game.get_travel_speed()/2;	
	}else{
		var pos = _transform.get_local_pos();
		pos._x = _start_x + lerp(-_swirve_dist, _swirve_dist, _movement_wave.get_value());
		_transform.set_local_pos_v(pos);
	}
	_transform.apply_to_inst(id);
}

_draw = function(){
	var pos = _transform.get_pos();
	draw_sprite(sprite_index, image_index, pos.get_x(), pos.get_y());	
}

get_transform = function(){return _transform;}
n8fl_execute_next_once(_init);