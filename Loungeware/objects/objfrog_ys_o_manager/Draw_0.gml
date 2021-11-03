/// @description Count & Shadows

// Target count
var targets_left = targets_to_make + instance_number(objfrog_ys_o_target);
draw_set_halign(fa_center);
draw_set_color(c_red);
draw_text(room_width/2, room_height - 16, targets_left);

// Create surface
if (!surface_exists(shadow_surface))
{
    shadow_surface = surface_create(room_width, room_height);
}

// Draw on the surface
surface_set_target(shadow_surface);
draw_clear_alpha(c_black, 0);
gpu_set_fog(true, c_black, 0, 1);

with (objfrog_ys_o_collision_parent)
{
	draw_sprite_ext(
		sprite_index,
		image_index,
		x,
		y,
		1,
		-.5,
		0,
		c_white,
		1,
	);
}

with (objfrog_ys_o_target) {
	draw_sprite_part_ext(
		sprite_index,
		image_index,
		0,
		0,
		sprite_width * image_xscale,
		height,
		x - sprite_width/2,
		y + height/2,
		image_xscale,
		-.5,
		c_white,
		1,
	);
}

// reset
gpu_set_fog(false, c_white, 0, 0);
surface_reset_target();

// Draw the surface
draw_set_alpha(.1);
draw_surface(shadow_surface, 0, 0);
draw_set_alpha(1);


