

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
	draw_set_color(col_purp);
	_str = menu[i][0];
	
	var _xos_sign = -1;
	if (i mod 2 == 0) _xos_sign = 1;
	var _xos = menu_item_x_offset * _xos_sign;
	
	_text_y_final =  _yy   + (_v_sep * i);
	if (_selected){
		
		draw_set_color(c_gbyellow);
			
		if (confirmed){
			draw_set_color(c_gbpink);
			if (confirm_shake_time > 0) _str = "<shake, " + string(floor(confirm_shake_time/4)) + ">" + _str + "</shake>";
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
	
	_yy = (VIEW_H + yy_mod);
	draw_set_halign(fa_center);
	
	var _topbar_h = 90;
	var _rect_margin = 55;
	_yy += 20;
	
	var _box_x1 = _rect_margin;
	var _box_x2 = VIEW_W - _rect_margin;
	var _box_y1 = _yy;
	var _box_y2 = _yy + _topbar_h;
	var _box_text_y_offset = 17;
	_yy += _box_text_y_offset + _topbar_h + 12;
	
	var _v_sep = 30;
	var _h_sep = 1;
	var _list_total_h = 0;
	var _gamelist_y = _yy + scroll_y;
	
	for (var i = 0; i < array_length(game_keylist); i++){
		var _store_y = _gamelist_y;
		_selected = (cursor2 == i);
		_scale_final = _scale;
		draw_set_color(c_larold);
		var _key = game_keylist[i];
		var _data = variable_struct_get(___global.microgame_metadata, _key);
		var _str = string_upper(_data.game_name);
		
	
		var _xos_sign = -1;
		if (i mod 2 == 0) _xos_sign = 1;
		var _xos = menu_item_x_offset * _xos_sign;
	
		_text_y_final =  _gamelist_y   + (_v_sep * i);
		if (_selected){
			
			draw_set_color(col_bar);
			var _bar_offset = -8;
			draw_rectangle_fix(_box_x1, _gamelist_y + _bar_offset, _box_x2, _gamelist_y + _v_sep + _bar_offset);
		
			draw_set_color(c_gbyellow);
			scroll_y_target = ((VIEW_H/2)) - (_list_total_h*1.5);
			
			if (confirmed){
				draw_set_color(c_gbpink);
				if (confirm_shake_time > 0) _str = "<shake, " + string(floor(confirm_shake_time/4)) + ">" + _str + "</shake>";
				confirm_shake_time = max(0, confirm_shake_time - 1);
				_scale_final = 2.5;
			} else {
				_str = "<wave, 1>" + _str + "</shake>";
			
			}
		}
		// draw option text
		if (_gamelist_y > _box_y2 - _v_sep && _gamelist_y < VIEW_H){
			___global.___draw_text_advanced(_xx + _xos, _gamelist_y, _v_sep, true, true, _str, 1, _scale/2, _h_sep);
			draw_set_color(col_bar);
			var _line_y = (_gamelist_y + _v_sep/2) + 5;
			draw_rectangle_fix(_rect_margin, _line_y, VIEW_W - _rect_margin, _line_y + 2);
			if (i == 0)  draw_rectangle_fix(_rect_margin, _line_y - _v_sep, VIEW_W - _rect_margin, (_line_y + 2) - _v_sep);
		}
	
		_gamelist_y += _v_sep;
		_list_total_h += (_gamelist_y - _store_y);
	}
	
	// limit scroll
	scroll_y_target = clamp(scroll_y_target, (-_list_total_h + (VIEW_H-160)), 0);
	
	// draw the top box
	draw_set_alpha(abs(yy_mod)/VIEW_H);
	draw_set_halign(fa_center);
	draw_set_color(c_gbdark);
	draw_rectangle_fix(_box_x1,_box_y1, _box_x2, _box_y2);
	var _str = "SELECT THE GAME YOU WANT TO WORK ON<col, 57, 46, 64>\n CHECK THE WIKI OR ASK IN DISCORD IF\nYOU DON'T SEE YOUR GAME IN THE LIST";
	draw_set_color(c_larold);
	___global.___draw_text_advanced(_xx, _box_y1 + _box_text_y_offset, 22, true, true, _str, 1, 1, 1);
	draw_set_alpha(1);
}










// draw lighting
draw_set_color(c_black);
draw_set_alpha((1-light_val)*0.92);
draw_rectangle_fix(0, 0, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
draw_set_alpha(1);

// draw block
draw_set_color(c_gbblack);
draw_set_alpha(fadeout_alpha);
draw_rectangle_fix(0, 0, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);

draw_set_halign(fa_left);
draw_set_alpha(1);


if (state == "gamelist" && fadeout_alpha > 0){
	draw_set_color(c_larold);
	draw_set_halign(fa_center)
	draw_set_alpha(fadeout_alpha);
	var _data = variable_struct_get(___global.microgame_metadata, game_keylist[cursor2]);
	var _yy = 20;
	var _cart_float_y = lengthdir_y(2, cart_float_dir);
	draw_sprite(cart_sprite, 0, (VIEW_W/2) - (sprite_get_width(cart_sprite)/2), (_yy+36) + _cart_float_y);
	_yy += sprite_get_height(cart_sprite);
	var _str = "";
	_str += "<col,40,33,51>--------------------------------------------</col>\n";
	_str += "<col, 241, 154, 82>\"" + string_upper(_data.game_name) + "\"</col>";
	_str += "\n<col,40,33,51>--------------------------------------------</col>\n";
	_str += "FROM NOW ON THE GAME WILL AUTOMATICALLY BOOT\nINTO THIS MICROGAME FOR QUICK TESTING.";
	_str += "\n\nYOU CAN RETURN TO THIS MENU AT ANY TIME BY\nPRESSING THE <col, 241, 154, 82>\"P\"</col> KEY";
	_str += "\n<col,40,33,51>--------------------------------------------</col>\n\n";
	_str += "\n<col, 241, 154, 82>[Z]CANCEL                  [X]CONFIRM";
	___global.___draw_text_advanced(VIEW_W/2, _yy, 20, true, true, _str, 1, 1, 1);
	draw_set_alpha(1);
}