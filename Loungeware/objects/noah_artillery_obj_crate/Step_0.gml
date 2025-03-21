/// @description Insert description here
// You can write your code in this editor

if (instance_place(x, y, noah_artillery_obj_explosion))
{
	repeat(3)
	{
		instance_create_depth(x, y, depth - 1, noah_artillery_obj_crate_bit);
		sfx_play(noah_artillery_sfx_crate_destroy);
	}
	instance_destroy();
}


