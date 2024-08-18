/// @description Insert description here
// You can write your code in this editor

image_xscale = 0.5
image_yscale = 0.5


	var _snd_id = sfx_play(wae_snd_missle_missleexplode, random_range(0.3,0.5), 0);
	audio_sound_pitch(_snd_id, random_range(0.8,1.2));
	var _snd_id = sfx_play(wae_snd_missle_exploderumble, random_range(1,1.2), 0);
	audio_sound_pitch(_snd_id, random_range(0.8,1.2));

