
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
mimpy_x = 100;
mimpy_y = 140;
wobble_time = 0;
wobble_spd = 0;

// Mimpy sprite
sprite_index = baku_skate_spr_mimpy_skate1;
image_speed = 1;
shadow_sprite = baku_skate_spr_mimpy_shadow1;

// Jumping (well, kickflipping...)
grounded = true;
grounded_old = true;
jump_y = 0;
y_spd = 0;
// grav = 0.20 + (DIFFICULTY * 0.01);
// jump_spd = 7.89 - ((5 - DIFFICULTY) * 0.162);
grav = 0.23 + (DIFFICULTY * 0.01);
jump_spd = 7 - ((5 - DIFFICULTY) * 0.162);
// don't question the black magic behind these numbers

// Map function
map = function(value, old_min, old_max, new_min, new_max) {
	// Note: output value is not clamped to the ranges, keep that in mind!
	return lerp(new_min, new_max, (value - old_min) / (old_max - old_min));
}

// Warning alarm
alarm_count = 2;
alarm_duration = 60;
alarm[0] = alarm_duration;

// Bench time
bench_time_min = 300;
bench_time_max = 550;
bench_time = irandom_range(bench_time_min, bench_time_max);
passed_bench = false;

// Crashing
crashed = false;
collide_y = -45;
crash_dir = 0;
crash_landed = false;

// Skating sound
sfx_play(baku_skate_snd_skating, 1, true);

// Approach
approach = function(_val1, _val2, _inc) {
	if (_inc < 0) throw("approach: amount is negative");
	return (_val1 + clamp(_val2 - _val1, -_inc, _inc));
}

// Dust cloud surface
cloud_surf = -1;
cloud_surf_create = function() {
	cloud_surf = surface_create(480, 320);
}