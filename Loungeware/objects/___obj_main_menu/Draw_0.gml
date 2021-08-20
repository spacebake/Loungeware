//------------------------------------------------------------------------------------------
// STATE | *
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
			if (confirm_shake_time > 0) _str = "<shake, " + string(floor(confirm_shake_time/4)) + ">" + _str + "</shake>";
			confirm_shake_time = max(0, confirm_shake_time - 1);
			_scale_final = 2.5;
		} else {
			_str = "<wave, 2>" + _str + "</shake>";
			
		}
	}
	//draw strikethrough
	if (menu_method[i] == noop) draw_rectangle_fix(_text_x-(_str_w/2), _text_y_final + 10, _text_x + (_str_w/2), _text_y_final + 14); 
	// draw menu item
	___global.___draw_text_advanced(_text_x, _text_y_final, _v_sep, true, true, _str, 1, _scale_final, _h_sep);
}


//------------------------------------------------------------------------------------------
// STATE | FADEOUT
//------------------------------------------------------------------------------------------
if (state == "fadeout"){
	
	var _size = WINDOW_BASE_SIZE/2;
	if (!surface_exists(circle_surf)){
		circle_surf = surface_create(_size, _size);
	}

	surface_set_target(circle_surf);
	draw_clear(c_gbdark);
	gpu_set_blendmode(bm_subtract);
	draw_circle(_size/2, (_size/2), close_circle_prog * ( _size*0.8), 0);
	gpu_set_blendmode(bm_normal);

	surface_reset_target();
	draw_surface_stretched(circle_surf, 0, 0, VIEW_W, VIEW_H);

}



