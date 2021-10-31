/// @description Shadows

/// @description  Draw Shadows
// Create surface
if (!surface_exists(shadow_surface))
{
    shadow_surface = surface_create(room_width, room_height);
}

// Draw on the surface
surface_set_target(shadow_surface);
draw_clear_alpha(c_black, 0);
gpu_set_fog(true, c_black, 0, 1);

// Draw on surface for each object
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
	// Draw shadow
	draw_sprite_part_ext(
		sprite_index,
		0,
		0,
		0,
		sprite_width,
		height,
		x - sprite_width/2,
		y + height/2,
		1,
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


