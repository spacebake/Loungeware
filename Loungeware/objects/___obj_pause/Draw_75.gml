if (step < 1) exit;
var _jam_active = !audio_is_paused(jam_id);
var _scale = window_get_height() / WINDOW_BASE_SIZE;
var _os = (window_get_width() - window_get_height())/2;
display_set_gui_maximise(_scale, _scale, _os, 0);




if (keyboard_check_pressed(vk_space)) larold_frame = irandom(sprite_get_number(___spr_larold_heads)-1);
// take screenshot
//if (state == "capture_image"){
	
//	var _window_x_offset = (window_get_width() - window_get_height())/2;
//	screen_save_part(filename, _window_x_offset, 0, window_get_height(), window_get_height());
//	pause_image = sprite_add(filename, 1, 0, 0, 0, 0);
//	store_appsurf_w = surface_get_width(application_surface);
//	store_appsurf_h = surface_get_width(application_surface);
//	surface_resize(application_surface, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
//	state = "pause_room";
//}

//if (sprite_exists(pause_image)){
//	draw_sprite_stretched(pause_image, 0, 0, 0, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
//}

if (state != "wait"){
	draw_set_color(c_gbblack);
	draw_set_font(fnt_frogtype);
	var _overlay_alpha = 1;
	draw_set_alpha(_overlay_alpha);
	draw_rectangle_fix(0, 0, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
	draw_set_alpha(1);

	var _xx = WINDOW_BASE_SIZE/2;
	var _yy = 200;
	
	// draw circle
	
	var _circle_res = 48;
	if (!surface_exists(surf_circle)) surf_circle = surface_create(_circle_res, _circle_res);
	surface_set_target(surf_circle);
	
	draw_clear_alpha(c_gbblack, 1);
	draw_set_color(col_circle);
	draw_circle((_circle_res/2)-1, (_circle_res/2)-1, _circle_res/2, 0);

	surface_reset_target();
	var _circle_draw_size = 240 + lengthdir_y(3, circle_dir) //+ (20*beated);
	circle_dir += random_range(0, 5);
	draw_surface_stretched(
		surf_circle, 
		_xx - (_circle_draw_size/2), 
		_yy  - (_circle_draw_size/2),
		_circle_draw_size,
		_circle_draw_size
	);
	
	// draw larold doodle
	sprite_dir += 2;
	var _scale = 1;
	var _dir = beat_prog;
	
	
	_scale += 0.1 * beated;
	var _spr_x = _xx;
	var _spr_y = _yy;
	_spr_y = _yy + -abs(lengthdir_y(5, 720 * _dir));
	_spr_x = _xx +  lengthdir_x(10*_jam_active, 720 * _dir);
	
	
	draw_sprite_ext(
		___spr_larold_heads, 
		larold_frame, 
		_spr_x - 5, 
		_spr_y  + lengthdir_y(2*_jam_active, sprite_dir), 
		_scale, _scale, 
		0, c_white, 1);
	var _h = sprite_get_height(___spr_larold_heads);
	_yy += _h/2;

	// draw PAUSED text
	draw_set_color(c_gbwhite);
	draw_set_halign(fa_center);
	var _scale = 2;
	var _txt =  "PAUSED";
	if (_jam_active) _txt = "<wave>" + _txt

	
	___global.___draw_text_advanced(_xx, _yy, 32, true, true, _txt, 1, _scale, 12);
	_yy += 38;
	
	// draw dotted line
	var _w = 280;
	var _x1 = _xx - (_w/2) + (random_range(-2, 2)*beated);
	var _x2 = _x1 + (_w);
	linedir += (360/(tempo*beat_interval));
	var _wave_rad = 0;
	if (_jam_active) _wave_rad = 2;
	draw_set_color(col_circle);
	var _sep = 8;
	var j = 0;
	var j_max = (_x2 - _x1) div _sep;
	for (var i = _x1; i < _x2; i += _sep){
		var _dir = linedir + (720 * (j/j_max));
		var _rx = i;
		var _ry = _yy + lengthdir_y(_wave_rad, _dir);
		draw_rectangle_fix(_rx, _ry, _rx + (_sep/2), _ry+(_sep/2));
		j += 1;
	}

	
	_yy += 20;
	
	// draw menu
	draw_set_valign(fa_middle);
	for (var i = 0; i < array_length(menu); i++){
		draw_set_color(c_gbwhite);
		var _txt = menu[i].name;
		var _scale_final = 1;
		var _is_diff = (_txt == "DIFFICULTY");
		var _letter_sep = 2;
		var _letter_w = string_width("M");
		
		if (_is_diff){
			if (cursor == i){
				var _diffmove = -KEY_LEFT_PRESSED + KEY_RIGHT_PRESSED;
				var _store_diff = DIFFICULTY;
				___global.difficulty_level = clamp(___global.difficulty_level + _diffmove, 1, ___global.difficulty_max);
				if (_store_diff != DIFFICULTY){
					___sound_menu_tick_horizontal();
				}
				
			}
			_txt = _txt + ": " + string(DIFFICULTY);
			if (cursor == i){
				var _w = 8 + floor((string_length(_txt) * (_letter_sep + _letter_w)) - _letter_sep);
				var _arrow_y = _yy - 5;
				draw_sprite(___spr_gallery_arrows, 4, _xx - (_w/2), _arrow_y);
				draw_sprite(___spr_gallery_arrows, 5, _xx + (_w/2), _arrow_y);
			}
		}
		
		if (cursor == i){
			if (confirm_shake_timer > 0){
				draw_set_color(c_gbpink);
				_txt = "<shake, " + string(confirm_shake_timer) + ">" + _txt + "</shake>";
				_scale_final = 1 + (0.5 * (confirm_shake_timer/confirm_shake_timer_max));
			} else {
				draw_set_color(c_gbyellow);
				_txt = "<wave>" + _txt;
			}
		}
	
		_scale_final = _scale_final + (0.25 * beated);
		___global.___draw_text_advanced(_xx, _yy, 32, true, true, _txt, 1, _scale_final, _letter_sep);
		_yy += 28;
	}
	
	_yy += 5;
	
	// draw dotted line  2
	var _w = 280;
	var _x1 = _xx - (_w/2) + (random_range(-2, 2)*beated);
	var _x2 = _x1 + (_w);
	linedir += (360/(tempo*beat_interval));
	var _wave_rad = 0;
	if (_jam_active) _wave_rad = 2;
	draw_set_color(col_circle);
	var _sep = 8;
	var j = 0;
	var j_max = (_x2 - _x1) div _sep;
	for (var i = _x1; i < _x2; i += _sep){
		var _dir = linedir - (720 * (j/j_max));
		var _rx = i;
		var _ry = _yy + lengthdir_y(_wave_rad, _dir);
		draw_rectangle_fix(_rx, _ry, _rx + (_sep/2), _ry+(_sep/2));
		j += 1;
	}
	
	//draw larold credit
	draw_set_font(fnt_impendium);
	draw_set_color(c_gbwhite);
	___global.___draw_text_advanced(_xx, 50, 32, true, true, "" + larold_credits[larold_frame], 1, 1, 4);

	
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	
	
}

if (state == "wait" && step > 0){
	draw_sprite(___spr_pause_wait, elip_frame, WINDOW_BASE_SIZE / 2, 10);
	elip_frame += 0.05;
	if (elip_frame >= sprite_get_number(___spr_pause_wait)) elip_frame = 0;
}


with (___MG_MNGR){
	display_set_gui_maximise(gui_scale, gui_scale, gui_x, gui_y);
}

