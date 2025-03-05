if (instance_place(x, y, noah_artillery_obj_explosion) and !dead)
{
	microgame_win();
	image_index = 0;
	image_speed = 3;
	sprite_index = noah_artillery_spr_enemy_die;
	dead = true;
	sfx_play(noah_artillery_sfx_mech_destroy);
}