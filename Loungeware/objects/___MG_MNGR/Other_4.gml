view_visible[0] = true;
view_enabled = true;

// transition cutscene room
if (room == ___rm_restroom){
	___reset_draw_vars();
	audio_stop_all();
	surface_resize(application_surface, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
	camera_set_view_size(CAMERA, WINDOW_BASE_SIZE/2, WINDOW_BASE_SIZE/2);
	exit;
}

//microgame init room
if (room == microgame_current_metadata.init_room && !microgame_initiated){
	// reset the drawing values in case people forget to do it
	___reset_draw_vars();
	if (microgame_current_metadata.default_is_fail == false){
		microgame_win();
		___MG_MNGR.microgame_time_finished =  ___MG_MNGR.microgame_timer_max;
	}
	microgame_initiated = true;
}

// any microgame room (this incudes the init room and any subsequent rooms used for the microgame)
if (room != ___rm_restroom){
	var _vw = microgame_current_metadata.view_width;
	var _vh = microgame_current_metadata.view_height;
	if (_vw == -1) _vw = room_width;
	if (_vh == -1) _vh = room_height;
	camera_set_view_size(CAMERA, _vw, _vh);
}

