/// @description Insert description here
// You can write your code in this editor

if !in_control exit
in_control = false
layer_hspeed("bg_foreground", -1.5)

audio_sound_pitch(___MG_MNGR.microgame_music, .5)

sprite_index = grog_bba_spr_agnes_hit
speed = 0
gravity = 0
freeze = 30

sfx_play(grog_bba_sfx_crash)


var _x = x+lengthdir_x(broom_end,image_angle)
var _y = y+lengthdir_y(broom_end,image_angle)

if position_meeting(_x, _y, grog_bba_obj_projectile)
{
	on_broom = false
	instance_create_depth(x,y, other.depth+1,grog_bba_dummy_broom, { sprite_index: broom, image_angle: image_angle }) 
}



pixpope_lod_obj_camera.flash(3)
pixpope_lod_obj_camera.start(0, 20)


var _used_angles = [80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220]
_used_angles = array_shuffle(_used_angles)



var _star_count = irandom_range(5,7)


for (var i = 0; i < _star_count; i++){
	var _angle = _used_angles[i] + random_range(-10,10)
	part_type_direction(global.grog_bba_stars, _angle, _angle, 0, 0);
	part_type_orientation(global.grog_bba_stars, 0, 360, 5, 0, false);
	part_particles_create(ps, x,y,global.grog_bba_stars, 1)
}

with grog_bba_obj_projectile {
	hspeed = 0 
		
}

//var _spd = min(abs(vspeed), 5)
//spin_speed = _spd * -sign(vspeed)

spin_speed = -5 * sign(vspeed)
