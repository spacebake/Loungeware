

var _str = str;
var _scale = 2;

var _margin = 16 * _scale;
var _xx = (VIEW_W/2) + shake_x;
var _yy = 100 + shake_y + yy_mod;
var _line_h = 18 * _scale;

// draw spotlight
var _sl_scale = 1 + (lengthdir_y(1, spotlight_dir)/50);
draw_sprite_ext(___spr_spotlight, 0, _xx, _yy - 100, _sl_scale, 1, 0, c_white, 1);

//draw larold
var _y_mod = lengthdir_y(1, headdir);
draw_sprite_ext(___spr_larold_talk, larold_frame, _xx, _yy + _y_mod + larold_y_mod, 2 - _sl_scale, 2 - _sl_scale, 0, c_white, 1);
_yy += sprite_get_height(___spr_larold_talk);
_yy += _margin;

// draw dialogue
draw_set_color(c_gbwhite);
draw_set_font(fnt_frogtype);

___global.___draw_text_advanced(120, _yy+4, _line_h, true, string_complete, _str, 1, _scale);
_yy += (_line_h*2) + (_margin);

// draw dotted line
draw_set_color(col_bar);
var _bar_alpha = 1-(menu_item_x_offset / menu_item_x_offset_max);
draw_set_alpha(_bar_alpha);
draw_dotted_line(0, _yy-5, VIEW_W, _yy-5, 4, 8);
draw_set_alpha(1);

_yy += _margin;
_yy -= 5;
// draw options
var _v_sep = 16;
var _h_sep = 1;
draw_set_halign(fa_center);

for (var i = 0; i < array_length(menu); i++){
	_selected = (cursor == i);
	_scale_final = _scale;
	draw_set_color(col_bar);
	_str = menu[i][0];
	
	var _xos_sign = -1;
	if (i mod 2 == 0) _xos_sign = 1;
	var _xos = menu_item_x_offset * _xos_sign;
	
	_text_y_final =  _yy   + (_v_sep * i);
	if (_selected){
		
		draw_set_color(c_gbyellow);
			
		if (confirmed){
			draw_set_color(c_gbpink);
			if (confirm_shake_time > 0) _str = "<shake, " + string(confirm_shake_time) + ">" + _str + "</shake>";
			confirm_shake_time = max(0, confirm_shake_time - 1);
			_scale_final = 2.5;
		} else {
			_str = "<wave, 1>" + _str + "</shake>";
			
		}
	}
	// draw option text
	___global.___draw_text_advanced(_xx + _xos, _yy, _v_sep, true, true, _str, 1, _scale/2, _h_sep);
	_yy += 30;

}

// draw dotted line
_yy += _margin/2;
draw_set_color(col_bar);
var _bar_alpha = 1-(menu_item_x_offset / menu_item_x_offset_max);
draw_set_alpha(_bar_alpha);
draw_dotted_line(0, _yy-2, VIEW_W, _yy-2, 4, 8);
draw_set_alpha(1);




// draw gamelist
if (yy_mod < 0){
	_yy = (VIEW_H + yy_mod) + 40;
	draw_set_halign(fa_center);
	
	var _str = "SELECT THE GAME YOU WANT TO WORK ON";
	draw_set_color(c_larold);
	___global.___draw_text_advanced(_xx + _xos, _yy, 16, true, true, _str, 1, 1, 1);
	_yy += 20;
	draw_set_color(col_bar);
	draw_dotted_line(_margin, _yy, VIEW_W - _margin, _yy, 4, 4);
	
	_yy += 40;
	
	var _v_sep = 30;
	var _h_sep = 1;
	
	
	for (var i = 0; i < array_length(game_keylist); i++){
		_selected = (cursor == i);
		_scale_final = _scale;
		draw_set_color(c_larold);
		var _key = game_keylist[i];
		var _data = variable_struct_get(___global.microgame_metadata, _key);
		var _str = string_upper(_data.game_name);
		
	
		var _xos_sign = -1;
		if (i mod 2 == 0) _xos_sign = 1;
		var _xos = menu_item_x_offset * _xos_sign;
	
		_text_y_final =  _yy   + (_v_sep * i);
		if (_selected){
		
			draw_set_color(c_gbyellow);
			
			if (confirmed){
				draw_set_color(c_gbpink);
				if (confirm_shake_time > 0) _str = "<shake, " + string(confirm_shake_time) + ">" + _str + "</shake>";
				confirm_shake_time = max(0, confirm_shake_time - 1);
				_scale_final = 2.5;
			} else {
				_str = "<wave, 1>" + _str + "</shake>";
			
			}
		}
		// draw option text
		___global.___draw_text_advanced(_xx + _xos, _yy, _v_sep, true, true, _str, 1, _scale/2, _h_sep);
		
		draw_set_color(col_bar);
		var _line_y = (_yy + _v_sep/2) + 5;
		draw_rectangle_fix(_margin, _line_y, VIEW_W - _margin, _line_y + 2);
		_yy += _v_sep;

	}
}









// draw lighting
draw_set_color(c_black);
draw_set_alpha(1-light_val);
draw_rectangle_fix(0, 0, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
draw_set_alpha(1);

// draw block
draw_set_color(c_gbblack);
draw_set_alpha(fadeout_alpha);
draw_rectangle_fix(0, 0, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);

draw_set_halign(fa_left);
draw_set_alpha(1);
