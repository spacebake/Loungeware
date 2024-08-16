/// @description Movement
targetSpeed = 3.5;
accel = .75;
hspeed = 0;
vspeed = 0;
friction = .5;

move = function(){
  var _hori = KEY_RIGHT - KEY_LEFT;
  var _vert = KEY_DOWN - KEY_UP;
  
  if(_hori == 0 && _vert == 0) exit;
  
  var _dir = point_direction(0, 0, _hori, _vert);
  motion_add(_dir, accel);
  speed = clamp(speed, 0, targetSpeed);

  x = clamp(x, 0, room_width);
  y = clamp(y, 0, room_height);  
}


