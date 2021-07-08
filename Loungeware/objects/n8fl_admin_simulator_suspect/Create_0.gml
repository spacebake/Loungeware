_is_banished = false;
_is_allowed = false;

_fade_in_tween = new n8fl_FTween(0, 1, 0.5);
_hop_wave = new n8fl_FWave(0.1,4);
_ban_tween = new n8fl_FTween(0, 1, 1);
_allow_tween = new n8fl_FTween(0, 1, 1);

_start_y = y;
_start_x = x;
_index = 0;
image_alpha = 0;
image_speed = 0;

velocity = new n8fl_FVector(0, 0);
grav = 0.4;

_init = function(){
	_fade_in_tween.play();
	_hop_wave.play();
}

_tick = function(){
	_fade_in_tween.update();
	
	if(_fade_in_tween.is_playing()){
		image_alpha = _fade_in_tween.value();	
	}
	
	if(_is_allowed){
		y = _start_y - _hop_wave.get_value_one();
		x = lerp(
			_start_x, 
			room_width - 20 * n8fl_admin_simulator_player.score_max + _index * 20, 
			_allow_tween.value()
		);	
	}else if(_is_banished){
		velocity.set_y(velocity.get_y() + grav);

		x = lerp(_start_x, 10 + n8fl_admin_simulator_player.score_max + _index * 28, _ban_tween.value());
		y += velocity.get_y();
		y = min(_start_y, y);

		image_angle = lerp(0, 90, min(1, _ban_tween.value() * 2));
	}
}

banish = function(index){
	if(_is_banished == false && _is_allowed == false){
		_index = index;
		_start_y -= 5;
		_is_banished = true;
		_ban_tween.play();
		velocity.set_f(-2, -( max(5, 8 - _index)));
	}
}

allow = function(index){
	if(_is_banished == false && _is_allowed == false){
		_index = index;
		_is_allowed = true;
		_allow_tween.play();
		_allow_tween.completed.once(function(){
			image_xscale = -1;
		});
	}
}

_init();