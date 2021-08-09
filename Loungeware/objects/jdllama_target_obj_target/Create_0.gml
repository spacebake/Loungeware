center_x = 120;
center_y = 80;

amplitude_x = 104;
amplitude_y = 50;
frequency = 2;
timer = 0;

_step = function() {
	x = amplitude_x * dcos(timer * frequency) + center_x;
	y = amplitude_y * dsin(timer * frequency * 2) + center_y;
	timer++;
}