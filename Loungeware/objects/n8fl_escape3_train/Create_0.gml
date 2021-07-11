_transform = new n8fl_FTransform(x, y);
_cart_count = 7;
_speed = 1.2;
image_speed = 0;
_player_landed = false;

_init = function(){
	_transform.set_parent(inst_n8fl_escape3_game.get_fake_camera_transform());
	for(var i=0; i < _cart_count; i++){
		var cart = instance_create_depth(x, y, depth-1, n8fl_escape3_cart);
		cart.set_index(i+1);
	}
	
	//inst_n8fl_escape2_player.landed.once(function(success){
	//	_player_landed = success
	//});
}

_tick = function(){
	var pos = _transform.get_local_pos();
	
	if(_player_landed){
		//var _target = 
		//	pos.get_x() - inst_n8fl_escape2_player.get_transform().get_pos().get_x() + 20;
		
		//pos.set_x(n8fl_impossible_move_to(pos.get_x(), _target, 3));
	}else{
		pos._x += _speed;
	}
	_transform.set_local_pos_v(pos);
	_transform.apply_to_inst(id);
}

_draw = function(){
	draw_self();
	draw_circle(get_train_end_x(), _transform.get_y(), 5, false);
}

get_train_end_x = function(){
	return _transform.get_x()  - _cart_count * (sprite_get_width(n8fl_escape3_cart) / 2);
}	

get_transform = function(){ return _transform; }

global.n8fl_ticked.once(_init);