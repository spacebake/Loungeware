/// @description Draw Meter & Fill

// draw the paper meter background
draw_self();

// draw the progress bar
var _width = max_fill_width * meter_fill;
draw_sprite_part(noah_cheat_spr_meter_scribble, 0, 0, 0, _width, fill_bar_height, x, y);