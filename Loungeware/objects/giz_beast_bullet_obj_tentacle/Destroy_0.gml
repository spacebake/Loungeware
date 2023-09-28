instance_create_layer(x, y, layer, giz_beast_bullet_obj_tentacle_debris, {
	direction	: giz.math.rand(360),
	speed		: giz.math.rand(2, 4),
	image_blend : image_blend,
	image_xscale: image_xscale * xscale,
	image_yscale: image_yscale,
	sprite_index: sprite_index,
	image_index : image_index
});
