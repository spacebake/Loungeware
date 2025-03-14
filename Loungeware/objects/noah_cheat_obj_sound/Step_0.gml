/// @description Insert description here
// You can write your code in this editor

if (noah_cheat_obj_meter.game_active)
{
	var _layerGain = audio_sound_get_gain(intense_music_layer);
	if (noah_cheat_obj_meter.currently_mashing)
	{
	
		if (_layerGain < 1)
		{
			microgame_sfx_set_gain(intense_music_layer, 1, fade_time);
		}
	}
	else
	{
		if (_layerGain > 0)
		{
			microgame_sfx_set_gain(intense_music_layer, 0, fade_time);
		}
	}
}
else
{
	if (!final_sfx_played)
	{
		sfx_stop(intense_music_layer, 0);
		microgame_music_stop();
		if (noah_cheat_obj_meter.game_result_win)
		{
			sfx_play(noah_cheat_sfx_victory, 1, false);
		}
		else
		{
			sfx_play(noah_cheat_sfx_fail_teacher, 1, false);
		}
		final_sfx_played = true;
	}
}