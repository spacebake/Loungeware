if (delay <= 0)
{
	y = lerp(y,0,0.25);
}

if (delay == 0 and image_index == 0)
{
	___BUILTIN_AUDIO_PLAY_SOUND(kilo_jaywalker_sndWin,1,false);
}

delay --;

if (delay <= -120)
{
	microgame_end_early();
}

