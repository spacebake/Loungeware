baku_mine_player_update_prompt();

// Game loop
if prompt_setup_done and !win and !lose and !creeper_spawned {
	
	baku_mine_player_update_movement();
	baku_mine_player_update_mining();
}

// Win conditions
baku_mine_player_update_non_win_condition();
baku_mine_player_update_win_condition();

// Timer skip early
if (win or lose) and (timer_skip_time > timer_skip_threshold) microgame_end_early();

// Lighting
baku_mine_player_update_lights();


