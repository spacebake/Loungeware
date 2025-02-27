

music_loop = microgame_music_start(noah_cheat_bgm_scribbling_1, 1, true);

intense_music_layer = sfx_play(noah_cheat_bgm_scribbling_2, 0, true);
fade_time = 0.01 * 1000;

final_sfx_played = false;

pencil_scratch_len = audio_sound_length(noah_cheat_sfx_scratching_pencil);
pencil_sound = noone;