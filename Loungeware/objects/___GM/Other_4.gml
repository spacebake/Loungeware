view_visible[0] = true;
view_enabled = true;

// transition cutscene room
if (room == ___rm_restroom){
	___reset_draw_vars()
	audio_stop_all();
	prompt_timer = prompt_timer_max;
	application_surface_draw_enable(true);
	surface_resize(application_surface, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
	camera_set_view_size(CAMERA, WINDOW_BASE_SIZE/2, WINDOW_BASE_SIZE/2);
	exit;
} 

//microgame init room
if (room == microgame_current_metadata.init_room){
	
	// reset the drawing values in case people forget to do it
	___reset_draw_vars()
	if (microgame_current_metadata.default_is_fail == false){
		microgame_win();
		___GM.microgame_time_finished =  ___GM.microgame_timer_max;
	}
	application_surface_draw_enable(false);
	camera_set_view_size(CAMERA, microgame_current_metadata.view_width, microgame_current_metadata.view_height);
	exit;
}