if (window_get_fullscreen()){
	window_set_cursor(cr_default);
	window_set_fullscreen(false);
	___center_window();
} else {
	window_set_cursor(cr_none);
	window_set_fullscreen(true);
}
