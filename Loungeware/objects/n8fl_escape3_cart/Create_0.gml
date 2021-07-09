_transform = new n8fl_FTransform(0, 0);
_transform.set_parent(inst_n8fl_escape3_train.get_transform());
_transform.set_pos_f(x, y);
_padding = 4;
_index = -1;

image_speed = 0;


_tick = function(){
	_transform.apply_to_inst(id);
}

_draw = function(){
	draw_self();	
}

set_index = function(index){
	if(_index != -1){
		return;	
	}
	_index = index;
	_transform.set_local_pos_f(-(index * sprite_width + index * _padding), 0);
	if(index > 3){
		image_index = index % 2 == 0 ? 1 : 2;
	}else if(index > 2){
		image_index = 1;	
	}else{
		image_index = 2;	
	}
	
	if(image_index == 1){
		//repeat(irandom_range(1,2)){
		//	var spec = instance_create_depth(0, 0, depth-1, n8fl_escape2_spectator);
		//	spec.set_cart(id);
		//}
	}
	
	if(index > 1 && index < 6){
		_obstacle = instance_create_depth(0, 0, depth, n8fl_escape3_obstacle);
		_obstacle.set_cart(id);	
	}
}

get_transform = function(){ return _transform; } 