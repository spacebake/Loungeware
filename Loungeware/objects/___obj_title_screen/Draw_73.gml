

if (close_circle_prog < 1){
	var _size = WINDOW_BASE_SIZE/2;
	if (!surface_exists(circle_surf)){
		circle_surf = surface_create(_size, _size);
	}

	surface_set_target(circle_surf);
	draw_clear(c_gbdark);
	gpu_set_blendmode(bm_subtract);
	var _rad = close_circle_prog * (_size/2);
	draw_circle(_size/2, (_size/2)/*-30*/, close_circle_prog * ( _size*0.8), 0);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	draw_surface_stretched(circle_surf, 0, 0, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
}

// draw logo
if (logo_draw_last) ___draw_logo();