
spd = 0;
dir = baku_skate_obj_game.world_angle;

board_x = x;
board_y = y;

shadow_sprite = baku_skate_spr_mimpy_hit_shadow;
board_dir = 0;

// Bouncing
jump_y = -1;
grav = 0.23 + (DIFFICULTY * 0.01);
jump_spd = 7 - ((5 - DIFFICULTY) * 0.162);
y_spd = -jump_spd;

// Map function
map = function(value, old_min, old_max, new_min, new_max) {
	// Note: output value is not clamped to the ranges, keep that in mind!
	return lerp(new_min, new_max, (value - old_min) / (old_max - old_min));
}