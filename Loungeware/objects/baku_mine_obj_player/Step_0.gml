
// Prompt setup
if !prompt_setup_done and PROMPT != "" {
	
	// Get amount of ores
	var _ore_count = instance_number(baku_mine_obj_block_ore);
	
	// Figure out what the target and distractor ore types are
	var _target_ore = prompt_to_ore_translator[$ PROMPT];
	var _distraction_ores = [];
	for (var i = 0; i < baku_mine_ore_type.__size; ++i) {
		if i != _target_ore array_push(_distraction_ores, i);
	}
	
	// List of ore blocks
	var _ore_list = ds_list_create();
	
	// Add target ores to list
	repeat (ceil((6 - DIFFICULTY) / 2)) {
		ds_list_add(_ore_list, _target_ore);
	}
	
	// Add distraction ores
	while (ds_list_size(_ore_list) < _ore_count) {
		var _id = irandom(array_length(_distraction_ores) - 1);
		ds_list_add(_ore_list, _distraction_ores[_id]);
	}
	
	// Shuffle ore list
	ds_list_shuffle(_ore_list);
	
	// Loop through ore blocks and assign type
	for (var i = 0; i < _ore_count; ++i) {
		var _inst = instance_find(baku_mine_obj_block_ore, i);
		if _inst != noone {
			_inst.ore_type = _ore_list[| i];
			_inst.set_ore_type();
		}
	}
	
	// Done
	ds_list_destroy(_ore_list);
	prompt_setup_done = true;
}

