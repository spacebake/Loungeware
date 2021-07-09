_transform = new n8fl_FTransform(0,0);
_win_jump_wave = new n8fl_FWave(random_range(0.1, 0.2), 1);
_win_jump_wave.play();
//_win_jump_wave.set_offset(0);
jump_height = 3;
_start_y = -8;
_scale = 0.3;
_init = function(){
	sprite_index = inst_n8fl_escape2_game.get_next_char();
	image_speed = 0;
	image_xscale = _scale;
	image_yscale = _scale;
	
	inst_n8fl_escape2_player.landed.once(function(success){
		if(success){
			_win_jump_wave.play();
		}
	});
}

set_cart = function(cart){
	_transform.set_parent(cart.get_transform());
	_transform.set_local_pos_f(random_range(-12,12), _start_y);
}

_tick = function(){
	image_xscale = -sign(inst_n8fl_escape2_player.x - x) * _scale;
	var pos = _transform.get_local_pos();
	pos._y = lerp(_start_y, _start_y - jump_height, _win_jump_wave.get_value());
	_transform.set_local_pos_v(pos);
	_transform.apply_to_inst(id);	
}

n8fl_execute_next_once(_init);