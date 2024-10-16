/// @description Insert description here
// You can write your code in this editor



if on_broom
	draw_sprite_ext(broom, 0, x,y,1,1,image_angle,c_white,1)

draw_self()

draw_set_colour(c_magenta)
var _x = x+lengthdir_x(broom_end,image_angle)
var _y = y+lengthdir_y(broom_end,image_angle)

draw_point(_x, _y)