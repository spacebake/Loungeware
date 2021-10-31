/// @description Trail
var ghost = instance_create_depth(x, y, depth, objfrog_ys_o_bullet_ghost);
ghost.positions = { x1: x, y1: y, x2: xprevious, y2: yprevious };