left_broom = inst_520C8C5D;
right_broom = inst_4C5C16F3;

dir = new n8fl_FVector(0,0);
velocity = new n8fl_FVector(0, 0);
intensity = 0;
accel = 0.1;
max_spd = 4;
decel = 0.95;
cam_velocity = new n8fl_FVector(0, 0);

camera = camera_create();
view_set_camera(0, camera);

get_cam_x = function(){
	return camera_get_view_x(camera);	
}

get_cam_y = function(){
	return camera_get_view_y(camera);	
}

get_cam_velocity = function(){
	return cam_velocity;	
}

_tick = function(){
	var cam_x = get_cam_x();
	var cam_y = get_cam_y();
	
	cam_velocity.x = n8fl_impossible_move_to(cam_x, -room_width/2, 0.2) - cam_x;
	cam_velocity.y = n8fl_impossible_move_to(cam_y, y - room_height*2+150, 0.2) - cam_y;
	
	cam_x += cam_velocity.x;
	cam_y += cam_velocity.y;
	
	camera_set_view_size(camera, room_width*2, room_height*2);
	camera_set_view_pos(camera, cam_x, cam_y);
	
	var v1 = new n8fl_FVector(left_broom.x - x, left_broom.y - y);
	v1.normalize();
	v1.scale_f(-left_broom.intensity);
	
	var v2 = new n8fl_FVector(right_broom.x - x, right_broom.y - y);
	v2.normalize();
	v2.scale_f(-right_broom.intensity);
	
	intensity = (left_broom.intensity + right_broom.intensity) / 2;
	
	var y_dir = sign(y - left_broom.y)
	var v3 = new n8fl_FVector(0, intensity * y_dir * 2);
	
	dir = new n8fl_FVector(0, 0);
	dir.add_v(v1);
	dir.add_v(v2);
	dir.add_v(v3);
	dir.normalize();
	dir.scale_f(intensity);
	
	if(abs(dir.x) > 0.001){
		velocity.x += dir.x * accel;	
	}else{
		velocity.x *= decel;
	}
	
	if(abs(dir.y) > 0.001){
		velocity.y += dir.y * accel;	
	}else{
		velocity.y *= decel;
	}
	
	velocity.clamp_f(max_spd);
	
	x += velocity.x;
	y += velocity.y;
	
	image_angle += velocity.magnitude() * sign(velocity.x);
}

_draw = function(){
	draw_self();
	
	draw_set_color(c_red);
	draw_line(x, y, x + dir.x * 50, y + dir.y * 50);
}

_cleanup = function(){
	camera_destroy(camera);	
}
