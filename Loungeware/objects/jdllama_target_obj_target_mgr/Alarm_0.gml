
for(var i = 0;i<difficulty.total;i++) {
	with instance_create_layer(0, 0, "Targets", jdllama_target_obj_target) {
		timer = i * 45 + irandom_range(-15, 15);
	}
}