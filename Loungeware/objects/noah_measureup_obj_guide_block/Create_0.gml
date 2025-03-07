
guide_width = sprite_width;
guide_height = sprite_height;


create_block = function()
{
	instance_create_depth(x,y, depth - 1, noah_measureup_obj_block, {width: guide_width, height: guide_height})
	image_alpha = 0;
}


