/// @description Collision
next_x = x + lengthdir_x(speed, direction);
next_y = y + lengthdir_y(speed, direction);

hit_target = collision_line(x, y, next_x, next_y, objfrog_ys_o_target, false, true);

if (hit_target) {
	sfx_play(objfrog_ys_sfx_hit, 1, false);
	
	hit_target.hit = true;
	objfrog_ys_o_manager.targets_hit += 1;
	instance_destroy();
}
