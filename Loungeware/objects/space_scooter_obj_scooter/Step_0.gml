
if (shake){
	var _sv = 2;
	var _shake_x = random_range(-_sv, _sv);
	var _shake_y = random_range(-_sv, _sv);
	shake = max(0, shake-1);
} else {
	_shake_x = 0;
	_shake_y = 0;
}


if (!lock_cam_x) cam_x = (x - (VIEW_W/2)) + 24 + cam_x_offset;

if (!lock_cam_y){
	if (x >= space_scooter_camlock.x) lock_cam_y = true;
	var _cam_y_goto = (y - (VIEW_H/2)) - 18;
	var _ydiff = _cam_y_goto - cam_y;
	var _min = 0.1;
	var _divider = 5;
	if (abs(_ydiff) <= _min){
		cam_y = _cam_y_goto;
	} else {
		cam_y += sign(_ydiff) * 0.5;;
	}
	if (first_step) cam_y = _cam_y_goto;
}
camera_set_view_pos(CAMERA, cam_x + _shake_x, cam_y + _shake_y);

if (state == "floor"){
	y = 0;
	while(!place_meeting(x, y+1, space_scooter_obj_block)) y += 1;
	
	
	checker_center = x - checker_center_offset;
	wheel_sep_as_percent = abs(lengthdir_x(1, image_angle));
	checker1.x = checker_center + (checker_rad * wheel_sep_as_percent);
	checker2.x = checker_center - (checker_rad * wheel_sep_as_percent);
	var _store_checker1_y = checker1.y;
	var _store_checker2_y = checker2.y;
	checker1.y = 0;
	checker2.y = 0;

	while(!collision_point(round(checker1.x), checker1.y+1, space_scooter_obj_block, 1, 0)){
		checker1.y += 1;
		if (checker1.y > room_height){
			checker1.y = _store_checker1_y;
			vsp = -0.5;
			state = "air";
			break;
		} else {
			
		}
	
	}

	while(!collision_point(round(checker2.x), checker2.y+1, space_scooter_obj_block, 1, 0)){
		checker2.y += 1;
		if (checker2.y > room_height){
			checker2.y = _store_checker2_y;
			break;
		}
	}

	
	if (state == "floor"){
		image_angle = point_direction(checker2.x, checker2.y, checker1.x, checker1.y);
		if (prev_angle > 180 && image_angle == 0) compress_timer = 8;
		if (prev_angle == 0 && image_angle > 0) compress_timer = 15;
		x += hsp;
	}

}


if (state == "air"){

	vsp = min(grav_max, vsp + grav);
	var _keydir = (KEY_LEFT || KEY_DOWN || KEY_SECONDARY) + -(KEY_RIGHT || KEY_UP || KEY_PRIMARY);
	spin += (_keydir) * spin_accel;
	if (sign(spin) != sign(_keydir)) {
		spin = spin * (1-(spin_accel/2));
		if (abs(spin) <= spin_accel) spin = 0;
	}
	if (abs(spin) > spin_speed_max) spin = sign(spin) * spin_speed_max;
	image_angle += spin;
	span += spin;

	x += hsp;
	
	if (vsp > 0){
		if (place_meeting(x, y+vsp, space_scooter_obj_block)){
			while(!place_meeting(x, y+sign(vsp), space_scooter_obj_block)) y += 1;

			var _min_survivable_angle = 30;
			var _angle_diff = abs(angle_difference(0, image_angle));
			
			if (_angle_diff <= 30){
		
				landed = true;
				state = "landed";
				if (span > 180) backflipped = true;
				is_perfect = backflipped && (_angle_diff <= 8);
				//show_message(_angle_diff);
				if (backflipped){
					microgame_win();
					var _frame = 1;
					if (is_perfect) _frame = 2;
					with (instance_create_layer(0, 0, layer, space_scooter_obj_indicator)) frame = _frame;
				} else {
					with (instance_create_layer(0, 0, layer, space_scooter_obj_indicator)) frame = 0;
				}
				compress_timer = 20;
				y = floor(y);
				x = floor(x);
				shake = 5;
				leveled = false;
				
				sfx_play(space_scooter_snd_motor_idle, 1, true);
			} else {
				vsp = -vsp * 0.8;
				x = floor(x);
				y = 0;
				while (!place_meeting(x, y+1, space_scooter_obj_block)) y += 1;
				spin = -10;
				shake = 10;
				lock_cam_x = true;
				state = "crashing";
				body_frame = 7;
				microgame_music_stop(0);
				sfx_play(space_scooter_snd_crash, 1, 0)
				instance_create_layer(x, y, layer, space_scooter_obj_crash_rabbit);
			}
			

		}
	}
	if (state == "air") y += vsp;
	
}

if (state == "crashing"){
	image_angle += spin;
	vsp = min(grav_max, vsp + grav);
	while (place_meeting(x, y, space_scooter_obj_block)) y-=1;
	if (place_meeting(x, y+vsp, space_scooter_obj_block)){
		while (!place_meeting(x, y+sign(vsp), space_scooter_obj_block)) y+= sign(vsp);
		if (vsp <= 0.1) vsp = 0; else vsp = -vsp * 0.8;
		
	}
	x += hsp;
	y += vsp;
}

if (state == "landed"){
	x += hsp;
	while (image_angle >= 360) image_angle -= 360;
	while (image_angle <= -360) image_angle += 360;
	
	if (!leveled){
		var _store_angle_sign = sign(image_angle);
		while(!place_meeting(x, y+1, space_scooter_obj_block)) y += 1;
		image_angle -= sign(angle_difference(image_angle, 0)) * 5;
		if (sign(image_angle) != _store_angle_sign){
			image_angle = 0;
			leveled = true;
		}
	}
	
	if (leveled){
		if (backflipped){
			wait = 20;
			state = "win_anim_1";
		} else {
			state = "lose_anim";
			wait = 15;
		}
	}

}

if (state == "lose_anim"){
	wait = max(0, wait-1);
	x += hsp;
}


if (state == "win_anim_1"){
	
	wait--;
	if (wait <= 0){
		state = "win_anim_2";
		lock_cam_x = true;
		cam_speed = hsp;
		body_frame = 7;
		instance_create_layer(0, 0, layer, space_scooter_obj_rabbit_end);
	}
	if (state == "win_anim_1") x += hsp;
}

if (state == "win_anim_2"){
	x += hsp;
	cam_x += cam_speed;
	if (space_scooter_obj_rabbit_end.finished) hsp = min(4, hsp + (1/30));
}

if (first_step) first_step = false;
steps++;

if (steps == 218){
	audio_stop_sound(idle_sound);
	idle_sound = sfx_play(space_scooter_snd_land, 1, 0)
}
prev_angle = image_angle;

