/// @description Insert description here
// You can write your code in this editor

image_xscale = 0.5
image_yscale = 0.5
x = random_range(room_width/10, room_width*0.9)
y = -2*room_height*0.2
wae_missle_age = 0


var _p = part_type_create()
part_type_shape(_p, pt_shape_sphere);
part_type_size(_p, 0.1, 0.1, -0.001, 0);
part_type_scale(_p, 3, 1);
part_type_orientation(_p, 0, 0, 0, 0, 1);
part_type_color3(_p, c_red, c_yellow, c_black);
part_type_alpha3(_p, 0.3, 0.6, 0);
part_type_blend(_p, 1);
part_type_life(_p, 30, 30);
part_type_speed(_p, 0, 0, 0, 0);
part_type_direction(_p, 0, 360, 0, 0);
part_type_gravity(_p, 0,0)
wae_missle_mytrail = _p