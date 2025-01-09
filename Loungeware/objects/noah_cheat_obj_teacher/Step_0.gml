/// @description Manage states

if (noah_cheat_obj_meter.game_active)
{
	state_timer += delta_time / 1000000;
	
	if (timeline_pos < max_timeline_pos)
	{
		if (state_timer >= toggle_suspicion_times[timeline_pos])
		{
			timeline_pos ++;
			currently_sus = !currently_sus;
			// Update sprite
			sprite_index = (currently_sus)?(noah_cheat_spr_teacher_sus):(noah_cheat_spr_teacher_idle);
		}
	}
	// manage sus state, trigger loss if mashing time during sus state exceeds threshold
	if (currently_sus)
	{
		if (noah_cheat_obj_meter.currently_mashing)
		{
			mashing_while_sus_stopwatch += delta_time / 1000000;
			if (mashing_while_sus_stopwatch >= suspicion_threshold)
			{
				// Enter lose state
				microgame_fail();
				sprite_index = noah_cheat_spr_teacher_watch;
				noah_cheat_obj_meter.game_result_win = false;
				noah_cheat_obj_meter.game_active = false;
			}
		}
		else
		{
			mashing_while_sus_stopwatch = 0;
		}
	}
}
else
{
	if (noah_cheat_obj_meter.game_result_win)
	{
		sprite_index = noah_cheat_spr_teacher_win;
	}
	else
	{
		loss_timer += delta_time / 1000000;
		if (loss_timer >= loss_viewtime)
		{
			microgame_end_early(); // no need to wait around all day
		}
	}
}

