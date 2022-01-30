/// @desc
x = clamp(x, 0, room_width - sprite_width);
y = clamp(y, 0, room_height - sprite_height);

if (vis == true) then visibility_timer--;
if (visibility_timer == 0)
{
	sprite_index = spr_index;
	vis = false;
	image_speed = 1;
}

if (vis == false) then invisibility_timer--;
if (invisibility_timer == 0)
{
	image_index = 0;
	image_speed = 1;
	sprite_index = spr_reverse;
	vis = true;
	
	reset_loop();
}

if (image_index > image_number - 1)
{
	image_speed = 0;
}

//if (sprite_index == spr.spr_dummy)
//{
//	if (image_index = image_number - 1)
//	{
//		image_speed = 0;	
//	}
//}