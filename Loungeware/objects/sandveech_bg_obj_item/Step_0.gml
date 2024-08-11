// sandveech_bg_obj_item.step

if (isGrabbed && instance_exists(sandveech_bg_obj_arm)) {
	var _arm = sandveech_bg_obj_arm;

	x = _arm.x;
	y = _arm.y;
	
	if (_arm.hspd != 0) || (_arm.vspd != 0) {
		hdir = _arm.hspd;
		vdir = _arm.vspd;
	}
}
else if (hdir != 0 || vdir != 0){
	var _dir = point_direction(x, y, x + hdir, y + vdir);
	var _hspd = lengthdir_x(max_slide_speed, _dir) * slide_speed;
	var _vspd = lengthdir_y(max_slide_speed, _dir) * slide_speed;
	
	x += _hspd;
	y += _vspd;
}

decelerate();

// out of bounds prevention
if (bbox_bottom < 0) {
	y = room_height;	
}
if (bbox_top > room_height) {
	if (x > (room_width / 2) - 64) && (x < (room_width / 2) +  64) {
		add_to_plate();
		instance_destroy();
	}
	
	y = 0;
}
if (bbox_left > room_width) {
	x = 0;
}
if (bbox_right < 0) {
	x = room_width;	
}