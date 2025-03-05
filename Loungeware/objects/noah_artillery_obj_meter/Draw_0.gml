/// @description Insert description here
// You can write your code in this editor

// draw meter background
draw_self();

// draw meter fill
draw_sprite_stretched(noah_artillery_spr_meter_fill, 0, fill_x, fill_y, fill_amount * fill_max_width, fill_height);

// draw meter frame
draw_sprite(noah_artillery_spr_meter, show_full_charge, x, y);

