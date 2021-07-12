hsp = 2.5;
vsp = 0;
spin = 0;
spin_accel = 0.1;
spin_speed_max = 8;
grav = 0.018//0.01;
grav_max = 5;
cam_y = 0;
first_step = true;
lock_cam_y = false;
lock_cam_x = false;
prev_angle = image_angle;
compress_timer = 0;
rabbit_frame = 2;
cam_x = 0;
floor_col = make_color_rgb(122, 88, 89);
landed = false;
span = 0;
backflipped = false;
shake = 0;
leveled = false;
smoke_timer_max = 7;
smoke_timer = smoke_timer_max;
steps = 0;
idle_sound = sfx_play(space_scooter_snd_motor_seq, 1, 0);
dpad_alpha = 0;
wait = 0;
body_frame = 0;
cam_x_offset = 0;
is_perfect = false;

y = 0; 
while(!place_meeting(x,y+1,space_scooter_obj_block)) y += 1;

_dir_diff = point_direction(x, y, bbox_right, bbox_bottom) - direction;
_rad = point_distance(x, y, bbox_right, bbox_bottom);

direction = 0;
spin = 1;
state = "floor";

checker1 = {
	x: bbox_right - 2,
	y:bbox_bottom,
}

checker2 = {
	x: bbox_left + 5,
	y:bbox_bottom,
}

wheel_sep_as_percent = abs(lengthdir_x(1, image_angle));
checker_center = (checker1.x + checker2.x) /2;
checker_center_offset = x - checker_center;
checker_rad = (checker1.x - checker2.x)/2;

