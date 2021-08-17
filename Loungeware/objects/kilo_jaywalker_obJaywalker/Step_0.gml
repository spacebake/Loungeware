if (jay_state = "safe")
{
//Gather Input
hcoord = (KEY_RIGHT - KEY_LEFT);
vcoord = (KEY_DOWN - KEY_UP);

direction = point_direction(0,0,hcoord,vcoord);

if (KEY_LEFT or KEY_RIGHT or KEY_DOWN or KEY_UP)
{
	speed = 1;
	image_speed = img_speed;
}
else
{
	speed = 0;
	image_speed = 0;
}


//Animate the Sprite
if (KEY_DOWN)
{
	sprite_index = kilo_jaywalker_sprJayWalkerDown;
}

if (KEY_UP)
{
	sprite_index = kilo_jaywalker_sprJayWalkerUp;
	if (image_index = 2)
	{
		img_speed = -1;	
	}

	if (image_index = 0)
	{
		img_speed = 1;
	}
	
}

if (KEY_LEFT or KEY_RIGHT)
{
	sprite_index = kilo_jaywalker_sprJayWalkerSide;
	if (image_index = 2)
	{
		img_speed = -1;	
	}

	if (image_index = 0)
	{
		img_speed = 1;
	}
}

if (KEY_RIGHT - KEY_LEFT != 0)
{
	image_xscale = KEY_RIGHT - KEY_LEFT;
}

if (image_speed = 0)
{
	image_index = 0;
}

//Staying Within the Room
if (x < abs(sprite_width) / 2 + 4) {x = abs(sprite_width) / 2 + 4;}
if (x > room_width - sprite_width / 2 - 4) {x = room_width - sprite_width / 2 - 4;}
if (y < sprite_height / 2 + 4) {y = sprite_height / 2 + 4;}
if (y > room_height - sprite_height / 2 - 4) {y = room_height - sprite_height / 2 - 4;}

//Winning
if (x >= 196)
{
	microgame_win();
}

depth = -y;

if (place_meeting(x,y,kilo_jaywalker_objCar))
{
	jay_state = "crashed";
	speed = 5;
	direction = sign(instance_nearest(x,y,kilo_jaywalker_objCar).spd) * 90 + irandom_range(10,-10);
	image_speed = 0;
}
}

if (jay_state = "crashed")
{
	if (y > room_height + sprite_height) or (y < -sprite_height)
	{
		speed = 0;
	}
}

if (jay_state == "win")
{
	
}