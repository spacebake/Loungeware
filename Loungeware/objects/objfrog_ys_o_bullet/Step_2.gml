/// @description Trail
var ghost = instance_create_depth(x, y, depth, objfrog_ys_o_bullet_ghost);
ghost.positions = { x1: x, y1: y, x2: xprevious, y2: yprevious };

if (target_hit) {
	var ghost = instance_create_depth(next_x, next_y, depth, objfrog_ys_o_bullet_ghost);
	ghost.positions = { x1: next_x, y1: next_y, x2: x, y2: y };
}
