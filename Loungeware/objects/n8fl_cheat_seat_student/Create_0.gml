image_index = irandom(image_number);
image_speed = 0;
_transform = new n8fl_FTransform(x, y);

_tick = function(){
	_transform.apply_to_inst(id);
	depth = -_transform.get_y();	
}

_draw = function(){
	_transform.apply_to_inst(id);
	draw_self();
}