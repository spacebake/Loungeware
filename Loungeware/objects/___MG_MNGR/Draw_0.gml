// draw the gameboy
if (gb_show) draw_gameboy(gb_scale, gb_x_offset, gb_y_offset, gb_spin, gb_slot_is_empty);

// draw game title/auth
if (title_alpha > 0){
	draw_set_alpha(title_alpha);
	___draw_title(VIEW_W/2, title_y);
	draw_set_alpha(1);
}

// draw cartidge 
if (cart_show){
	draw_sprite_ext(cart_sprite, 0, cart_x, cart_y, cart_scale/2, cart_scale/2, cart_angle, c_white, 1);
}

// draw backsprite on gameboy to cover cartridge
if (gb_cover_cartridge) draw_sprite_ext(___spr_gameboy_back, 2, gb_x, gb_y, gb_scale_true, gb_scale_true, 0, c_white, 1);

// -----------------------------------------------------------
// STATE | intro_hearts
// -----------------------------------------------------------
if (state == "intro_hearts"){
	
	var _heart_spr = ___spr_life;
	var _heart_w = sprite_get_width(_heart_spr);
	var _margin = 12;
	var _total_w = (_heart_w * life_max) + (_margin * (life_max-1));
	var _heart_x = ((VIEW_W/2) - (_total_w / 2)) + (_heart_w/2);
	var _heart_y = ((canvas_y + (canvas_h/2)))/2;
	var _sway_size = 15;
	
	// draw hearts
	for (var i = 0; i < life; i++){
		var _y_mod = lengthdir_y(1, heart_dir + (i * 40));
		var _alpha = heart_alpha;
		var _frame = 0;
		var _sway_dir = (_sway_size*lengthdir_y(1, heart_dance_dir + (i*5)));
		draw_sprite_ext(_heart_spr, _frame, _heart_x, _heart_y + _y_mod, heart_scale, heart_scale, _sway_dir, c_white, _alpha);
		_heart_x += _heart_w + _margin;
	}
	
}

// -----------------------------------------------------------
// STATE | MICROGAME RESULT
// -----------------------------------------------------------
if (state == "microgame_result"){
	if (TEST_MODE_ACTIVE || gallery_mode){
		var _str = (microgame_won ? "WON" : "LOST");
		draw_set_color(c_white);
		draw_set_font(fnt_frogtype);
		draw_set_halign(fa_center);
		draw_set_color(c_gbwhite);
		draw_text_transformed(VIEW_W/2, 95, _str, 2, 2, 0);
		draw_set_halign(fa_left);
	}
}

// --------------------------------------------------------------------------------
// STATE | LIFE_LOSE
// --------------------------------------------------------------------------------
if (state == "life_lose"){
	
	// draw health screen (this substate is bypassed if microgame was won)
	var _heart_w = sprite_get_width(___spr_life);
	var _margin = 12;
	var _total_w = (_heart_w * life_max) + (_margin * (life_max-1));
	var _heart_x = ((VIEW_W/2) - (_total_w / 2)) + (_heart_w/2);
	var _heart_y = ((canvas_y + (canvas_h/2)))/2;
	var _shake_val = (1-(heart_shake_timer/heart_shake_timer_max)) * 3;
	
	for (var i = 0; i < life + 1; i++){
		var _is_last_heart = (i == life);
		var _y_mod = lengthdir_y(1, heart_dir + (i * 40));
		var _frame = 0;
		var _sprite = ___spr_life;
		var _shaking = (heart_shake_timer > 0 && heart_alpha_done);
		
		if (_is_last_heart){
			_frame = heart_last_frame; 
			_sprite = ___spr_life_lose;
			if (_shaking){
				_heart_x += random_range(-_shake_val, _shake_val);
				_heart_y += random_range(-_shake_val, _shake_val);
			}
		}
		
		draw_sprite_ext(_sprite, _frame, _heart_x, _heart_y + _y_mod, heart_scale, heart_scale, 0, c_white, heart_alpha);
		_heart_x += _heart_w + _margin;
	}
		
}

// --------------------------------------------------------------------------------
// STATE | GAME SWITCH TRANSITION 
// --------------------------------------------------------------------------------
if (state == "game_switch"){
	
	

}

// --------------------------------------------------------------------------------
// STATE | CART PREVIEW
// --------------------------------------------------------------------------------
if (state == "cart_preview"){
	if (state_begin){
		audio_stop_all();
		cart_float_dir = 0;
	}
	
	cart_float_dir += 2.5;
	if (cart_float_dir >= 360) cart_float_dir -= 360;
	var _scale = 0.5;
	var _spr_w = sprite_get_width(cart_sprite) * _scale;
	var _spr_h = sprite_get_height(cart_sprite)* _scale;
	
	var _x = ((VIEW_W/2) - (_spr_w/2));
	var _y = (((VIEW_H/2) - (_spr_h/2)) - 10) + lengthdir_y(2, cart_float_dir);
	draw_sprite_ext(cart_sprite, 0, _x, _y, _scale, _scale, 0, c_white, 1);
}


