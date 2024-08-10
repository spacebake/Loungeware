var _input = keyboard_check;
var _input_pressed = keyboard_check_pressed;

hspd = _input(ord("D")) - _input(ord("A"));
vspd = _input(ord("S")) - _input(ord("W"));

if (hspd != 0 || vspd != 0) {
	arm_speed = lerp(arm_speed, 1.5, acceleration);
}
else {
	arm_speed = lerp(arm_speed, 0, acceleration);	
}

if (_input_pressed(ord("L")) && state == HAND_STATE.FREE && held_item == noone) {
	grab();	
}

if (_input_pressed(ord("K")) && state == HAND_STATE.GRAB && held_item != noone) {
	release();	
}

xx += hspd * arm_speed;
yy += vspd * arm_speed;

x = lerp(x, xx, 0.3);
y = lerp(y, yy, 0.3);