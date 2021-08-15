center_x = 120;
center_y = 80;

amplitude_x = 104;
amplitude_y = 50;
frequency = 1.8;
timer = 0;

/*
canBackwards = other.difficulty.canBackwards;
			targetSpeed = other.difficulty.targetSpeed;
*/
canBackwards = false;
targetSpeed = 1;

_alarm0 = function() {
	if(canBackwards == true) {
		targetSpeed *= choose(1, -1);
	}
}



_step = function() {
	x = amplitude_x * dcos(timer * frequency) + center_x;
	y = amplitude_y * dsin(timer * frequency * 2) + center_y;
	timer += targetSpeed;
}

_destroy = function() {
	with instance_create_layer(0, 0, "Targets", jdllama_target_obj_target_asplode) {
		x = other.x;
		y = other.y;
	}
}

alarm[0] = 1;