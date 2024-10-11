/// @description Insert description here
// You can write your code in this editor

tick++


if freeze  != 0{
	
	freeze--
	if freeze = 0 {
		direction = random_range(100, 115)
		speed = 10
		
		hspeed *= choose(1,-1)
		spin_speed = 10
		
		microgame_fail()
		if alarm[0] = -1
			alarm[0] = 120
		
		
	}
	
	exit
}


if tick mod 5 = 0 and on_broom {
	
	var _x = x+lengthdir_x(35,image_angle+180)
	var _y = y+lengthdir_y(35,image_angle+180)
	
	var _sprite = choose(grog_bba_spr_sparkle1,grog_bba_spr_sparkle2, grog_bba_spr_sparkle3,grog_bba_spr_sparkle4, grog_bba_spr_sparkle5)
	instance_create_depth(_x,_y,depth+1,grog_bba_fx, { sprite_index: _sprite, hspeed: random_range(-1,-3) })
	
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


if KEY_PRIMARY and in_control
{
	vspeed -= 1

	speed = clamp(speed, 0, 4)
}

//if vspeed < 0
//		image_angle = 10
//else image_angle = 0

if in_control
	image_angle = lerp(0, -55, vspeed / 7)
else {
	

	part_particles_create(ps,x,y,global.grog_bba_smoke,1)
	image_angle += spin_speed
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



