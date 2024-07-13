/// @description Insert description here
// You can write your code in this editor
var _dx = x + 0.2*random_range(-1,1)*(wae_hog_speed + wae_hog_angspeed)
var _dy = y + 0.2*random_range(-1,1)*(wae_hog_speed + wae_hog_angspeed)
draw_sprite_ext(sprite_index,image_index,_dx,_dy,1,1,image_angle,c_white,1)