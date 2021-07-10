///@func tfg_collision_create_error_box(line_num);
function tfg_collision_create_error_box(_line_num){
	with (instance_create_layer(0, 0, "Layer_Above", tfg_collision_obj_error)) {
		error = string_replace(error, "{line_num}", string(_line_num));
		error = string_replace(error, "{line_content}", 
			str_wrap(str_ltrim(array_to_str(array_filter(tfg_collision_obj_game.broken_code[tfg_collision_obj_game.get_line()], function(_char) {
				return array_count(tfg_collision_obj_game.colour_chars, _char) == 0;
			}))), w));
	}
}