/// @desc Check collision.
if (point_distance(0, 0, x, y) < 20 && alarm[0] == -1) {
    microgame_win();
    alarm[0] = 2 * game_get_speed(gamespeed_fps);
    katsaii_witchsplore_player.freezePlayer = true;
}