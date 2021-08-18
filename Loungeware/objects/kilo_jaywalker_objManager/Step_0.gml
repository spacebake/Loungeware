if (cooldown_left <= 0)
{
	
	with instance_create_layer(16 * (3 + irandom_range(0,3)), -17, "Instances", kilo_jaywalker_objCar)
	{
		if irandom_range(1,100) == 1
		{
			sprite_index = kilo_jaywalker_sprNetCar;
			image_index = 0;
		}
		else
		{
			image_index = irandom_range(0,3);
		}
	
	}
	cooldown_left = (random_range(0.5,1) - (DIFFICULTY / 10)) * 60;
}

if (cooldown_right <= 0)
{
	with instance_create_layer(16 * (8 + irandom_range(0,3)), room_height + 17, "Instances", kilo_jaywalker_objCar)
	{
		if irandom_range(1,100) == 1
		{
			sprite_index = kilo_jaywalker_sprNetCar;
			image_index = 4;
		}
		else
		{
			image_index = irandom_range(4,7);
		}
		
	}
	cooldown_right = (random_range(0.5,1) - (DIFFICULTY / 10)) * 60;
}


cooldown_left --;
cooldown_right --;