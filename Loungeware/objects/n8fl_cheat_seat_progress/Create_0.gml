_percent = 0;
_target_percent = 1;
_percent_speed = 0.4;
_surface = -1;

_init = function(){
	
}

_cleanup = function(){
	if(surface_exists(_surface)){
		surface_free(_surface);	
	}
}

_tick = function(){
	depth = -room_width;
	_target_percent = inst_n8fl_cheat_seat_player.get_score_normalized();
	_percent = n8fl_impossible_move_to(_percent, _target_percent, _percent_speed);
}

_draw = function(){
	if(surface_exists(_surface) == false){
		_surface = surface_create(sprite_width, sprite_height);
	}
	
	if(surface_exists(_surface)){
		surface_set_target(_surface);
		draw_clear_alpha(c_white, 0);	
		
		// base white
		draw_sprite_ext(sprite_index, 0, 0, 0, 1, 1, 0, c_white, 0.5);
		
		// gradient
		draw_sprite_part(sprite_index, 1, 0, 0, _percent * sprite_width, sprite_height, 0, 0);
		
		// background
		gpu_set_blendmode(bm_subtract);
		draw_sprite(sprite_index, 2, 0, 0);
		gpu_set_blendmode(bm_normal);
		
		// outline
		draw_sprite(sprite_index, 3, 0, 0);
		
		// grade 
		draw_sprite(n8fl_cheat_seat_progress_letters_spr, _percent * 5 - 0.2, 0, 0);
		
		surface_reset_target();
		draw_surface(_surface, x, y);
	}
}