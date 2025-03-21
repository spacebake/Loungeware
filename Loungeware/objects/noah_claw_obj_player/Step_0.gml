
if (crane_active)
{
	var _vertInput = KEY_DOWN - KEY_UP;
	y += _vertInput * crane_speed;
	y = clamp(y, 0, goal_y);
}

// fail condition
var _bulletInst = instance_place(x, y, noah_claw_obj_bullet_parent)
if (_bulletInst and !success and !falling)
{
	instance_create_depth(x, y, depth - 1, noah_claw_obj_hit_fx);
	crane_active = false;
	falling = true;
	sfx_play(noah_claw_sfx_rip);
	cable_stay_y = y;
}

if (falling)
{
	image_angle += 5;;
	y += crane_speed;
	microgame_fail();
}

if (y == goal_y and !falling and !success)
{
	crane_active = false;
	success = true;
	with(noah_claw_obj_bullet_parent)
	{
		shrinking = true;	
	}
	with (noah_claw_obj_emitter_parent)
	{
		instance_destroy();
	}
	sfx_play(noah_claw_sfx_win);
	microgame_win();
}

if (success)
{
	y = lerp(y, success_y, lerp_speed);
	if (abs(y - success_y) < 0.1)
	{
		x -= crane_speed;	
	}
}