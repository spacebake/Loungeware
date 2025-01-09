/// @description Handle mashing

/// handle mashing and meter fill if game hasn't been won or lost yet
if (game_active)
{
	// handle input
	if (KEY_ANY_PRESSED)
	{
		input_count ++;
		input_count = clamp(input_count, 0, input_goal);
		currently_mashing = true;
		mashing_cooldown_timer = mashing_cooldown;
	}

	// run timers
	if (mashing_cooldown_timer > 0)
	{
		mashing_cooldown_timer -= delta_time / 1000000; // decrement seconds
	}
	else
	{
		currently_mashing = false;
		mashing_cooldown_timer = 0;
	}

	meter_fill = input_count / input_goal;
}


// check for win
if (meter_fill == 1)
{
	game_active = false;
	game_result_win = true;
	microgame_win();
}