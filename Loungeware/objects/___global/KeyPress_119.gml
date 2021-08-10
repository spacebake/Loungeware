if (window_get_fullscreen()){
	window_set_fullscreen(false);
	___center_window();
} else {
	window_set_fullscreen(true);
}
