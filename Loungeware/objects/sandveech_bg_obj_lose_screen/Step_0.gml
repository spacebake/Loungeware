// sandveech_bg_obj_lose_screen.step

if (!audio_is_playing(sandveech_bg_snd_shoot) && (floor(image_index == 6))) {
	audio_play_sound(sandveech_bg_snd_shoot, 0, false);
}