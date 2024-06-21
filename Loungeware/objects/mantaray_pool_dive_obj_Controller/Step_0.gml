if (mantaray_pool_dive_obj_Player.stop_diving)  {
	sfx_stop(audio_drum_roll, 0);
	
	if (mantaray_pool_dive_obj_Pool.successful_dive) {
		if (!audio_splash_played) {
			sfx_play(mantaray_pool_dive_snd_Splash, 1, false);
			audio_splash_played = true;
			alarm[1] = 20;
		}		
		target = mantaray_pool_dive_obj_Pool;
		var _mid_pool_y = target.y - target.sprite_height/4;
	}
	else {
		if (!audio_bump_played)	{
			sfx_play(mantaray_pool_dive_snd_Bump, 1, false);
			audio_bump_played = true;
		}
		if (!audio_crash_played)	{
			sfx_play(mantaray_pool_dive_snd_Crash, 1, false);
			audio_crash_played = true;
		}
		target = mantaray_pool_dive_obj_Head;
		var _mid_pool_y = target.y;
	}
	
	var _pad = 5;
	var _x1 = target.bbox_left-_pad;
	var _x2 = target.bbox_right+_pad;
	var _w = _x2-_x1+2*_pad;
	var _h = _w/1.5;	// Aspect ratio of console screen
	
	var _y1 = _mid_pool_y - _h/2;
	var _y2 = _mid_pool_y + _h/2;
		
	camera_set_view_pos(CAMERA, lerp(camera_get_view_x(CAMERA), _x1-_pad, camera_speed), lerp(camera_get_view_y(CAMERA), _y1-_pad, camera_speed));
	camera_set_view_size(CAMERA, clamp(lerp(camera_get_view_width(CAMERA), _w, camera_speed), 0, VIEW_X+VIEW_W), 
								 clamp(lerp(camera_get_view_height(CAMERA), _h, camera_speed), 0, VIEW_Y+VIEW_H));
}
else if (DIFFICULTY >= 4) {
	camera_set_view_pos(CAMERA, choose(-1,0,1), choose(-1,0,1));
}
