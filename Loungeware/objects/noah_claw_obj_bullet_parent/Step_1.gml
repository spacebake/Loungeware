/// @description Insert description here
// You can write your code in this editor

if (shrinking)
{
	image_xscale -= shrink_speed;
	image_yscale = image_xscale;
	if (image_xscale < 0)
	{
		instance_destroy();	
	}
}
