/// @description Insert description here
// You can write your code in this editor

tick++

var _ascend = (KEY_PRIMARY or KEY_SECONDARY or KEY_UP)

var _ascend_press = (KEY_PRIMARY_PRESSED or KEY_SECONDARY_PRESSED or KEY_UP_PRESSED)


if freeze  != 0{
	
	freeze--
	if freeze = 0 {
		direction = random_range(100, 115)
		speed = 10
		
		sfx_play(grog_bba_sfx_launch)
		
		hspeed *= choose(1,-1)
		spin_speed = 10
		
		microgame_fail()
		if alarm[0] = -1
			alarm[0] = 120
		
		
	}
	
	exit
}


var _rate = 7 - (4 * _ascend)
if tick mod _rate = 0 and on_broom {
	
	var _x = x+lengthdir_x(35,image_angle+180)
	var _y = y+lengthdir_y(35,image_angle+180)
	
	var _sprite = choose(grog_bba_spr_sparkle1,grog_bba_spr_sparkle2, grog_bba_spr_sparkle3,grog_bba_spr_sparkle4, grog_bba_spr_sparkle5)
	instance_create_depth(_x,_y,depth+1,grog_bba_fx, { 
		sprite_index: _sprite, 
		hspeed: random_range(-1,-2) - (3*_ascend),
		image_angle: choose(0, 90, 180, 270)
		
		
		})
	
}



if flyin {

var _curve = animcurve_get_channel(pixpope_lod_ac_approach, "back")

	x = lerp(start_x, xstart, animcurve_channel_evaluate(_curve, tick/flyin_length))
	y = lerp(start_y, ystart, animcurve_channel_evaluate(_curve, tick/flyin_length))
	image_angle = lerp(-45, 0, animcurve_channel_evaluate(_curve, tick/flyin_length))
	
	if tick >= flyin_length 
	{
		flyin = false
		
	}
	else exit
}

if _ascend_press and in_control {
	
	//if !audio_is_playing(grog_bba_sfx_ascend)
	//{
	
		sfx_stop(sfx_id)
		show_debug_message("start")
		sfx_id = sfx_play(grog_bba_sfx_ascend,1,true)
	//}
	microgame_sfx_set_gain(sfx_id, 1, 0)
}


if _ascend and in_control
{
	

	vspeed -= 1

	speed = clamp(speed, 0, 4)
}
else {
	if audio_is_playing(sfx_id)
	{
		microgame_sfx_set_gain(sfx_id, 0, 300)
		if audio_sound_get_gain(sfx_id) = 0
		{
			sfx_stop(sfx_id)
		}
	}
}

//if vspeed < 0
//		image_angle = 10
//else image_angle = 0

if in_control
	image_angle = lerp(0, -55, vspeed / 7)
else {
	

	part_particles_create(ps,x,y,global.grog_bba_smoke,1)
	image_angle += spin_speed
	
	
	//bgm_pitch = lerp(bgm_pitch, .5, .35)
	//audio_sound_pitch(___MG_MNGR.microgame_music, bgm_pitch)
}

gravity = .2

var _buffer = 20
if y > room_height + _buffer or y < 0 - _buffer
{
	
	microgame_fail()
	if alarm[0] = -1
	{

		alarm[0] = 120
		
	}
}



