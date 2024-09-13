/// @description Insert description here
// You can write your code in this editor

if !in_control exit
in_control = false

//var _spd = min(abs(vspeed), 5)
//spin_speed = _spd * -sign(vspeed)

spin_speed = -5 * sign(vspeed)
