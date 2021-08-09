/// @description Insert description here
// You can write your code in this editor
randomize();

difficulties = [
	{total: 3, angle: 45, canBackwards: false, },
	{},
	{},
	{},
	{},
];

for(var i = 0;i<4;i++) {
	with instance_create_layer(0, 0, "Targets", jdllama_target_obj_target) {
		timer = i * 45 + irandom_range(-15, 15);
	}
}