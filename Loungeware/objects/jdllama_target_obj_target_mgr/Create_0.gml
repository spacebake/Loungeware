randomize();

difficulty = {total: 4, targetSpeed: 1, canBackwards: false, shots: 6};

_alarm0 = function() {
	for(var i = 0;i<difficulty.total;i++) {
		with instance_create_layer(0, 0, "Targets", jdllama_target_obj_target) {
			timer = i * 45 + irandom_range(-15, 15);
			canBackwards = other.difficulty.canBackwards;
			targetSpeed = other.difficulty.targetSpeed;
		}
	}
}

alarm[0] = 1;