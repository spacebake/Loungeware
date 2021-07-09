x += random_range(4, 5);
y += random_range(-1.5, 1.5);
if (x > yosi_EFT_obj_building.x)
	{
	yosi_EFT_obj_game.fire_hp--;
	instance_destroy();
	}