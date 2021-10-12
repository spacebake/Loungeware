
// Movement stuff
speeds = [7, 9, 11, 13, 15];
spd = speeds[DIFFICULTY - 1];

// Angle of world
world_angle_x = 1024;
world_angle_y = 128;
world_angle = point_direction(0, 0, world_angle_x, world_angle_y);

// Ground
instance_create_layer(0, 0, layer, baku_skate_obj_ground);
instance_create_layer(1024, 128, layer, baku_skate_obj_ground);
with baku_skate_obj_ground {
	spd = other.spd;
	dir = other.world_angle;
}

// Trees BG
instance_create_layer(0, 0, layer, baku_skate_obj_trees_bg);
instance_create_layer(1024, 128, layer, baku_skate_obj_trees_bg);
with baku_skate_obj_trees_bg {
	spd = other.spd * 0.5;
	dir = other.world_angle;
}

// Trees FG
instance_create_layer(0, 0, layer, baku_skate_obj_trees_fg);
instance_create_layer(1024, 128, layer, baku_skate_obj_trees_fg);
with baku_skate_obj_trees_fg {
	spd = other.spd * 2;
	dir = other.world_angle;
}

// Mimpy coords
mimpy_x_display = 100;
mimpy_y_display = 140;
wobble_time = 0;
wobble_spd = 0;

// Mimpy sprite
sprite_index = baku_skate_spr_mimpy_skate1;
image_speed = 1;

// Jumping
grounded = true;
jump_y = 0;
y_spd = 0;
grav = 0.25;
jump_spd = 8;

// Map function
map = function(value, old_min, old_max, new_min, new_max) {
	// Note: output value is not clamped to the ranges, keep that in mind!
	return lerp(new_min, new_max, (value - old_min) / (old_max - old_min));
}