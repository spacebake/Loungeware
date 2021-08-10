if (room == ___rm_main_menu){
	display_set_gui_maximise();
	camera_set_view_size(CAMERA, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE)
	surface_resize(application_surface, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE)
}

log("room start: " + room_get_name(room));