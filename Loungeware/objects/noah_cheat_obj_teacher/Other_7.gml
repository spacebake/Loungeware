/// @description Transition to rage after turning
if (sprite_index == noah_cheat_spr_teacher_watch)
{
	sprite_index = noah_cheat_spr_teacher_rage;
	image_index = 0;
}
else if (sprite_index == noah_cheat_spr_teacher_rage)
{
	sprite_index = noah_cheat_spr_teacher_rage;
	image_speed = 0;
	image_index = image_number - 1;
}
else if (sprite_index == noah_cheat_spr_teacher_win)
{
	image_index = image_number - 1;
	image_speed = 0;
}



