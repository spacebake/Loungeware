if (kilo_jaywalker_cooldown_left <= 0)
{
	with instance_create_layer(16 * (3 + irandom_range(0,3)), -17, "Instances", kilo_jaywalker_objCar)
	{
		image_index = irandom_range(0,3);
		
	}
	kilo_jaywalker_cooldown_left = random_range(0.5,1) * 60;
}

if (kilo_jaywalker_cooldown_right <= 0)
{
	with instance_create_layer(16 * (8 + irandom_range(0,3)), room_height + 17, "Instances", kilo_jaywalker_objCar)
	{
		image_index = irandom_range(4,7);
		
	}
	kilo_jaywalker_cooldown_right = random_range(0.5,1) * 60;
}


kilo_jaywalker_cooldown_left --;
kilo_jaywalker_cooldown_right --;