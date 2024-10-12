/// @description Insert description here
// You can write your code in this editor
if(flashTimer <= 0) return;

var _w = display_get_gui_width(),
		_h = display_get_gui_height();

draw_set_alpha((flashTimer/flashLength) * .5);
draw_set_color(flashColor);
draw_rectangle(0, 0, _w, _h, false);
draw_set_alpha(1);

flashTimer--;



