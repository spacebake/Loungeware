/// @desc Check collision.
if (point_distance(0, 0, x, y) < 10 && katsaii_witchsplore_player.alarm[0] == -1) {
    microgame_win();
    katsaii_witchsplore_player.alarm[0] = 2 * game_get_speed(gamespeed_fps);
    katsaii_witchsplore_player.freezePlayer = true;
}