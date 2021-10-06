// difficulty bg
if (false && diff_bg != noone && state != "playing_microgame"){
	draw_set_alpha(0.8);
	draw_sprite_stretched(diff_bg, diff_bg_frame, 0, 0, VIEW_W, VIEW_H);
	draw_set_alpha(1);
	diff_bg_frame += diff_bg_speed;
	if (diff_bg_frame >= sprite_get_number(diff_bg)) diff_bg_frame -= sprite_get_number(diff_bg);
}


// difficulty UP bg
if (df_bg_show){
	draw_set_alpha(df_bg_alpha * 0.5);
	draw_sprite_stretched(df_bg_sprite, df_bg_frame, 0, 0, VIEW_W, VIEW_H);
	draw_set_alpha(1);
	df_bg_frame += 0.6;
	if (df_bg_frame >= df_bg_frame_max) df_bg_frame -= df_bg_frame_max;
}



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

// draw difficulty up text
if (dft_state >= 1){

	// bg box
	draw_set_color(c_gbblack);
	var _box_h = 28;
	var _box_prog =  (dft_x - dft_x_min) / (dft_x_center - dft_x_min);
	//show_message(_box_prog);
	if (dft_state == 3) _box_prog = dft_scale_hard;
	draw_set_alpha(_box_prog);
	draw_rectangle_fix(dft_x_min, dft_y - (_box_h/2), dft_x_max, dft_y + (_box_h/2));
	draw_set_alpha(1);
	
	for(var i = 0; i < sprite_get_number(dft_sprite);i++){

		var _shake_prog = (dft_shake/dft_shake_max);
		var _sv = _shake_prog * 3;
		var _scale = (1 + abs(lengthdir_y(0.2, 180*_shake_prog))) * dft_scale_hard;
		var _x = dft_x + random_range(-_sv, _sv);
		var _y = dft_y + random_range(-_sv, _sv);
		draw_sprite_ext(dft_sprite, i, _x, _y, _scale, _scale, 0, c_white, 1);
	}
	
}

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
// life loss animation
// --------------------------------------------------------------------------------
if (heart_show_lose_seq){
	
	// draw health screen (this substate is bypassed if microgame was won)
	var _heart_w = sprite_get_width(___spr_life);
	var _margin = 12;
	var _total_w = (_heart_w * (life+1)) + (_margin * (life));
	var _heart_x = ((VIEW_W/2) - (_total_w / 2)) + (_heart_w/2);
	var _heart_y = heart_y;
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
// STATE | CART PREVIEW
// --------------------------------------------------------------------------------
if (state == "cart_preview"){

	var _scale = 0.5;
	var _spr_w = sprite_get_width(cart_sprite) * _scale;
	var _spr_h = sprite_get_height(cart_sprite)* _scale;
	
	var _x = ((VIEW_W/2) - (_spr_w/2));
	var _y = (((VIEW_H/2) - (_spr_h/2)) - 10) + lengthdir_y(2, cart_float_dir);
	draw_sprite_ext(cart_sprite, 0, _x, _y, _scale, _scale, 0, c_white, 1);
}


// --------------------------------------------------------------------------------
// gameboy crack and swing
// --------------------------------------------------------------------------------

if (ou_show_gameover_text){
	
	var _circle_rad = 120 + lengthdir_x(1, ou_circle_dir);
	var _downscale = 0.5;
	var _surf_size = VIEW_W * _downscale;
	var _text_scale = ou_gameover_text_scale;
	if (!surface_exists(ou_surf_circle)) ou_surf_circle = surface_create(_surf_size, _surf_size);

	// draw circle
	surface_set_target(ou_surf_circle);
	draw_clear_alpha(c_gbblack, 1);
	draw_set_color(c_red);
	draw_circle((_surf_size/2)-1, (_surf_size/2)-1, _circle_rad * _downscale, false);
	surface_reset_target();

	draw_set_alpha(min(1,_text_scale));
	gpu_set_colorwriteenable(1, 1, 1, 0); 
	draw_surface_stretched(ou_surf_circle, 0, 0, VIEW_W, VIEW_H);
	gpu_set_colorwriteenable(1, 1, 1, 1); 
	draw_set_alpha(1);
	ou_circle_dir += 2;
	
	// draw GAME OVER
	draw_set_color(c_gbwhite);
	draw_set_font(ou_fnt_gallery);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle)
	var _x = VIEW_W/2;
	var _y = (VIEW_H/2) - 40;

	//___global.___draw_text_advanced(_x, _y, 32, false, true, "0", 0.5, _text_scale, 0);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top)
}

if (ou_draw_games){
	var _xc = VIEW_W/2;
	var _yc = VIEW_H/2;
	for (var i  = 0; i < array_length(played_record); i++){
		with(played_record[i]){
					var _dist_mod = lengthdir_x(1, other.ou_games_global_rad_dir + ((360/array_length(other.played_record))*i));
					if (i mod 2 == 0) _dist_mod = -_dist_mod;
					var _dist = (other.ou_games_global_rad + dist + _dist_mod) - pullback;
					var _sep = 360 / array_length(other.played_record);
					var _dir = other.ou_games_dir + (_sep*i);
					var _x = _xc + lengthdir_x(_dist, _dir);
					var _y = _yc + lengthdir_y(_dist, _dir);
					var _scale = (abs(_dist) / other.ou_games_global_rad_max) + 1;
					if (state == 1 && pullback >= other.ou_cart_pullback_max){
						_x += random_range(-1, 1);
						_y += random_range(-1, 1);
					}
					//draw_set_color(c_gbpink);
					//draw_circle(_x, _y, 5*other.ou_games_global_scale, 0);
					var _angle = point_direction(_x, _y, VIEW_W/2, VIEW_H/2) + 90;
					___shader_cartridge_on(variable_struct_get(___global.microgame_metadata, game));
					draw_sprite_ext(___spr_cart_gameover, 0, _x, _y, _scale, _scale, _angle, c_white, 1);
					___shader_cartridge_off();
		}

	}

	
}

if (ou_draw_scorebox){
	// draw scorebox larold
	draw_set_color(c_gbyellow);
	draw_set_font(___global.___fnt_gallery);
	var _str = string(ou_score_display);
	while(string_length(_str) < 4) _str = "0" + _str;
	var _scale = (1 + ou_scorebox_scale_mod) * ou_scorebox_larold_scale;
	var _pad = 12;
	var _w = (string_width(_str)+ _pad) * _scale;
	var _rx =VIEW_W/2;
	var _ry = (VIEW_H/2) + ou_scorebox_y_offset;
	if (ou_scorebox_larold_shake > 0){
		var _sv = 2;
		_rx += random_range(-_sv,_sv);
		_ry += random_range(-_sv,_sv);
	}
	draw_set_color(c_gbwhite);
	draw_circle(_rx, _ry, _w/2, 0);
	draw_set_color(c_gbdark);
	draw_circle(_rx, _ry, (_w/2)-4, 0);
	draw_set_color(c_gbwhite);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed(_rx+1, _ry+3, _str, _scale, _scale, 0);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}


// flash
if (ou_flash > 0){
	draw_set_color(c_gbwhite);
	draw_set_alpha(ou_flash);
	draw_rectangle_fix(0, 0, VIEW_W, VIEW_H);
	draw_set_alpha(1);
}