for(var i = 0; i < size; i++)
	{
	draw_sprite(yosi_EFT_spr_tower, 0, x, y - (i * 16));
	}
if (fire)
	draw_sprite_ext(yosi_EFT_spr_tower, 1, x, y - (i * 16), 1, 1, 0, make_color_hsv(irandom(40), 255, 255), 1);
else
	draw_sprite_ext(yosi_EFT_spr_tower, 1, x, y - (i * 16), 1, 1, 0, c_white, 1);