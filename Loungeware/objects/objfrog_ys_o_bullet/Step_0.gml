/// @description Collision
next_x = x + lengthdir_x(speed, direction);
next_y = y + lengthdir_y(speed, direction);

target_hit = collision_line(x, y, next_x, next_y, objfrog_ys_o_target, false, true);

if (target_hit) {
	instance_destroy(target_hit);
	instance_destroy();
}
