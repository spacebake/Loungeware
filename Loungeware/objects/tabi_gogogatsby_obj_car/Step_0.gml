
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
	stop = true;
	microgame_fail()
	microgame_end_early()
}

//failed the microgame by crashing
if(stop){
	//make explosion
	if(made_particle == false){
		part_particles_create(p_system, x+50, y+60, p_explode, 2);
		made_particle = true;
	}
	
	x-=5;
}
