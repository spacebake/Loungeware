var _scale = window_get_height() / WINDOW_BASE_SIZE;
var _os = (window_get_width() - window_get_height())/2;
display_set_gui_maximise(_scale, _scale, _os, 0);

	var _marg = 5;
	var _x1 = _marg;
	var _x2 = WINDOW_BASE_SIZE - _marg;
	var _y1 = (WINDOW_BASE_SIZE - 154) + _marg;
	var _y2 = WINDOW_BASE_SIZE - _marg;

if (!debug_hidden){

	// draw rect
	draw_set_color(c_black);
	draw_set_alpha(0.85)
	draw_rectangle_fix(_x1, _y1, _x2, _y2);

	// draw key hints
	draw_sprite(___spr_debug_key_info, 0, _x2, _y1);

	// draw text
	var _test_vars = ___global.test_vars;
	var _marg_h = 8;
	var _marg_v = 10;
	var _sep = 22;
	var _xx = _x1 + _marg_h;
	var _yy = _y1 + _marg_v;
	draw_set_color(c_white);
	draw_set_font(fnt_frogtype);
	draw_set_alpha(1);

	var _c_val = "<col, 228, 181, 129>";

	var _diff_str = "";
	if (shake_timer > 0){
		shake_timer--;
		_diff_str = "<shake, " + string((DIFFICULTY/5) * 2) + ">";
		
	}
	draw_set_color(c_gbyellow);
	___global.___draw_text_advanced(
		_xx, _yy, _sep, false, true,
		_diff_str + "DIFFICULTY_LEVEL: " + _c_val + string(DIFFICULTY)
	);
	

	draw_set_color(c_red);
	draw_set_alpha( (((DIFFICULTY-1)/4)*(1-(shake_timer/shake_timer_max))) * 0.8 );
	___global.___draw_text_advanced(
		_xx, _yy, _sep, false, true,
		_diff_str + "DIFFICULTY_LEVEL: " + string(DIFFICULTY)
	);
	draw_set_alpha(1);
	
	
	_yy += _sep;
	
	
	draw_set_color(c_gbyellow);
	___global.___draw_text_advanced(
		_xx, _yy, _sep, false, true,
		"PROMPT: " + _c_val +  "\"" + string_upper(string(PROMPT)) + "\""
	);
	_yy += _sep;


	___global.___draw_text_advanced(
		_xx, _yy, _sep, false, true,
		"WIN STATE: " + _c_val +  string_upper(___MG_MNGR.microgame_won ? "WIN" : "LOSE"));
	_yy += _sep;


	___global.___draw_text_advanced(
		_xx, _yy, _sep, false, true,
		"AUDIO:" + _c_val +  string_upper(muted ? "MUTED" : "ON"));
	_yy += _sep;
	
	___global.___draw_text_advanced(
	_xx, _yy, _sep, false, true,
	"TIMER MODE: " + _c_val +  string_upper(infinite_timer ? "INFINITE" : "NORMAL"));
	_yy += _sep;
	
	
} else {
	draw_sprite(___spr_debug_key_info, 1, WINDOW_BASE_SIZE - 30, 10);
}

draw_set_alpha(1);
with (___MG_MNGR){
	display_set_gui_maximise(gui_scale, gui_scale, gui_x, gui_y);
}