//------------------------------------------------------------------------------------------
// STATE | Begin
//------------------------------------------------------------------------------------------

if (state == "begin"){
	
	// slide in
	if (!wait) menu_y = ___smooth_move(menu_y, VIEW_H/2, 0.5, 10);
	
	// move cursor
	var _menu_len = array_length(menu);
	var _store_cursor_pos = cursor;
	v_move = -KEY_UP_PRESSED + KEY_DOWN_PRESSED;
	last_v_move = v_move;
	cursor += v_move;
	if (cursor > _menu_len - 1) cursor = 0;
	if (cursor < 0) cursor = _menu_len - 1;
	if (_store_cursor_pos != cursor){
		var _snd_index  = ___snd_menu_tick;
		var _snd_id = audio_play_sound(_snd_index, 0, 0);
		var _vol = VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index);
		audio_sound_gain(_snd_id, _vol, 0);
		audio_sound_pitch(_snd_id, random_range(0.99, 1.01));
	}
	
	// check for confirm
	var _confirm = (KEY_PRIMARY || ___KEY_PAUSE);
	if (_confirm){
		if (menu_method[cursor] == noop){
			show_message("coming soon");
		} else {
			// stop sound
			audio_sound_gain(sng_id, 0, 100);
			
			// play snd
			var _snd_index  = ___snd_cart_insert;
			var _snd_id = audio_play_sound(_snd_index, 0, 0);
			var _vol = VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index) * 0.7;
			audio_sound_gain(_snd_id, _vol, 0);
			vsp = 5;
			confirmed = true;
			state = "fadeout";
		}
	}
	wait = max(0, wait-1);
}




//------------------------------------------------------------------------------------------
// ALL
//------------------------------------------------------------------------------------------
// draw logo
draw_sprite(___spr_logo_title, 1, VIEW_W/2, menu_y);
	
	
// draw text
var _scale = 2;
var _text_x = VIEW_W/2;
var _text_y = menu_y - 16;
var _v_sep = 18 * _scale;
var _h_sep = 2;
var _selected, _str, _text_y_final, _scale_final;
draw_set_font(fnt_frogtype);
draw_set_halign(fa_center);
	
for (var i = 0; i < array_length(menu); i++){
	_selected = (cursor == i);
	_scale_final = _scale;
	draw_set_color(c_larold);
	_str = menu[i];
	var _str_w = (___global.___draw_text_advanced_width(_str, _h_sep) * _scale_final) + 8;
	_text_y_final =  _text_y  + (_v_sep * i);
	if (_selected){
		
		draw_set_color(c_gbyellow);
			
		if (confirmed){
			draw_set_color(c_gbpink);
			if (confirm_shake_time > 0) _str = "<shake, " + string(confirm_shake_time) + ">" + _str + "</shake>";
			confirm_shake_time = max(0, confirm_shake_time - 1);
			_scale_final = 2.5;
		} else {
			_str = "<wave, 2>" + _str + "</shake>";
			
		}
	}
	//if (menu_method[i] == noop) draw_rectangle_fix(_text_x-(_str_w/2), _text_y_final + 10, _text_x + (_str_w/2), _text_y_final + 14); 
	___global.___draw_text_advanced(_text_x, _text_y_final, _v_sep, true, true, _str, 1, _scale_final, _h_sep);
}


//------------------------------------------------------------------------------------------
// STATE | FADEOUT
//------------------------------------------------------------------------------------------
if (state == "fadeout"){
	
	if (menu[cursor] == "EXIT" && goodbye_played == false){
		goodbye_played = true;
		var _snd_index  = ___snd_goodbye;
		var _snd_id = audio_play_sound(_snd_index, 0, 0);
		var _vol = VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index) * 0.5;
		audio_sound_gain(_snd_id, _vol, 0);
	}
	
	
	var _size = WINDOW_BASE_SIZE/2;
	if (!surface_exists(circle_surf)){
		circle_surf = surface_create(_size, _size);
	}

	surface_set_target(circle_surf);
	draw_clear(close_col);
	gpu_set_blendmode(bm_subtract);
	draw_circle(_size/2, (_size/2)/*-30*/, close_circle_prog * ( _size*0.8), 0);
	gpu_set_blendmode(bm_normal);

	surface_reset_target();
	draw_surface_stretched(circle_surf, 0, 0, VIEW_W, VIEW_H);
	close_circle_prog = max(0, close_circle_prog - (1/30));
	if (close_wait_before > 0){
		close_wait_before -=1;
	} else {
		if (close_circle_prog <= 0) close_wait--;
	}

	
	if (close_wait <= 0){
		menu_method[cursor]();
		audio_stop_sound(sng_id);
		instance_destroy();
	}
}