// Game loop
if prompt_setup_done and !win and !lose and !creeper_spawned {
	
	#region Player movement and such
		
		// Aim
		aim_dir -= (KEY_RIGHT - KEY_LEFT) * aim_spd;
		aim_pitch += (keyboard_check(ord("F")) - keyboard_check(ord("V"))) * aim_spd; // Debug pitch
		
		// Movement speed
		var _fb_keys = (KEY_UP - KEY_DOWN) * max_spd;
		var _rl_keys = 0;
		fb_vel += _fb_keys * acc;
		rl_vel += _rl_keys * acc;
		fb_vel = clamp(fb_vel, -max_spd, max_spd);
		rl_vel = clamp(rl_vel, -max_spd, max_spd);
		
		// Make diagonal speeds not go faster
		if _fb_keys != 0 and _rl_keys != 0 {
			fb_vel /= sqrt(2);
			rl_vel /= sqrt(2);
		}
		
		// Decelerate
		if (_fb_keys == 0) fb_vel = approach(fb_vel, 0, fric);
		if (_rl_keys == 0) rl_vel = approach(rl_vel, 0, fric);
		
		// Head bob
		if _fb_keys != 0 head_bob += 10;
		head_bob_lerped = lerp(head_bob_lerped, head_bob, 0.1);
		
		// X and Y speeds
		x_spd = lengthdir_x(fb_vel, aim_dir) + lengthdir_x(rl_vel, aim_dir - 90);
		y_spd = lengthdir_y(fb_vel, aim_dir) + lengthdir_y(rl_vel, aim_dir - 90);
		
		// Jump
		if KEY_SECONDARY_PRESSED and grounded {
			z_spd = jump_spd;
		}
		
		// Gravity
		if (!place_meeting_3d(x, y, z + z_spd + grav, baku_mine_par_solid)) {
			z_spd -= grav;
		}
		z_spd = clamp(z_spd, -fall_spd, jump_spd);
		
		// X collision
		if (!place_meeting_3d(x + x_spd, y, z, baku_mine_par_solid)) {
			x += x_spd;
		} else {
			while (!place_meeting_3d(x + sign(x_spd), y, z, baku_mine_par_solid)) {
				x += sign(x_spd);
			}
			x_spd = 0;
		}
		
		// Y collision
		if (!place_meeting_3d(x, y + y_spd, z, baku_mine_par_solid)) {
			y += y_spd;
		} else {
			while (!place_meeting_3d(x, y + sign(y_spd), z, baku_mine_par_solid)) {
				y += sign(y_spd);
			}
			y_spd = 0;
		}
		
		// Z collision
		if (!place_meeting_3d(x, y, z + z_spd, baku_mine_par_solid)) {
			z += z_spd;
		} else {
			while (!place_meeting_3d(x, y, z + sign(z_spd), baku_mine_par_solid)) {
				z += sign(z_spd);
			}
			z_spd = 0;
		}
		
		// Don't fall through floor
		if z < min_z {
			z = min_z;
		}
		
		// Grounded
		if z <= min_z
		or place_meeting_3d(x, y, z - 1, baku_mine_par_solid) {
			grounded = true;
		} else {
			grounded = false;
		}
		
		// If stuck in a solid, move up until not stuck
		while (place_meeting_3d(x, y, z, baku_mine_par_solid)) {
			z ++;
		}
		
	#endregion
	
	#region Mining
		
		// Using pickaxe
		if KEY_PRIMARY {
			pick_time ++;
			
			if pick_time mod pick_time_mod == 0 {
				pick_rot += 360;
				
				if block_aim_id != noone {
					if block_aim_id.object_index == baku_mine_obj_block_ore {
						crack_img ++;
						
						// Block breaking particles
						with block_aim_id {
							repeat 2 {
								var _radius = 0;
								var _dir = point_direction(x, y, other.x, other.y);
								var _x = x + random_range(-_radius, _radius) + lengthdir_x(8, _dir);
								var _y = y + random_range(-_radius, _radius) + lengthdir_y(8, _dir);
								var _z = z + random_range(-_radius, _radius);
								var _inst = instance_create_layer(_x, _y, layer, baku_mine_obj_block_particle);
								_inst.z = _z;
							}
						}
					}
					
					// Sound
					sfx_play(choose(baku_mine_snd_hit_a, baku_mine_snd_hit_b, baku_mine_snd_hit_c, baku_mine_snd_hit_d, baku_mine_snd_hit_e), 1, false);
				}
			}
		}
		if KEY_PRIMARY_RELEASED {
			pick_time = pick_time_mod - 1;
			crack_img = 0;
		}
		pick_rot_lerped = lerp(pick_rot_lerped, pick_rot, 0.1);
		
		// Get block aiming at
		block_aim_id = noone;
		for (var i = 0; i < block_aim_max_dis; ++i) {
			var _x2 = x + lengthdir_x(i, aim_dir);
			var _y2 = y + lengthdir_y(i, aim_dir);
			block_aim_id = collision_line_list_3d_first(x, y, z + eye_height, _x2, _y2, baku_mine_par_solid);
			if block_aim_id != noone break;
		}
		
		// Mine the block
		if block_aim_id != noone {
			if block_aim_id.is_ore == true {
				if KEY_PRIMARY and crack_img > 5 {
					
					var _win = false;
					
					// Do block stuffs
					with block_aim_id {
						// Create drop
						var _inst = instance_create_layer(x, y, layer, baku_mine_obj_drop);
						_inst.z = z;
						_inst.glow_col = glow_col;
						_inst.glow_alpha = glow_alpha;
						_inst.z_og = z;
						_inst.texture_name = texture_name_drop;
						
						// Did we win?
						if ore_type == other.prompt_to_ore_translator[$ PROMPT] {
							_win = true;
						}
						
						// Sound
						sfx_play(baku_mine_snd_break, 1, false);
						if _win sfx_play(baku_mine_snd_drop, 1, false);
						
						// Block breaking particles
						repeat 16 {
							var _radius = 8;
							var _x = x + random_range(-_radius, _radius);
							var _y = y + random_range(-_radius, _radius);
							var _z = z + random_range(-_radius, _radius);
							var _inst = instance_create_layer(_x, _y, layer, baku_mine_obj_block_particle);
							_inst.z = _z;
						}
						
						// Destroy block
						instance_destroy();
					}
					
					// Did we win?
					if _win {
						win = true;
						microgame_win();
						sfx_play(baku_mine_snd_cheer, 1, false);
					}
					
					// No we did not :(
					else {
						lose = true;
						microgame_fail();
						microgame_music_stop(0);
						sfx_play(baku_mine_snd_creeper, 1, false);
						creeper_spawned = true;
						creeper_aim_dir = aim_dir + 180;
					}
				}
			}
			
			if block_aim_id.object_index != baku_mine_obj_block_ore {
				crack_img = 0;
			}
		}
		
	#endregion
}

// Think bubble and creeper stuff
if !win {

	// Spawn think bubble
	// if (TIME_REMAINING_SECONDS <= 9) and (DIFFICULTY <= 2) and !think_spawned and !creeper_spawned and !lose {
	// 	think_spawned = true;
	// 	sfx_play(baku_mine_snd_think, 1, false);
	// }
	
	// Spawn creeper
	var _creeper_time = 4 + max(DIFFICULTY - 4, 0);
	if (TIME_REMAINING_SECONDS <= _creeper_time) and !creeper_spawned {
		creeper_spawned = true;
		microgame_music_stop(0);
		sfx_play(baku_mine_snd_creeper, 1, false);
		creeper_aim_dir = aim_dir + 180;
	}
	
	// Handle creeper stuff
	if creeper_spawned {
		aim_dir = lerp(aim_dir, creeper_aim_dir, creeper_aim_lerp);
		creeper_flash += creeper_flash_spd;
		if abs(creeper_aim_dir - aim_dir) < 1 and !roundabout_started {
			roundabout_started = true;
			microgame_music_start(baku_mine_bgm_roundabout, true, 1);
		}
		timer_skip_time ++;
	}
}

