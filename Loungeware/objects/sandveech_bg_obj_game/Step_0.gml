// sandveech_bg_obj_game.step

if (TIME_REMAINING_SECONDS == 2) {
	if (!check_win()) {
		clear_game();
		instance_create_depth(0, 0, 0, sandveech_bg_obj_lose_screen);
	}
	else {
		microgame_win();
		clear_game();
	}
}