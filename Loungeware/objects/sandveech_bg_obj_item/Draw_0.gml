// sandveech_bg_obj_item.draw

if (isNeeded) {
	gpu_set_fog(true, c_yellow, 0, 0);
	draw_sprite_ext(sprite_index, 0, x - 3, y, 1, 1, angle, c_white, 1);
	draw_sprite_ext(sprite_index, 0, x + 3, y, 1, 1, angle, c_white, 1);
	draw_sprite_ext(sprite_index, 0, x, y - 3, 1, 1, angle, c_white, 1);
	draw_sprite_ext(sprite_index, 0, x, y + 3, 1, 1, angle, c_white, 1);
	gpu_set_fog(false, c_yellow, 0, 0);
}

var _arm = sandveech_bg_obj_arm;
if (instance_exists(_arm)) && (!added){
	var _near = _arm.near;
	var _item = _arm.item;	
	
	if (_item) && (_near == id) {
		gpu_set_fog(true, c_white, 0, 0);
		draw_sprite_ext(sprite_index, 0, x - 3, y, 1, 1, angle, c_white, 1);
		draw_sprite_ext(sprite_index, 0, x + 3, y, 1, 1, angle, c_white, 1);
		draw_sprite_ext(sprite_index, 0, x, y - 3, 1, 1, angle, c_white, 1);
		draw_sprite_ext(sprite_index, 0, x, y + 3, 1, 1, angle, c_white, 1);
		gpu_set_fog(false, c_white, 0, 0);
	}
}

draw_sprite_ext(sprite_index, 0, x, y, 1, 1, angle, c_white, alpha);	