/// @description Insert description here
// You can write your code in this editor

if KEY_PRIMARY and in_control
{
	vspeed -= 1

	speed = clamp(speed, 0, 4)
}

//if vspeed < 0
//		image_angle = 10
//else image_angle = 0


image_angle = lerp(0, -55, vspeed / 7)

gravity = .2

var _buffer = 20
if y > room_height + _buffer or y < 0 - _buffer
{
	//microgame_fail()
	//microgame_end_early() 
}