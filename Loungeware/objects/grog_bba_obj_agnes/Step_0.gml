/// @description Insert description here
// You can write your code in this editor

if KEY_PRIMARY and in_control
{
	vspeed -= 1
	clamp(speed, 0, 2)
}

gravity = .2

var _buffer = 20
if y > room_height + _buffer or y < 0 - _buffer
{
	microgame_fail()
	microgame_end_early() 
}