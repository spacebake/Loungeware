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

if (slide_speed < 0.1) {
	if (place_meeting(x, y, sandveech_bg_obj_plate_box)) {
		add_to_plate();
	}
}

// out of bounds prevention
if (bbox_bottom < 8) {
	if (x > (room_width / 2) - 64) && (x < (room_width / 2) +  64) {
		add_to_plate();
		instance_destroy();
	}
	
	y = room_height;	
}
if (bbox_top > room_height - 8) {
	y = 0;
}
if (bbox_left > room_width - 8) {
	x = 0;
}
if (bbox_right < 8) {
	x = room_width;	
}

if (added) {
	alpha -= 0.05;	
}

if (alpha == 0) {
	instance_destroy();	
}