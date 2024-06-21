/// @desc
if (win) {
	image_index = 0;
	image_speed = 0;
	exit;
}


if (global.campfire_timer <= 0)
{
	if (image_index <= image_number - 1)
	{
		image_speed = 1;
	}
	else
	{
		image_speed = 0;	
	}
}