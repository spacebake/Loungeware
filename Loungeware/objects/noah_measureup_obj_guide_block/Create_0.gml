
guide_width = sprite_width;
guide_height = sprite_height;


create_block = function()
{
	// Create the object that "uses physics" only if the platform is windows
	if (os_browser == browser_not_a_browser) // platform is windows
	{
		instance_create_depth(x,y, depth - 1, noah_measureup_obj_block_windows, {width: guide_width, height: guide_height})
		image_alpha = 0;
	}
	else // being played in browser
	{
		instance_create_depth(x,y, depth - 1, noah_measureup_obj_block, {width: guide_width, height: guide_height})
		image_alpha = 0;
	}
}


