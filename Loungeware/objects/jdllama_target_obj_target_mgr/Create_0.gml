/// @description Insert description here
// You can write your code in this editor
randomize();

for(var i = 0;i<4;i++) {
	with instance_create_layer(0, 0, "Targets", jdllama_target_obj_target) {
		timer = i * 45 + irandom_range(-20, 20);
	}
}