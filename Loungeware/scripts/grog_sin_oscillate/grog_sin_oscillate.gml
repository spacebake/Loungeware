// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//function grog_sin_oscillate(argument0, argument1, argument2) {
//	return((argument1-argument0)/2 * sin(argument2) + (argument1+argument0)/2);

//}

/// @func grog_sin_oscillate(min,max,duration,[position in microseconds])
function grog_sin_oscillate(_min, _max, _duration, _pos = get_timer()) {
  if(_duration == 0) _duration = math_get_epsilon();
  return((_max-_min)/2 * dsin(360 * 0.000001 * _pos /_duration) + (_max+_min)/2);
}