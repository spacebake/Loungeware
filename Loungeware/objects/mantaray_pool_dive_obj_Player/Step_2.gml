// Die
if (place_meeting(x, y, mantaray_pool_dive_obj_Floor) || x > VIEW_X + VIEW_W) {
	visible = false;
	stop_diving = true;
	if (!instance_exists(mantaray_pool_dive_obj_Head)) {
		with (instance_create_layer(x, 144, "mantaray_pool_dive_lyr_Instances", mantaray_pool_dive_obj_Head)) {
			sprite_index = mantaray_pool_dive_obj_Player.sprite_index;
		}
	}
	if (alarm[1] <= 0)	alarm[1] = 60;
}
else if (place_meeting(x, y, mantaray_pool_dive_obj_Pool)) {
	if (!mantaray_pool_dive_obj_Pool.successful_dive) {
		mantaray_pool_dive_obj_Pool.successful_dive = true;
	}
	stop_diving = true;
	if (alarm[1] <= 0)	alarm[1] = 60;
	if (alarm[2] <= 0)	alarm[2] = 20; // Show head in pool
	visible = false;
	microgame_win();
}
