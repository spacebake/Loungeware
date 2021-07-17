
show_debug_message("step - prompt: " + string(PROMPT));

// Game loop
if !win and !lose {
	
	#region Player movement and such
		
		// Aim
		aim_dir -= (KEY_RIGHT - KEY_LEFT) * aim_spd;
		aim_pitch += (keyboard_check(ord("F")) - keyboard_check(ord("V"))) * aim_spd; // Debug pitch (if I forgot to comment this out please yell at me)
		
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
					if block_aim_id.object_index == baku_mine_obj_block_ore
						crack_img ++;
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
				if KEY_PRIMARY and crack_img > sprite_get_number(baku_mine_spr_crack) - 1 {
					with block_aim_id {
						// Create drop
						var _inst = instance_create_layer(x, y, layer, baku_mine_obj_drop);
						_inst.tex = drop_tex;
						_inst.z = z;
						_inst.glow_col = glow_col;
						_inst.glow_alpha = glow_alpha;
						
						// Handle creeper or stone dilemma
						baku_mine_obj_creeper_or_stone.tex = baku_mine_spr_stone_dark;
						
						// TODO: Particles
						
						// Destroy block
						instance_destroy();
					}
					
					// TODO: win or lose depending on the block was the right one
				}
			}
			
			if block_aim_id.object_index != baku_mine_obj_block_ore {
				crack_img = 0;
			}
		}
		
	#endregion
}

#region Lights
	
	// Clear light arrays
	clear_lights();
	
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
	
#endregion