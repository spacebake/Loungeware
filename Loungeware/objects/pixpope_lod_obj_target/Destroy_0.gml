/// @description Insert description here
// You can write your code in this editor
pixpope_lod_obj_camera.start(0, 20); 
pixpope_lod_obj_camera.flash(10);

repeat(3){
	var _x = x + random_range(-sprite_width / 2, sprite_width / 2);
	var _y = y + random_range(-sprite_height / 2, sprite_height / 2);
	instance_create_depth(_x, _y, depth-1, pixpope_lod_obj_explosion);
}

instance_create_depth(x, y, depth, pixpope_lod_obj_target_destroyed, 
	{
		sprite_index: sprite_index, 
		image_index: image_index, 
		image_xscale: image_xscale, 
		image_yscale: image_yscale, 
		image_blend: image_blend,
	}
);


