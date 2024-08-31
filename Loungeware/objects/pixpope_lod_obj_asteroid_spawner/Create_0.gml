/// @description Insert description here
// You can write your code in this editor
timer = 0;
front = layer_get_id("AsteroidsFront");
back = layer_get_id("AsteroidsBack");

angle = random(360);
angle_range = 10;

spawnFront = function(_x = random(room_width), _y = random(room_height)){
	instance_create_layer(_x, _y, front, pixpope_lod_obj_asteroid, {
		hspeed: -random_range(2, 4),
		image_blend: merge_color(c_white, #07232c, .25),
		image_angle: angle + random_range(-angle_range, angle_range),
	});	
}

spawnBack = function(_x = random(room_width), _y = random(room_height)){
	var _scale = random_range(.5, .75)
	instance_create_layer(_x, _y, back, pixpope_lod_obj_asteroid, {
		hspeed: -random_range(1, 2),
		image_blend: merge_color(c_white, #07232c, .5),
		image_angle: angle + random_range(-angle_range, angle_range),
		image_xscale: _scale,
		image_yscale: _scale,
	});	
}

repeat(10){
	spawnFront();
}

repeat(20){
	spawnBack();
}






