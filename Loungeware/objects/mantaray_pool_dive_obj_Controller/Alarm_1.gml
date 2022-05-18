if (!audio_fanfarre_played) {
	var _x = sfx_play(mantaray_pool_dive_snd_Fanfarre, 1, false);
	audio_sound_pitch(_x, 1.5);
	audio_fanfarre_played = true;
}
