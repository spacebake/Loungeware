if (grabbed && instance_exists(sandveech_bg_obj_arm)) {
	var _arm = sandveech_bg_obj_arm;
	
	x = _arm.x;
	y = _arm.y;
	acceleration = _arm.arm_speed;
}

acceleration = lerp(acceleration, 0, 0.09);

//x += lengthdir_x(3 * acceleration, arccos(hdir));
//y += lengthdir_y(3 * acceleration, arcsin(vdir));