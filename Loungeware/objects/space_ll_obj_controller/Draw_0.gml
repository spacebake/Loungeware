if (show_lineup){
	// draw shadows
	var _shadow_move_rad = 1;
	var _shadow_offset_x = lengthdir_x(_shadow_move_rad, shadow_dir);
	var _shadow_offset_y = 0;
	shader_shadow_on(col_shadow_lineup);
	for (var i = 0; i < array_length(suspects); i++){
		with (suspects[i]){
			sx = 0; sy = 0;
			var _sv = min(2, shaking);
			sx = random_range(-_sv, _sv);
			sy = random_range(-_sv, _sv);
			var _shx = x + _shadow_offset_x;
			var _shy = -3 + _shadow_offset_y;
			draw_sprite(space_ll_spr_larolds, image, _shx + sx, _shy + sy);
		}
	}
	shader_reset();


	// draw rectangle to cover shadows on floor
	draw_set_color(col_floor);
	draw_rectangle_fix(0, room_height -21, room_width, room_height);

	// draw characters
	for (var i = 0; i < array_length(suspects); i++){
		with (suspects[i]){
			draw_sprite(space_ll_spr_larolds, image, x + sx, 0 + sy);
		}
	}
	
// draw baku
if (show_baku_throw){
		
	shader_shadow_on(col_shadow_lineup);
	var _shadow_prog = 1 - (baku_throw_frame / sprite_get_number(space_ll_spr_baku_thrown_alt));
	draw_sprite(space_ll_spr_baku_thrown_alt, baku_throw_frame, 2, 3 + -(18 * _shadow_prog));
	shader_reset();
	
	draw_sprite(space_ll_spr_baku_thrown_alt, baku_throw_frame, 0, 0);
}
	
	// draw prison bars
	if (show_bars){
		var _bars_prog = 1- (bars_x / room_width);
		draw_set_color(col_baku_shadow);
		draw_set_alpha(_bars_prog * 0.7);
		draw_rectangle_fix(0, 0, room_width, room_height);
		draw_set_alpha(1);
		draw_sprite(space_ll_spr_bg, 1, bars_x + bars_shake_x, bars_shake_y);
		
	}

	// draw lens correction effect
	gpu_set_blendmode_ext(bm_dest_colour, bm_zero);
	var _lens_variance = 8;
	var _lens_dir = shadow_dir*1.5;
	var _lens_w = (room_width + _lens_variance) - lengthdir_x(_lens_variance, _lens_dir);
	var _lens_h = (room_height + _lens_variance) - lengthdir_y(_lens_variance, _lens_dir)
	var _lens_x = ((room_width-_lens_w)/2);
	var _lens_y = ((room_height-_lens_h)/2);
	draw_sprite_stretched(space_ll_spr_lens, 0, _lens_x, _lens_y, _lens_w, _lens_h);
	gpu_set_blendmode(bm_normal);
	

}



