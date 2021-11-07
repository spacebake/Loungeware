objfrog_pp_draw_self_3d();

draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);

var vsp = lengthdir_y(velocity, direction);
var v_collision = instance_place(x, y + vsp, objfrog_pp_o_collision_parent);
draw_text(x + 20, y, distance_to_object(v_collision))