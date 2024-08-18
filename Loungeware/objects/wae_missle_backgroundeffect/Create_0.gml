/// @description Insert description here
// You can write your code in this editor

image_xscale = 0.3
image_yscale = 0.3
image_angle = 180 - 45
image_alpha = 0.5
wae_missle_yspd = random(3)
y = room_height
x = random_range(room_width*0.2, room_width*0.4) - room_width/2
var _p = part_type_create()
part_type_shape(_p, pt_shape_sphere);
part_type_size(_p, 0.1, 0.1, -0.001, 0);
part_type_scale(_p, 3, 1);
part_type_orientation(_p, 0, 0, 0, 0, 1);
part_type_color3(_p, c_red, c_yellow, c_black);
part_type_alpha3(_p, 0.3, 0.6, 0);
part_type_blend(_p, 1);
part_type_life(_p, 10, 12);
part_type_speed(_p, 0, 0, 0, 0);
part_type_direction(_p, 0, 360, 0, 0);
part_type_gravity(_p, 0,0)
wae_missle_mytrail = _p

if random(1) > 0.5
{
	var _snd_id = sfx_play(wae_snd_missle_misslefire, random_range(0.15,0.2), 0);
	audio_sound_pitch(_snd_id, random_range(0.8,1.2));
}