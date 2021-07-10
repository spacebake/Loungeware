///@func tfg_collision_create_error_box(line_num);
function tfg_collision_create_error_box(_line_num){
	with (instance_create_layer(0, 0, "Layer_Above", tfg_collision_obj_error)) {
		error = string_replace(error, "{line_num}", string(_line_num));	
	}
}