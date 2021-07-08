randomize();
_travel_speed = -4;
alarm[0] = 1;

_init = function(){
	inst_net8fl_escape1_player.landed.add(_on_player_land);
}

_on_player_land = function(was_success){
	if(was_success){
		microgame_win();
	}else{
		microgame_fail();
	}
}

get_travel_speed = function() { return _travel_speed; }

