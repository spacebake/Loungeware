/// @description Change State

if (noah_cheat_obj_meter.game_active)
{
	if (noah_cheat_obj_meter.currently_mashing)
	{
		sprite_index = noah_cheat_spr_student_cheating;	
	}
	else
	{
		sprite_index = noah_cheat_spr_student_idle;	
	}
}
else
{
	if (noah_cheat_obj_meter.game_result_win)
	{
		sprite_index = noah_cheat_spr_student_win;
	}
	else
	{
		sprite_index = noah_cheat_spr_student_lose;
	}
}
