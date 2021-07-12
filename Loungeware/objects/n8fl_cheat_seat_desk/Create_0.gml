_transform = new n8fl_FTransform(x, y);
_init = function(){
	if(is_student_desk){
		instance_create_depth(x, y, depth, n8fl_cheat_seat_student);	
	}
}

_tick = function(){
	_transform.apply_to_inst(id);
	depth = -_transform.get_y();	
}

_draw = function(){
	_transform.apply_to_inst(id);
	draw_self();
}

n8fl_execute_next_once(_init);