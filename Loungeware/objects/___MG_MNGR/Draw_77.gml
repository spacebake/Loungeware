var _min = min(window_get_width(), window_get_height());
prev_window_scale = window_scale;
window_scale = _min / WINDOW_BASE_SIZE;

// -----------------------------------------------------------
// STATE | PLAYING_MICROGAME
// -----------------------------------------------------------
if (state == "playing_microgame"){
	gpu_set_texfilter(false);
	create_master_surface();
	draw_gameboy_overlay();
	draw_microgame();
	draw_circle_transition();
	draw_master_surface();
} else {
	var _draw_size = window_get_height();
	var _x = (window_get_width() - _draw_size)/2;
	var _y = 0;
	draw_surface_stretched(application_surface, _x, _y, _draw_size, _draw_size);
}

// -----------------------------------------------------------
// draw prompt
// -----------------------------------------------------------
if (prompt_timer > 0){
	draw_prompt();
}

// -----------------------------------------------------------
// turn on interpolation if applicable (this should come last)
// -----------------------------------------------------------
if (state == "playing_microgame"){
	if (microgame_current_metadata.interpolation_on) gpu_set_texfilter(true);
}

