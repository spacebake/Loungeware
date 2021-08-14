frame++;
var _mash = sign
	(
	KEY_PRIMARY_PRESSED +
	KEY_SECONDARY_PRESSED +
	KEY_RIGHT_PRESSED +
	KEY_UP_PRESSED +
	KEY_LEFT_PRESSED +
	KEY_DOWN_PRESSED
	);
if (_mash)
	{
	yosi_EFT_obj_game.screen_x += 0.5;
	yosi_EFT_obj_game.screen_y += 0.5;
	}
if (state != "drop" && state != "driveaway")
	{
	if (!audio_is_playing(yosi_EFT_snd_siren)) 
		sfx_play(yosi_EFT_snd_siren, 0.1, true);
	}
else
	sfx_stop(yosi_EFT_snd_siren, 0);
switch(state)
	{
	case "drive":
		x += 1;
		if (_mash)
			{
			x += 5;
			sfx_play(yosi_EFT_snd_drive, 0.2, false);
			}
		if (x > yosi_EFT_obj_building.x - 50)
			{
			x = yosi_EFT_obj_building.x - 50;
			state = "ladder";
			ladder_y = y;
			}
		if (frame % 10 == 0)
			{
			sfx_play(yosi_EFT_snd_drive, 0.1, false);
			}
		break;
	case "ladder":
		ladder_y--;
		if (_mash) then ladder_y -= 5;
		if (ladder_y <= yosi_EFT_obj_building.y - (16 * yosi_EFT_obj_building.size))
			{
			ladder_y = yosi_EFT_obj_building.y - (16 * yosi_EFT_obj_building.size);
			state = "climb";
			player_y = y;
			}
		break;
	case "climb":
		player_y--;
		if (_mash) then player_y -= 5;
		if (player_y <= ladder_y)
			{
			player_y = ladder_y;
			state = "spray";
			water_sound = sfx_play(yosi_EFT_snd_water, 0.25, true);
			}
		break;
	case "spray":
		if (yosi_EFT_obj_game.building_hp % 4 == 0) then instance_create_layer(x + 10, player_y, layer, yosi_EFT_obj_water);
		if (_mash)
			{
			audio_sound_gain(water_sound, 0.5 * audio_sound_get_gain(yosi_EFT_snd_water) * VOL_SFX * VOL_MASTER, 0);
			repeat(3) 
				{
				with(instance_create_layer(x + 10, player_y, layer, yosi_EFT_obj_water))
					{
					vspeed = random_range(-1, 1);
					}
				}
			}
		else
			{
			audio_sound_gain(water_sound, 0.25 * audio_sound_get_gain(yosi_EFT_snd_water) * VOL_SFX * VOL_MASTER, 0);
			}
		if (yosi_EFT_obj_game.fire_hp <= 0)
			{
			yosi_EFT_obj_building.fire = false;
			state = "drop";
			sfx_stop(yosi_EFT_snd_water, 200);
			sfx_play(yosi_EFT_snd_win, 0.6, false);
			}
		break;
	case "drop":
		if (player_y < y)
			{
			player_y++;
			ladder_y++;
			if (_mash)
				{
				player_y++;
				ladder_y++;
				}
			}
		else
			{
			state = "driveaway";
			}
		break;
	case "driveaway":
		x += 1;
		if (_mash)
			{
			x += 5;
			sfx_play(yosi_EFT_snd_drive, 0.2, false);
			}
		if (x > room_width)
			{
			microgame_win();
			if (alarm[0] == -1)
				{
				alarm[0] = 60; // early exit after a few seconds of winning, added by Kat
				}
			}
		if (frame % 10 == 0)
			{
			sfx_play(yosi_EFT_snd_drive, 0.1, false);
			}
		break;
	}