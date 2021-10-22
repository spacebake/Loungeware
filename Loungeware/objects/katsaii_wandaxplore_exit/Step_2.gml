/// @desc Check collision.
if (point_distance(0, 0, x, y) < 10 && !katsaii_wandaxplore_player.freezePlayer) {
    microgame_win();
    katsaii_wandaxplore_player.alarm[0] = 2 * game_get_speed(gamespeed_fps);
    katsaii_wandaxplore_player.freezePlayer = true;
    var snd = sfx_play(katsaii_wandaxplore_win, 1, false);
    audio_sound_pitch(snd, choose(1.2, 1.1, 0.8));
}