// Confetti
if win {
	win_confetti_time ++;
	if win_confetti_time mod win_confetti_timer == 0 {
		instance_create_layer(random(480), 0, layer, baku_mine_obj_confetti);
	}
	timer_skip_time ++;
	pick_rot_lerped = lerp(pick_rot_lerped, pick_rot, 0.1);
}

// Timer skip early
if (win or lose) and (timer_skip_time > timer_skip_threshold) {
	microgame_end_early();
}

// "Frustum culler"
var _x = x, _y = y, _aim_dir = aim_dir;
with baku_mine_obj_frustum_culler {
	x = _x;
	y = _y;
	image_angle = _aim_dir + 45;
}

#region Lights
	
	// Don't update them after roundabout, so they don't flicker
	if !roundabout_started {
		
		// Clear light arrays
		clear_lights();
		
		// Creeper
		if creeper_spawned {
			var _len_front = 40;
			var _x = x + (dcos(-creeper_aim_dir) * _len_front);
			var _y = y + (dsin(-creeper_aim_dir) * _len_front);
			var _z = cam.z_from - 24;
			array_push(lights, create_light(_x, _y, _z, 64 + random_range(-4, 4), 0x3fab63, dsin(creeper_flash) * 0.15 + 0.15));
		}
		
		// Torches
		var _torch_count = instance_number(baku_mine_obj_block_torch);
		for (var i = 0; i < _torch_count; ++i) {
			var _inst = instance_find(baku_mine_obj_block_torch, i);
			array_push(lights, create_light(_inst.x, _inst.y, _inst.z, 64 + random_range(-4, 4), 0x3389ff, random_range(0.3, 0.35)));
		}
		
		// Ore
		var _torch_count = instance_number(baku_mine_obj_block_ore);
		for (var i = 0; i < _torch_count; ++i) {
			var _inst = instance_find(baku_mine_obj_block_ore, i);
			array_push(lights, create_light(_inst.x, _inst.y, _inst.z, 32, _inst.glow_col, _inst.glow_alpha));
		}
		
		// Drop
		var _torch_count = instance_number(baku_mine_obj_drop);
		for (var i = 0; i < _torch_count; ++i) {
			var _inst = instance_find(baku_mine_obj_drop, i);
			array_push(lights, create_light(_inst.x, _inst.y, _inst.z, 32, _inst.glow_col, _inst.glow_alpha));
		}
		
		// Creeper
		var _torch_count = instance_number(baku_mine_obj_creeper_or_stone);
		for (var i = 0; i < _torch_count; ++i) {
			var _inst = instance_find(baku_mine_obj_creeper_or_stone, i);
			if _inst.is_glowing array_push(lights, create_light(_inst.x, _inst.y, _inst.z, 32, _inst.glow_col, _inst.glow_alpha));
		}
		
		// Pad the lights array if too smol
		while array_length(lights) < MAX_LIGHT_COUNT {
			array_push(lights, create_light());
		}
		
		// Create light arrays for the shader boy
		// If the lights array is somehow longer than MAX_LIGHT_COUNT then just ignore the lights above it lmao, sucks to suck I guess
		for (var i = 0; i < MAX_LIGHT_COUNT; ++i) {
			// Pos
			array_push(light_pos, lights[i][baku_mine_light.x]);
			array_push(light_pos, lights[i][baku_mine_light.y]);
			array_push(light_pos, lights[i][baku_mine_light.z]);
			array_push(light_pos, lights[i][baku_mine_light.radius]);
			// Col
			array_push(light_col, lights[i][baku_mine_light.r]);
			array_push(light_col, lights[i][baku_mine_light.g]);
			array_push(light_col, lights[i][baku_mine_light.b]);
			array_push(light_col, lights[i][baku_mine_light.a]);
		}
		
	}
	
#endregion

// Prompt display stuff
prompt_wait = approach(prompt_wait, 0, 1);
if !prompt_wait {
	prompt_scale = lerp(prompt_scale, 1.5, prompt_lerp);
	prompt_y = lerp(prompt_y, 24, prompt_lerp);
	prompt_col_merge += 0.0025;
	prompt_col = merge_colour(c_gbwhite, c_gbpink, clamp(prompt_col_merge, 0, 1));
	prompt_shake += 0.01;
}