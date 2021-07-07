draw_sprite_ext(
	sprite_index,
	image_index,
	x,
	floor(y - (15 - abs(image_angle) * 0.5)),
	dir,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
);