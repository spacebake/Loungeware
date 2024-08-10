var _input = keyboard_check;

var _hspd = _input(ord("D")) - _input(ord("A"));
var _vspd = _input(ord("S")) - _input(ord("W"));

if (_hspd != 0 || _vspd != 0) {
	arm_speed = lerp(arm_speed, 1.5, acceleration);
}
else {
	arm_speed = lerp(arm_speed, 0, acceleration);	
}

xx += _hspd * arm_speed;
yy += _vspd * arm_speed;

x = lerp(x, xx, 0.3);
y = lerp(y, yy, 0.3);