_base_tick = _tick;
_tick = function(){
	if(_player_has_jumped){
		_transform._x -= n8fl_escape1_game.get_travel_speed()/2;	
		x = _transform.get_x();
		y = _transform.get_y();
	}else{
		_base_tick();	
	}
	
}

n8fl_escape1_player.jumped.add(function(){
	_player_has_jumped = true;
});