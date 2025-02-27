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
	else if (sprite_index != noah_cheat_spr_student_lose)
	{
		sprite_index = noah_cheat_spr_student_lose;
		image_index = 0;
	}
}


if (KEY_DOWN_PRESSED)
{
	instance_create_depth(x + 270, y + 204, depth - 1, noah_cheat_obj_particle);
}