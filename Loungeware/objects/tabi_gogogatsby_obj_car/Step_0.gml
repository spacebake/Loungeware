
if KEY_UP_PRESSED
{
	y = lane_one
	image_index = 1;
	alarm[0] = sprite_change_time;
}

if KEY_DOWN_PRESSED
{
	y = lane_two
	image_index = 1;
	alarm[0] = sprite_change_time;
}

if place_meeting(x,y,tabi_gogogatsby_obj_character)
{
	microgame_fail()
	microgame_end_early()
}