if (!landed and !touched_ground)
{
	landed = true;
	sprite_index = noah_measureup_spr_block_green;
	sfx_play(noah_measureup_sfx_block, 1.5);
	microgame_win();
}