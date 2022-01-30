/// @desc
if (global.campfire_timer > 0)
{
	if (!surface_exists(light))
	{
		light = surface_create(room_width,room_height);	
	}

	surface_set_target(light);

	draw_clear_alpha(c_black, 0.6);

	with (josh_eyes_oLight)
	{
		var glow_ = random_range(glow, -glow);
	
		gpu_set_blendmode(bm_subtract);
		draw_sprite_ext(sprite_index, image_index, x,y, image_xscale + glow_,image_yscale + glow_, 0, col, 1);
		gpu_set_blendmode(bm_normal);
	}

	surface_reset_target();

	draw_surface(light, 0,0);
}
else
{
	if (!surface_exists(light))
	{
		light = surface_create(room_width,room_height);	
	}

	surface_set_target(light);

	draw_clear_alpha(c_black, 0.6);

	surface_reset_target();

	draw_surface(light, 0,0);
}