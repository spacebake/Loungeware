_transform = new n8fl_FTransform(0, 0);
image_index = choose(0,1);
image_speed = 0;

_tick = function(){
	_transform.apply_to_inst(id);
}

set_cart = function(cart){
	_transform.set_parent(cart.get_transform());
	_transform.set_local_pos_f(0, -cart.sprite_height+10);
}