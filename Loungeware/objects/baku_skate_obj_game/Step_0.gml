
// Grav
y_spd += grav;

// Grounded
if jump_y >= 0 {
	y_spd = 0;
	grounded = true;
	wobble_spd = lerp(wobble_spd, 1, 0.1);
	if !grounded_old {
		if !crashed sfx_play(baku_skate_snd_land, 1, false);
		else {
			audio_stop_all();
			sfx_play(baku_skate_snd_fart, 1, false);
		}
	}
	if !audio_is_playing(baku_skate_snd_skating) and !crashed {
		sfx_play(baku_skate_snd_skating, 1, true);
	}
	if spd > 0 {
		var _chance = crashed ? 30 : 10;
		if random(100) < _chance {
			var _len = random_range(-32, 24);
			var _x = mimpy_x + lengthdir_x(_len, world_angle);
			var _y = mimpy_y + lengthdir_y(_len, world_angle) + 8;
			_x += lengthdir_x(sin(wobble_time / (77 / DIFFICULTY)) * 8, 45) + lengthdir_x(cos(wobble_time / (99 / DIFFICULTY)) * 16, world_angle);
			_y += lengthdir_y(sin(wobble_time / (77 / DIFFICULTY)) * 8, 45) + lengthdir_y(cos(wobble_time / (99 / DIFFICULTY)) * 16, world_angle);
			var _inst = instance_create_layer(_x, _y, layer, baku_skate_obj_cloud);
			_inst.image_index = choose(5, 6, 7);
			_inst.spd = spd;
			_inst.dir = other.world_angle;
		}
		_chance = crashed ? 15 : 5;
		if random(100) < _chance {
			var _len = random_range(-32, 24);
			var _x = mimpy_x - 60;
			var _y = mimpy_y - 16;
			_x += lengthdir_x(sin(wobble_time / (77 / DIFFICULTY)) * 8, 45) + lengthdir_x(cos(wobble_time / (99 / DIFFICULTY)) * 16, world_angle);
			_y += lengthdir_y(sin(wobble_time / (77 / DIFFICULTY)) * 8, 45) + lengthdir_y(cos(wobble_time / (99 / DIFFICULTY)) * 16, world_angle);
			var _inst = instance_create_layer(_x, _y, layer, baku_skate_obj_cloud);
			_inst.image_index = choose(0, 1, 2, 3, 4, 5, 6);
			_inst.spd = spd;
			_inst.dir = other.world_angle;
		}
	}
} else {
	grounded = false;
	wobble_spd = lerp(wobble_spd, 0, 0.1);
}
grounded_old = grounded;

// Jump
if KEY_PRIMARY_PRESSED and grounded and !crashed {
	y_spd = -jump_spd;
	sprite_index = baku_skate_spr_mimpy_kickflip;
	image_index = 0;
	image_speed = 1;
	audio_stop_sound(baku_skate_snd_skating);
	sfx_play(baku_skate_snd_jump, 1, false);
}

// Move y
jump_y += y_spd;

// Clamp jump y
if jump_y >= 0 {
	jump_y = 0;
}

// Mimpy wobble
if !crashed {
	wobble_time += wobble_spd;
}

// Spawn bench
if TIME_REMAINING == bench_time {
	var _bench_x = mimpy_x + lengthdir_x(420, world_angle); // blaze it
	var _bench_y = mimpy_y + lengthdir_y(420, world_angle);
	instance_create_layer(_bench_x, _bench_y, layer, baku_skate_obj_bench);
	with baku_skate_obj_bench {
		spd = other.spd;
		dir = other.world_angle;
	}
}

// Crash into bench
if instance_exists(baku_skate_obj_bench) {
	if mimpy_x > baku_skate_obj_bench.bbox_left and mimpy_x < baku_skate_obj_bench.bbox_right {
		
		// Crash into the bench
		// if y_spd > -1 and jump_y > collide_y and !crashed {
		if jump_y > collide_y and !crashed {
			crashed = true;
			y_spd = -jump_spd;
			jump_y += y_spd;
			grounded = false;
			sprite_index = baku_skate_spr_mimpy_hit;
			shadow_sprite = baku_skate_spr_mimpy_hit_shadow;
			sfx_play(baku_skate_snd_hit, 1, false);
			sfx_play(choose(baku_skate_snd_scream1, baku_skate_snd_scream2, baku_skate_snd_scream3), 1, false);
			sfx_play(baku_skate_snd_error, 1, false);
			microgame_fail();
			alarm[1] = 60*2.5;
		}
	}
	
	if mimpy_x > baku_skate_obj_bench.bbox_right and !crashed and !passed_bench {
		passed_bench = true;
		sfx_play(baku_skate_snd_yeehaw, 1, false);
		sfx_play(baku_skate_snd_success, 1, false);
		alarm[1] = 60*2.5;
	}
}

// Crash dir
if crashed {
	crash_dir -= 18;
}

// Crash land
if crashed and grounded and !crash_landed {
	crash_landed = true;
	sprite_index = baku_skate_spr_mimpy_rip;
	shadow_sprite = baku_skate_spr_mimpy_rip_shadow;
}

// Crash landed
if crash_landed {
	spd = approach(spd, 0, 0.5);
}