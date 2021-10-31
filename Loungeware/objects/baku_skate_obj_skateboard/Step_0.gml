
// Spd
spd = (baku_skate_obj_game.spd_og - baku_skate_obj_game.spd) * 0.5;

// Move
board_x += lengthdir_x(spd, dir);
board_y += lengthdir_y(spd, dir);

// Grav
y_spd += grav;

// Grounded
if jump_y >= 0 {
	// jump_spd *= 0.75;
	y_spd = -jump_spd;
	
	// Bounce sfx
	sfx_play(baku_skate_snd_hit, 0.5, false);
	
	// Clouds (small)
	repeat irandom_range(4, 8) {
		var _x = board_x + random_range(-16, 16);
		var _y = board_y + random_range(-8, 8);
		var _inst = instance_create_layer(_x, _y, layer, baku_skate_obj_cloud);
		_inst.image_index = choose(0, 1, 2, 3, 4, 5, 6);
		_inst.spd = baku_skate_obj_game.spd;
		_inst.dir = baku_skate_obj_game.world_angle;
	}
}

// Move y
jump_y += y_spd;

// Clamp jump y
if jump_y >= 0 {
	jump_y = 0;
}

board_dir -= 10;