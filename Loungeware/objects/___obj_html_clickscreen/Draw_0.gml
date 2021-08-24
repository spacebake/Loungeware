var _scale = 2;
var _margin = 16 * _scale;
var _xx = (VIEW_W/2);
var _yy = 100 + shake_y + yy_mod;

draw_clear(c_gbdark);

// draw spotlight
var _sl_scale = 1 + (lengthdir_y(1, spotlight_dir)/50);
draw_sprite_ext(___spr_spotlight, 0, _xx, _yy - 100, _sl_scale, 1, 0, c_white, 1);

//draw larold
var _y_mod = lengthdir_y(1, headdir);
draw_sprite_ext(___spr_larold_talk, larold_frame, _xx, _yy + _y_mod + larold_y_mod, 2 - _sl_scale, 2 - _sl_scale, 0, c_white, 1);
_yy += sprite_get_height(___spr_larold_talk);
_yy += 110;

// draw play button
var _button_scale = (_sl_scale + (0.05 * button_hover));
var _bw = sprite_get_width(___spr_clickscreen_button)  * _button_scale;
var _bh = sprite_get_height(___spr_clickscreen_button)  * _button_scale;
button_x1 = _xx - (_bw/2);
button_x2 = _xx + (_bw/2);
button_y1 = _yy;;
button_y2 = _yy + _bh;
draw_sprite_ext(___spr_clickscreen_button, 0, _xx, _yy + _y_mod, _button_scale,  _button_scale, 0, c_white, 1 * button_zoomscale);
draw_sprite_ext(___spr_clickscreen_button, 1, _xx, _yy + _y_mod, _button_scale,  _button_scale, 0, c_white, button_hover  * button_zoomscale);


// draw lighting
draw_set_color(c_gbdark);
draw_set_alpha((1-light_val));
draw_rectangle_fix(0, 0, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
draw_set_alpha(1);

// draw block
draw_set_color(c_gbdark);
draw_set_alpha(fadeout_alpha);
draw_rectangle_fix(0, 0, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);

draw_set_halign(fa_left);
draw_set_alpha(1);


