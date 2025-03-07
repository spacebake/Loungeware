if (!touched_ground)
{
	touched_ground = true;
	sprite_index = noah_measureup_spr_block_red;
	sfx_play(noah_measureup_sfx_fail, 1.5);
	microgame_fail();
}
