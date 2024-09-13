/// @func pixpope_sin_oscillate(min,max,duration,[position in microseconds])
function pixpope_sin_oscillate(_min, _max, _duration, _pos = get_timer()) {
  if(_duration == 0) _duration = math_get_epsilon();
  return((_max-_min)/2 * dsin(360 * 0.000001 * _pos /_duration) + (_max+_min)/2);
}