
if (place_meeting(x, y, space_scooter_obj_scooter)){
	image_speed = 1;
	if (!met) image_index++;
	met = true;
}


image_speed = max(0, image_speed - (1/10));