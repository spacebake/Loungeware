if (image_index > 4)
{
	y -= spd;
}
else
{
	y += spd;
}

if ((image_index < 4 and y > room_height + sprite_height) or (image_index > 3 and y < -sprite_height))
{
	instance_destroy(id,false);
}

depth = -y - sprite_height / 2;

