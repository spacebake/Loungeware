if (state == "ladder" || state == "climb" || state == "spray" || state == "drop")
	{
	for(var i = ladder_y; i < y + 8; i += 8)
		{
		if (i == ladder_y)
			{
			draw_sprite(yosi_EFT_spr_ladder, 1, x + 8, i);
			}
		else
			{
			draw_sprite(yosi_EFT_spr_ladder, 0, x + 8, i);
			}
		}
	}
if (state == "climb" || state == "spray" || state == "drop")
	{
	draw_sprite(yosi_EFT_spr_fireman, 0, x + 8, player_y);
	}
draw_self();