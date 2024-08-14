// sandveech_bg_obj_game.step

var _arm = sandveech_bg_obj_arm;
if (instance_exists(_arm)) {
		
}

if (TIME_REMAINING_SECONDS == 2) {
	if (!check_win()) {
		clear_game();
		instance_create_depth(0, 0, 0, sandveech_bg_obj_lose_screen);
	}
	else {
		microgame_win();
		clear_game();
		instance_create_depth(0, 0, 0, sandveech_bg_obj_win_screen);
	}
}