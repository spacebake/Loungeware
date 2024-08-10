if (grabbed && instance_exists(sandveech_bg_obj_arm)) {
	var _arm = sandveech_bg_obj_arm;
	
	hdir = _arm.hspd;
	vdir = _arm.vspd;
	x = _arm.x;
	y = _arm.y;
	acceleration = _arm.arm_speed;
	
	var _inst = instance_place(x + hdir * acceleration, y + vdir * acceleration, sandveech_bg_obj_item);
	if (_inst) {
		_inst.hdir = hdir;
		_inst.vdir = vdir;
		_inst.acceleration = acceleration;
		_inst.knockback = 2.1;
	}
}
else if (hdir != 0 || vdir != 0){
	if (place_meeting(x + hdir * acceleration, y, sandveech_bg_obj_wall)) {
		hdir = !hdir;
		knockback = 2.1;
	}
	if (place_meeting(x, y + vdir * acceleration, sandveech_bg_obj_wall)) {
		vdir = !vdir;
		knockback = 2.1;
	}
	
	var _dir = point_direction(x, y, x + hdir * 4, y + vdir * 4);
	x += lengthdir_x(knockback, _dir) * acceleration;
	y += lengthdir_y(knockback, _dir) * acceleration;
	angle = lerp(angle, angle + irandom_range(1, 5), acceleration);
	
	var _inst = instance_place(x + hdir * acceleration, y + vdir * acceleration, sandveech_bg_obj_item);
	if (_inst) {
		_inst.hdir = hdir;
		_inst.vdir = vdir;
		_inst.acceleration = acceleration;
		hdir = !hdir;
		vdir = !vdir;
	}
}

acceleration = lerp(acceleration, 0, 0.09);