if (show_menu){
	if (state =="choose") paper_dir += 3;
	baku_dir += 3;
	
	draw_set_color(col_bg);
	draw_rectangle_fix(0, 0, room_width*2, room_height*2);
	var _px = 50 /*+ (180 - (180*poster_prog))*/;
	var _py = poster_y;
	draw_sprite(space_ll_spr_wanted_poster, 0, _px, _py);
	
	var _bbx = 0;
	var _bby = -_py;
	
	// draw baku
	var _bsv = min(baku_shake, 3);
	var _bsx = random_range(-_bsv, _bsv);
	var _bsy = random_range(-_bsv, _bsv);
	var _baku_x = 0 + _bsx /* + (-180 + (180 * poster_prog))*/;
	var _baku_rad = 1;
	var _baku_y = _bby + _baku_rad + lengthdir_y(_baku_rad, baku_dir) + _bsy;
	var _shadow_rad = _baku_rad*2;
	var _shadow_y = _bby + _shadow_rad + lengthdir_x(_shadow_rad, baku_dir) + _bsy;
	var _exclamation_y = _bby + _baku_rad  + lengthdir_y(_baku_rad, baku_dir+90) + (_bsy*2);
	
	//shadow baku
	shader_shadow_on(col_baku_shadow);
	draw_sprite(space_ll_spr_wanted_poster, 2 + baku_frame, _baku_x-20, _shadow_y+8);
	shader_reset();
	
	// regular baku
	draw_sprite(space_ll_spr_wanted_poster, 2 + baku_frame, _baku_x, _baku_y);
	
	// spooky boi
	var _spoop_y = _baku_y + lengthdir_y(2, current_time/5);
	draw_sprite(space_ll_spr_wanted_poster, 8 + baku_frame, _baku_x, _spoop_y );
	
	
	// draw exclamation
	draw_set_alpha(poster_prog);
	draw_sprite(space_ll_spr_wanted_poster, 5 + baku_frame, _baku_x, _exclamation_y);
	draw_set_alpha(1);
	
	// draw bottom bar
	draw_sprite(space_ll_spr_wanted_poster, 1, _bbx, _bby);
	
	// draw character on poster
	var _char_x = (((VIEW_W - suspect_w)/2) + _px);
	var _char_y = _py + 22;
	draw_sprite(space_ll_spr_larolds, guilty_suspect.base_image, _char_x, _char_y);
	
	// draw papers
	var _px = 120;
	var _py = -_py + 276;
	var _pw = 75;
	var _pmarg = 43;
	
	var _pdir = 0;
	for (var i = 0; i < 3; i++){
		var _img = i*2;
		var _pdir = 0;
		var _pscale = 1;
		var _is_correct = guilty_suspect.card_number == i+1;
		if (selected == i){
			_img += 1;
			_pdir = lengthdir_y(4, paper_dir)
			_pscale = 1.2;
		}
		
		var _sv = (answershake > 0) ? clamp(answershake/2, 0, 5) : 0;
		var _sx = random_range(-_sv, _sv);
		var _sy = random_range(-_sv, _sv);
		
		// draw card/number
		draw_sprite_ext(space_ll_spr_paper, _img, _px + (_sx*2), _py + (_sy*2), _pscale, _pscale, _pdir, c_white, 1);
		
		// draw answer
		if (show_answers){

			draw_sprite_ext(space_ll_spr_paper, 6+_is_correct, _px + _sx, _py + _sy, 1, 1, 0, c_white, 1);
		}
		
		_px += _pw + _pmarg;
	}
}

if (show_freezeframe && sprite_exists(spr_freezeframe)){
	if (!surface_exists(surf_freezeframe)) surf_freezeframe = surface_create(sprite_get_width(spr_freezeframe), sprite_get_height(spr_freezeframe));
	surface_set_target(surf_freezeframe);
	draw_sprite(spr_freezeframe,0,0,0);
	surface_reset_target();

}

if (fade_alpha > 0){
	var _scale = 1;

	if (show_freezeframe && surface_exists(surf_freezeframe)){
		_scale = sprite_get_width(spr_freezeframe) / room_width;
		surface_set_target(surf_freezeframe);
	}
	var _w = sprite_get_width(space_ll_spr_diamond);
	
	for(var _xx = 0; _xx < (room_width + _w)*_scale; _xx += (_w/2) * _scale){
		for (var _yy = 0; _yy < (room_height+_w)*_scale; _yy += (_w/2)*_scale){
			if (show_freezeframe) gpu_set_blendmode(bm_subtract);
			draw_sprite_ext(space_ll_spr_diamond, 0, _xx, _yy, fade_alpha * _scale, fade_alpha*_scale, 0, c_white, 1);
			if (show_freezeframe) gpu_set_blendmode(bm_normal);
		}
	}
	
	if (surface_get_target() == surf_freezeframe) surface_reset_target();
}

// draw the screenshot surface
if (show_freezeframe && surface_exists(surf_freezeframe)){
	draw_surface_stretched(surf_freezeframe, 0, 0, VIEW_W, VIEW_H);
}