view_visible[0] = true;
view_enabled = true;

// transition cutscene room
if (room == ___rm_restroom){
	prompt_timer = prompt_timer_max;
	application_surface_draw_enable(true);
	surface_resize(application_surface, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
	camera_set_view_size(CAMERA, WINDOW_BASE_SIZE/2, WINDOW_BASE_SIZE/2);
} 

//microgame init room
if (room == microgame_current_metadata.init_room){
	
	// reset the drawing values in case people forget to do it
	draw_set_color(c_white);
	draw_set_font(fnt_frogtype);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	if (microgame_current_metadata.default_is_fail == false){
		microgame_win();
		___GM.microgame_time_finished =  ___GM.microgame_timer_max;
	}
	application_surface_draw_enable(false);
	camera_set_view_size(CAMERA, microgame_current_metadata.view_width, microgame_current_metadata.view_height);
}