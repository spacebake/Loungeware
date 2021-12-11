objfrog_pp_draw_self_3d();

if (objfrog_pp_o_spot.triggered) {
	exit;	
}

var draw_x = x - (sprite_get_width(spr_button_a)/2);
var draw_y = y - 32;

if (velocity == 0) {
	draw_sprite(spr_button_a, button_subimg, draw_x, draw_y);
}

var x_infront = x + lengthdir_x(1, image_angle);
var y_infront = y + lengthdir_y(1, image_angle);
if (place_meeting(x_infront, y_infront, objfrog_pp_o_collision_parent)) {
	draw_sprite(spr_button_b, button_subimg, draw_x, draw_y);
}
