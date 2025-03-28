
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
	if(stop == false){
		sfx_play(tabi_gogogatsby_explosion);
	}
	
	stop = true;
	microgame_fail();
	
	if(alarm[1] == -1){
		//end the game for realz
		alarm[1] = 3;
	}
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
