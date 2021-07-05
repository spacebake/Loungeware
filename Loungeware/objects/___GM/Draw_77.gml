var _min = min(window_get_width(), window_get_height());
prev_window_scale = window_scale;
window_scale = _min / WINDOW_BASE_SIZE;

// -----------------------------------------------------------
// STATE | PLAYING_MICROGAME
// -----------------------------------------------------------
if (state == "playing_microgame"){
	
	create_master_surface();
	draw_gameboy_overlay();
	draw_microgame();
	
	// circle transition surface
	draw_circle_transition();
	
	// prompt
	if (prompt_timer > 0){
		surface_set_target(surf_master);
		var _prompt_scale = 2;
		var _prompt_x = ((canvas_x + (canvas_w/2)) * 1);
		var _prompt_y = ((canvas_y + (canvas_h/2)) * 1);
		draw_sprite_ext(
			prompt_sprite, 0, 
			_prompt_x * window_scale, 
			_prompt_y * window_scale, 
			_prompt_scale * window_scale, 
			_prompt_scale * window_scale, 
			0, 
			c_white, 
			prompt_alpha
		);
		surface_reset_target();
		prompt_timer = max(0, prompt_timer-1);
	}

	draw_master_surface();
	
	
}

// -----------------------------------------------------------
// STATE | GAME_OPEN
// -----------------------------------------------------------
if (state == "game_open"){

	surface_set_target(surf_master)
	surface_reset_target();
	draw_master_surface();
}

