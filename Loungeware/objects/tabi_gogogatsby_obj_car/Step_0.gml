if KEY_UP_PRESSED
{
	y = lane_one
}

if KEY_DOWN_PRESSED
{
	y = lane_two
}

if place_meeting(x,y,tabi_gogogatsby_obj_character)
{
	microgame_fail()
	microgame_end_early()
}