/// @description Insert description here
// You can write your code in this editor

speed = -5
image_xscale = 0.5
image_yscale = 0.5
image_angle = wae_missle_flak.image_angle + 45 + 90 + 180
direction = image_angle 

wae_missle_mindist = 9999999999
wae_missle_prevmindist = 0
wae_missle_armed = false
wae_missle_closest_missle = -4
wae_missle_arming_dist = 20
wae_missle_explode = false
wae_missle_age = 0

var _p = part_type_create()
part_type_shape(_p, pt_shape_sphere);
part_type_size(_p, 0.06, 0.06, -0.001, 0);
part_type_scale(_p, 3, 1);
part_type_orientation(_p, 0, 0, 0, 0, 1);
part_type_color3(_p, c_yellow, c_white, c_white);
part_type_alpha3(_p, 0.3, 0.2, 0);
part_type_blend(_p, 1);
part_type_life(_p, 10, 10);
part_type_speed(_p, 0, 0, 0, 0);
part_type_direction(_p, 0, 360, 0, 0);
part_type_gravity(_p, 0, 0)
wae_missle_mytrail = _p

